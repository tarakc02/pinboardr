post_dates <- function(tags, format = "json", auth_token = pinboard_token()) {
    taglist <- pb_tag(tags)
    if (taglength(taglist) > 3) stop("Only 3 tags allowed")

    geturl <- build_posts_url(
        "dates",
        tag = taglist,
        format = format,
        auth_token = structure(auth_token, class = "AsIs")
    )
    raw_response <- GET_1_3s(httr::build_url(geturl))
    posts_dates_process(raw_response)
}

post_dates_process <- function(response) {
    response_list <- posts_process(response)

    if (length(response_list) == 0L) response_df <- tibble::data_frame(
            user = character(),
            tag = character(),
            date = character(),
            count = character()
        )
    else response_df <- tibble::data_frame(
        user = response_list$user,
        tag = response_list$tag,
        date = names(response_list$dates),
        count = as.character(response_list$dates)
    )

    response_df$date <- lubridate::ymd(response_df$date)
    response_df$count <- as.integer(response_df$count)
    response_df
}
