# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
    packages = c(
        "tidyverse",
        "tidymodels",
        "glmnet",
        "bonsai",
        "lightgbm"
    ),
    # default format for storing targets
    format = "qs",
    # set memory to transient
    memory = "transient",
    repository = "local"
)

# Run the R scripts in the R/ folder with your custom functions:
suppressWarnings({tar_source("src")})
# tar_source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
    # data
    tar_target(
        name = flights,
        command = nycflights13::flights
    ),
    tar_target(
        name = weather,
        command = nycflights13::weather
    ),
    tar_target(
        name = flights_prepared,
        command = flights |> prepare_flights()
    ),
    tar_target(
        name = weather_prepared,
        command = weather |> prepare_weather()
    ),
    tar_target(
        full_data,
        flights_prepared |>
            inner_join(weather_prepared)
    ),
    # split
    tar_target(
        split,
        full_data |>
            initial_validation_split(strata = arr_delay)
    ),
    # extract training set
    tar_target(
        train_data,
        split |>
            training()
    ),
    # test set; do not touch until the end
    tar_target(
        test_data,
        split |>
            testing()
    ),
    # plot split
    tar_target(
        plot_split,
        bind_rows(
            split |>
                training() |>
                mutate(type = "training"),
            split |>
                validation() |>
                mutate(type = "validation"),
            split |>
                testing() |>
                mutate(type = "testing"),
        ) |>
            mutate(type = factor(type, levels = c("testing", "validation", "training"))) |>
            group_by(date = floor_date(date, "month"), type) |>
            count() |>
            ggplot(aes(x = date, y = n, fill = type)) +
            geom_col() +
            scale_fill_viridis_d()
    ),
    # examine missigness
    tar_target(
        plot_missing,
        train_data |>
            naniar::vis_miss(warn_large_data = F)
    ),
    # add settings for model tuning/eval
    tar_target(
        my_ctrl,
        control_resamples(
            event_level = "second",
            verbose = T,
            save_workflow = T
        ),
    ),
    tar_target(
        my_metrics,
        metric_set(
            yardstick::roc_auc,
            yardstick::pr_auc,
            yardstick::mn_log_loss
        )
    ),
    # add simple model as a baseline
    tar_target(
        baseline_wflow,
        workflow() |>
            add_model(
                logistic_reg()
            ) |>
            add_recipe(
                recipe(
                    arr_delay ~ air_time + distance,
                    data = train_data
                ) |>
                    step_impute_median(
                        all_numeric_predictors()
                    )
            )
    ),
    # evaluate model on validation set
    tar_target(
        baseline_tuned,
        baseline_wflow |>
            tune_grid(
                resamples = split |>
                    validation_set(),
                control = my_ctrl,
                metrics = my_metrics
            )
    ),
    # extract results
    tar_target(
        name = baseline_results,
        command =
            baseline_tuned |>
            collect_metrics() |>
            mutate(wflow_id = 'baseline_glm')
    ),
    # evaluate a penalized regression with all features
    # create a recipe incorporating predictors
    tar_target(
        flights_recipe,
        train_data |>
            # select only a subset as predictors
            select(arr_delay,
                   date,
                   dep_time,
                   carrier,
                   origin,
                   dest,
                   air_time,
                   distance) |>
            recipe(
                arr_delay ~ .,
                data = _) |>
            # set everything to ID by default
            update_role(
                everything(),
                -all_outcomes(),
                new_role = "id") |>
            # set other predictors
            add_role(
                date,
                dep_time,
                carrier,
                origin,
                dest,
                air_time,
                distance,
                new_role = "predictor"
            ) |>
            # craeate features for dates
            step_date(date, features = c("dow", "month")) |>
            step_holiday(date,
                         holidays = timeDate::listHolidays("US"),
                         keep_original_cols = FALSE
            ) |>
            # impute numeric
            step_impute_median(
                all_numeric_predictors()
            ) |>
            # nominal variables
            # novel
            step_novel(
                all_nominal_predictors()
            ) |>
            # unknown
            step_unknown(
                all_nominal_predictors()
            ) |>
            # dummy
            step_dummy(
                all_nominal_predictors()
            ) |>
            # remove zero variance
            step_zv(all_predictors()
            )
    ),
    tar_target(
        glmnet_mod,
        logistic_reg(
            penalty = tune::tune(),
            mixture = tune::tune()
        ) |>
            set_engine(engine = "glmnet")
    ),
    tar_target(
        glmnet_grid,
        expand_grid(
            penalty = 10^seq(-3, -0.75, length = 10),
            mixture = c(0, 0.5, 1)
        )
    ),
    # glmnet wflow
    tar_target(
        glmnet_wflow,
        workflow() |>
            add_model(glmnet_mod) |>
            add_recipe(
                flights_recipe |>
                    step_normalize(all_numeric_predictors())
            )
    ),
    # tune glmnet
    tar_target(
        glmnet_tuned,
        glmnet_wflow |>
            tune_grid(
                grid = glmnet_grid,
                resamples = split |> validation_set(),
                control = my_ctrl,
                metrics = my_metrics
            ),
    ),
    # get results
    tar_target(
        glmnet_results,
        glmnet_tuned |>
            collect_metrics() |>
            mutate(wflow_id = 'glmnet_flights')
    ),
    # lightgbm
    tar_target(
        lightgbm_mod,
        parsnip::boost_tree(
            mode = "classification",
            trees = tune::tune(),
            min_n = tune(),
            tree_depth = tune()) |>
            set_engine("lightgbm", objective = "binary")
    ),
    # create wflow
    tar_target(
        lightgbm_wflow,
        workflow() |>
            add_model(lightgbm_mod) |>
            add_recipe(
                flights_recipe
            )
    ),
    # tune
    tar_target(
        lightgbm_tuned,
        lightgbm_wflow |>
            tune_grid(
                grid = 5,
                resamples = split |> validation_set(),
                control = my_ctrl,
                metrics = my_metrics
            )
    ),
    # results
    tar_target(
        lightgbm_results,
        lightgbm_tuned |>
            collect_metrics() |>
            mutate(wflow_id = "lightgbm_flights")
    ),
    # bind together model metrics
    tar_target(
        name = valid_metrics,
        command =
            bind_rows(
                baseline_results,
                glmnet_results,
                lightgbm_results
            ) |>
            select(wflow_id, everything()) |>
            pivot_metrics()
    ),
    # write metrics to repository
    tar_target(
        write_metrics,
        valid_metrics |>
            mutate_if(is.numeric, round, 3) |>
            write_csv("targets-runs/valid_metrics.csv")
    ),
    # examine result on test set
    # select best model and refit on train+validation
    tar_target(
        best_model,
        lightgbm_tuned |>
            fit_best(metric = 'mn_log_loss')
    ),
    # predict test set
    tar_target(
        test_preds,
        best_model |>
            augment(test_data)
    ),
    # evaluate on test set
    tar_target(
        test_metrics,
        test_preds |>
            my_metrics(
                truth = arr_delay,
                .pred_late,
                event_level = 'second'
            )
    ),
    # refit model to full dataset
    tar_target(
        final_model,
        best_model |>
            fit(split$data) |>
            vetiver::vetiver_model(
                model_name = "flights_arr_delay",
                metadata = list(
                    metrics = test_metrics
                )
            )
    ),
    # create model board
    tar_target(
        model_board,
        pins::board_folder("models",
                           versioned = T)
    ),
    # pin model to board
    tar_target(
        model_pin,
        final_model |>
            pin_model(board = model_board)
    ),
    # write final metrics
    tar_target(
        write_test,
        test_metrics |>
            pivot_metrics() |>
            mutate_if(is.numeric, round, 3) |>
            write_csv("targets-runs/test_metrics.csv")
    ),
    # render report
    tar_render(
        name = report,
        path = "report.qmd",
        quiet = F

    )
)
