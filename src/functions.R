add_delay = function(data) {

  data |>
  mutate(arr_delay = case_when(arr_delay >=30 ~ 'late',
  TRUE ~ 'on_time'),
  arr_delay = factor(arr_delay, levels = c("on_time", "late"))
)
}

add_date = function(data) {

  data |>
  mutate(date = lubridate::as_date(time_hour))
}

prepare_weather = function(data) {

  data |>
  select(origin, temp, dewp, humid, wind_dir, wind_speed, wind_gust, precip, pressure, visib, time_hour)

}

prepare_flights = function(data) {

  data |>
  add_delay() |>
  add_date() |>
  select(
    date,
    year,
    month,
    day,
    hour,
    minute,
    arr_delay,
    sched_dep_time,
    sched_arr_time,
    dep_time,
    arr_time,
    carrier,
    flight,
    tailnum,
    origin,
    dest,
    air_time,
    distance,
    hour,
    minute,
    time_hour
  )

}

pivot_metrics = function(data, values = c('mean', '.estimate')) {

  data |>
  pivot_wider(
    names_from = .metric,
    values_from = any_of(values)
  )
}

pin_model = function(model,
                     board,
                     check_renv = T) {

    model |>
        vetiver::vetiver_pin_write(
            board = board,
            check_renv = check_renv
        )

    meta =
        pins::pin_meta(
            board = board,
            name = model$model_name
        )

    # return id of model
    tibble(
        hash = meta$pin_hash,
        name = model$model_name,
        version = meta$local$version
    )
}
