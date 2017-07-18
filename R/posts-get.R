#' Get posts from a given date
#'
#' If no date or URL is given, the date of the most recent bookmark will be used.
#'
#' @param tags character vector of up to 3 tags to filter by
#' @param date a \code{Date} to filter bookmarks
#' @param url Only return the bookmark for this URL
#' @param meta Include a change detection signature?
#' @param auth_token authentication token
#'
#' @export
get_posts <- function(
    tags = NULL,
    date = NULL,
    url = NULL,
    meta = TRUE,
    auth_token = NULL
) {
    taglist <- pb_tag(tags)
    date <- pb_date(date)
    url <- pb_url(url)
    meta <- pb_yn(meta)

    if (taglength(taglist) > 3) stop("Only 3 tags allowed")

    geturl <- build_posts_url(
        "get",
        tag = taglist,
        dt = date,
        url = url,
        meta = meta,
        auth_token = auth_token
    )
    raw_response <- GET_1_3s(httr::build_url(geturl))
    posts_get_process(raw_response)
}

posts_get_process <- function(response) {
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
