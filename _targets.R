# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

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
          step_impute_median(all_numeric_predictors())
      )
  )
)
