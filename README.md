# README


# flights

illustrating `targets` and `tidymodels` with `nycflights13` data

``` mermaid
graph LR
  style Legend fill:#FFFFFF00,stroke:#000000;
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Legend
    direction LR
    x2db1ec7a48f65a9b([""Outdated""]):::outdated --- xd03d7c7dd2ddda2b([""Stem""]):::none
  end
  subgraph Graph
    direction LR
    x9b0c9170b8902027(["best_model"]):::outdated --> x29f339361487eb61(["final_model"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> x29f339361487eb61(["final_model"]):::outdated
    x0f09e4c17eb3276c(["test_metrics"]):::outdated --> x29f339361487eb61(["final_model"]):::outdated
    xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated --> xe2705333dfe7c9b4(["glmnet_results"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> xd2cb6929a158530b(["plot_split"]):::outdated
    x0d6375e58e5b207c(["baseline_wflow"]):::outdated --> x633d349f0c4d35f8(["baseline_tuned"]):::outdated
    xed83340f200a6764(["my_ctrl"]):::outdated --> x633d349f0c4d35f8(["baseline_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x633d349f0c4d35f8(["baseline_tuned"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> x633d349f0c4d35f8(["baseline_tuned"]):::outdated
    x1ecdaec783393d35(["glmnet_grid"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xf06d6eef7829004f(["glmnet_wflow"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xed83340f200a6764(["my_ctrl"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> xf7b68bfa4f5b3a26(["glmnet_tuned"]):::outdated
    xad2d2a7a16304874(["lightgbm_wflow"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    xed83340f200a6764(["my_ctrl"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> x3045fd98bf132297(["lightgbm_tuned"]):::outdated
    x9774927add83534a(["full_data"]):::outdated --> xe28457b7180d9865(["split"]):::outdated
    x50558fc6e6286095(["train_data"]):::outdated --> x0d6375e58e5b207c(["baseline_wflow"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> x50558fc6e6286095(["train_data"]):::outdated
    x0f09e4c17eb3276c(["test_metrics"]):::outdated --> xae90e4e03e9da6f6(["write_test"]):::outdated
    x3045fd98bf132297(["lightgbm_tuned"]):::outdated --> x9b0c9170b8902027(["best_model"]):::outdated
    xf4454ed4827f39ab(["flights_recipe"]):::outdated --> xad2d2a7a16304874(["lightgbm_wflow"]):::outdated
    xec3a6239d23d9fb4(["lightgbm_mod"]):::outdated --> xad2d2a7a16304874(["lightgbm_wflow"]):::outdated
    x3045fd98bf132297(["lightgbm_tuned"]):::outdated --> xcc98cb49ce297ec1(["lightgbm_results"]):::outdated
    x29f339361487eb61(["final_model"]):::outdated --> x49a9fc81583844b3(["model_pin"]):::outdated
    xc24813344827e171(["model_board"]):::outdated --> x49a9fc81583844b3(["model_pin"]):::outdated
    xf4454ed4827f39ab(["flights_recipe"]):::outdated --> xf06d6eef7829004f(["glmnet_wflow"]):::outdated
    xe7c688145125e4e7(["glmnet_mod"]):::outdated --> xf06d6eef7829004f(["glmnet_wflow"]):::outdated
    x50558fc6e6286095(["train_data"]):::outdated --> xf4454ed4827f39ab(["flights_recipe"]):::outdated
    x1bddabfef734c169(["my_metrics"]):::outdated --> x0f09e4c17eb3276c(["test_metrics"]):::outdated
    x4cdedcb3a02ef6bb(["test_preds"]):::outdated --> x0f09e4c17eb3276c(["test_metrics"]):::outdated
    xc24813344827e171(["model_board"]):::outdated --> xb72891f20a5b8df1(["report"]):::outdated
    x49a9fc81583844b3(["model_pin"]):::outdated --> xb72891f20a5b8df1(["report"]):::outdated
    x9b0c9170b8902027(["best_model"]):::outdated --> x4cdedcb3a02ef6bb(["test_preds"]):::outdated
    xbb782543df7528d1(["test_data"]):::outdated --> x4cdedcb3a02ef6bb(["test_preds"]):::outdated
    x633d349f0c4d35f8(["baseline_tuned"]):::outdated --> xfa066c31cda349b9(["baseline_results"]):::outdated
    x50558fc6e6286095(["train_data"]):::outdated --> xd0e10a259837a1c5(["plot_missing"]):::outdated
    x0b21886200383afb(["flights"]):::outdated --> xa53022e1b3b7315a(["flights_prepared"]):::outdated
    xe0bb173f910bd7f0(["valid_metrics"]):::outdated --> xbc2f8d07f8113aa5(["write_metrics"]):::outdated
    x849d840ef22b54a9(["weather"]):::outdated --> x9fde742fe0a2565f(["weather_prepared"]):::outdated
    xfa066c31cda349b9(["baseline_results"]):::outdated --> xe0bb173f910bd7f0(["valid_metrics"]):::outdated
    xe2705333dfe7c9b4(["glmnet_results"]):::outdated --> xe0bb173f910bd7f0(["valid_metrics"]):::outdated
    xcc98cb49ce297ec1(["lightgbm_results"]):::outdated --> xe0bb173f910bd7f0(["valid_metrics"]):::outdated
    xa53022e1b3b7315a(["flights_prepared"]):::outdated --> x9774927add83534a(["full_data"]):::outdated
    x9fde742fe0a2565f(["weather_prepared"]):::outdated --> x9774927add83534a(["full_data"]):::outdated
    xe28457b7180d9865(["split"]):::outdated --> xbb782543df7528d1(["test_data"]):::outdated
  end
  classDef outdated stroke:#000000,color:#000000,fill:#78B7C5;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
```

