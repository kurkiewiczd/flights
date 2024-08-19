library(vetiver)
library(pins)
library(plumber)
library(rsconnect)

# get functions
targets::tar_source("src")

# read in pinned model
v = vetiver_pin_read(board = pins::board_folder("models"),
                     name = "flights_arr_delay")

# create board on posit connect
connect_board =
    pins::board_connect(auth = "envvar")

# pin model to connect
v |>
    vetiver::vetiver_pin_write(
        board = connect_board
    )

# deploy to rsconnect
vetiver::vetiver_deploy_rsconnect(
    board = connect_board,
    predict_args = list(debug = T, type = 'prob'),
    name = "xx_henricksonp/flights_arr_delay"
)

# predict from connect
# retrieve endpoint url
endpoint = vetiver::vetiver_endpoint(url)

# retrieve original data
tar_load(full_data)

endpoint |>
    augment(
        full_data |>
            sample_n(100) |>
            mutate(dep_time = 100),
        httr::add_headers(Authorization = paste("Key", Sys.getenv("CONNECT_API_KEY")))
    ) |>
    select(starts_with(".pred"), dep_time)

        # # view with plumber
        # pr() |>
        #     vetiver::vetiver_api(v, type = "prob") |>
        #     pr_run(port = 8080)
