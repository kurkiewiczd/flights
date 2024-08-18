library(vetiver)
library(plumber)

# read in pinned model
v = vetiver::vetiver_pin_read(board = pins::board_folder("models"),
                              name = "flights_arr_delay")

# view with plumber
pr() |>
    vetiver::vetiver_api(v, type = "prob") |>
    pr_run(port = 8080)