# model runs

## validation

``` r
valid_metrics = read.csv("targets-runs/valid_metrics.csv")

valid_metrics |>
    dplyr::arrange(mn_log_loss) |>
    gt::gt() |>
    gt::as_raw_html()
```

<div id="oepcwkvcoh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| wflow_id | .estimator | n | std_err | .config | penalty | mixture | trees | min_n | tree_depth | mn_log_loss | pr_auc | roc_auc |
|:---|:---|---:|:--:|:---|---:|---:|---:|---:|---:|---:|---:|---:|
| lightgbm_flights | binary | 1 | NA | Preprocessor1_Model3 | NA | NA | 1741 | 18 | 10 | 0.269 | 0.696 | 0.889 |
| lightgbm_flights | binary | 1 | NA | Preprocessor1_Model5 | NA | NA | 1352 | 34 | 13 | 0.273 | 0.689 | 0.886 |
| lightgbm_flights | binary | 1 | NA | Preprocessor1_Model1 | NA | NA | 605 | 2 | 8 | 0.297 | 0.637 | 0.862 |
| lightgbm_flights | binary | 1 | NA | Preprocessor1_Model4 | NA | NA | 810 | 28 | 3 | 0.328 | 0.551 | 0.822 |
| lightgbm_flights | binary | 1 | NA | Preprocessor1_Model2 | NA | NA | 134 | 13 | 5 | 0.333 | 0.543 | 0.816 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model11 | 0.001 | 0.5 | NA | NA | NA | 0.380 | 0.389 | 0.747 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model12 | 0.002 | 0.5 | NA | NA | NA | 0.381 | 0.390 | 0.744 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model21 | 0.001 | 1.0 | NA | NA | NA | 0.381 | 0.388 | 0.745 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model01 | 0.001 | 0.0 | NA | NA | NA | 0.382 | 0.388 | 0.742 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model02 | 0.002 | 0.0 | NA | NA | NA | 0.382 | 0.388 | 0.742 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model03 | 0.003 | 0.0 | NA | NA | NA | 0.382 | 0.388 | 0.742 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model04 | 0.006 | 0.0 | NA | NA | NA | 0.382 | 0.388 | 0.742 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model05 | 0.010 | 0.0 | NA | NA | NA | 0.383 | 0.387 | 0.742 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model13 | 0.003 | 0.5 | NA | NA | NA | 0.383 | 0.386 | 0.740 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model22 | 0.002 | 1.0 | NA | NA | NA | 0.383 | 0.386 | 0.741 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model06 | 0.018 | 0.0 | NA | NA | NA | 0.384 | 0.385 | 0.740 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model07 | 0.032 | 0.0 | NA | NA | NA | 0.386 | 0.382 | 0.739 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model14 | 0.006 | 0.5 | NA | NA | NA | 0.386 | 0.377 | 0.734 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model23 | 0.003 | 1.0 | NA | NA | NA | 0.386 | 0.376 | 0.734 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model08 | 0.056 | 0.0 | NA | NA | NA | 0.389 | 0.378 | 0.737 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model15 | 0.010 | 0.5 | NA | NA | NA | 0.389 | 0.373 | 0.731 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model24 | 0.006 | 1.0 | NA | NA | NA | 0.389 | 0.373 | 0.730 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model16 | 0.018 | 0.5 | NA | NA | NA | 0.393 | 0.369 | 0.725 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model25 | 0.010 | 1.0 | NA | NA | NA | 0.393 | 0.368 | 0.723 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model09 | 0.100 | 0.0 | NA | NA | NA | 0.394 | 0.372 | 0.735 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model17 | 0.032 | 0.5 | NA | NA | NA | 0.400 | 0.357 | 0.714 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model26 | 0.018 | 1.0 | NA | NA | NA | 0.400 | 0.351 | 0.710 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model10 | 0.178 | 0.0 | NA | NA | NA | 0.401 | 0.364 | 0.733 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model27 | 0.032 | 1.0 | NA | NA | NA | 0.406 | 0.326 | 0.702 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model18 | 0.056 | 0.5 | NA | NA | NA | 0.409 | 0.327 | 0.702 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model28 | 0.056 | 1.0 | NA | NA | NA | 0.415 | 0.326 | 0.702 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model19 | 0.100 | 0.5 | NA | NA | NA | 0.418 | 0.326 | 0.702 |
| baseline_glm | binary | 1 | NA | Preprocessor1_Model1 | NA | NA | NA | NA | NA | 0.431 | 0.198 | 0.581 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model20 | 0.178 | 0.5 | NA | NA | NA | 0.434 | 0.326 | 0.702 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model29 | 0.100 | 1.0 | NA | NA | NA | 0.434 | 0.578 | 0.500 |
| glmnet_flights | binary | 1 | NA | Preprocessor1_Model30 | 0.178 | 1.0 | NA | NA | NA | 0.434 | 0.578 | 0.500 |

</div>

## test

``` r
test_metrics = read.csv("targets-runs/test_metrics.csv")

test_metrics |>
    gt::gt() |>
    gt::as_raw_html()
```

<div id="oyaosjuxxb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| .estimator | roc_auc | pr_auc | mn_log_loss |
|:-----------|--------:|-------:|------------:|
| binary     |   0.889 |  0.702 |       0.268 |

</div>
