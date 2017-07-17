posts_path <- function(verb) path("posts", verb = verb)

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
