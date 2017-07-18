GET_1_3s <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 1, period = 3)
)

GET_1_5m <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 1, period = 300)
)

GET_1_3m <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 1, period = 180)
)
