posts_path <- function(verb) paste("v1", "posts", verb, sep = "/")

posts_process <- function(response) {
    response_text <- httr::content(
        response, as = "text",
        type = "text/plain; charset=UTF-8")
    hdrs <- httr::headers(response)
    jsonlite::fromJSON(response_text, simplifyVector = TRUE)
}

yn_tf <- function(yn) {
    tf <- c(yes = TRUE, no = FALSE)
    unname(tf[yn])
}

build_posts_url <- function(verb, ..., auth_token) {
    query <- list(...)

    query <- c(
        auth_token = auth_token,
        query
    )

    structure(
        list(
            scheme = "https",
            hostname = "api.pinboard.in",
            path = posts_path(verb),
            query = query),
        class = "url"
    )
}

GET_1_3s <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 1, period = 3)
)
