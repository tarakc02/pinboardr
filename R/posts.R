posts_path <- function(verb) path("posts", verb = verb)

build_posts_url <- function(verb, ..., auth_token) {
    build_url("posts", verb = verb, ..., auth_token = auth_token)
}
