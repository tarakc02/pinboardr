#' Get a list of dates with the number of posts at each date.
#'
#' @param tags filter by up to three tags
#' @param auth_token Your auth_token
#'
#' @export
post_dates <- function(tags, auth_token = NULL) {
    taglist <- pb_tag(tags)
    if (taglength(taglist) > 3) stop("Only 3 tags allowed")

    geturl <- build_posts_url(
        "dates",
        tag = taglist,
        auth_token = auth_token
    )
    raw_response <- GET_1_3s(httr::build_url(geturl))
    post_dates_process(raw_response)
}

post_dates_process <- function(response) {
    response_list <- process(response)

    if (length(response_list) == 0L) response_df <- data.frame(
            user = character(),
            tag = character(),
            date = character(),
            count = character(),
            stringsAsFactors = FALSE
        )
    else response_df <- data.frame(
        user = response_list$user,
        tag = response_list$tag,
        date = names(response_list$dates),
        count = as.character(response_list$dates),
        stringsAsFactors = FALSE
    )

    response_df$date <- lubridate::ymd(response_df$date)
    response_df$count <- as.integer(response_df$count)
    response_df
}
