posts_path <- function(verb) path("posts", verb = verb)

build_posts_url <- function(verb, ..., auth_token = NULL) {
    build_url("posts", verb = verb, ..., auth_token = auth_token)
}

posts_process <- function(response) {
    response_list <- process(response)
    if (length(response_list) == 0L)
        response_df <- data.frame(
            href = character(),
            description = character(),
            extended = character(),
            meta = character(),
            hash = character(),
            time = character(),
            shared = character(),
            toread = character(),
            tags = character(),
            stringsAsFactors = FALSE
        )
    else response_df <- response_list$posts

    if (!"meta" %in% names(response_df))
        response_df[["meta"]] <- ""

    response_df$time <- lubridate::ymd_hms(response_df$time)
    response_df$shared <- yn_tf(response_df$shared)
    response_df$toread <- yn_tf(response_df$toread)

    structure(response_df, class = c("pinboard_posts", "tbl_df", "tbl", class(response_df)))
}
