GET_1_3s <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 1, period = 3)
)
