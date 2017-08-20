#' Get all bookmarks
#'
#' @param tags filter by up to three tags
#' @param start offset value (default is 0)
#' @param results number of results to return. Default is all
#' @param from return only bookmarks created after this time
#' @param to return only bookmarks created before this time
#' @param meta include a change detection signature for each bookmark
#'
#' @export
all_posts <- function(
    tags = NULL,
    start = NULL,
    results = NULL,
    from = NULL,
    to = NULL,
    meta = TRUE
) {
    tags = pb_tag(tags)
    if (taglength(tags) > 3L) stop("Only 3 tags allowed")

    fromdt = pb_datetime(from)
    todt = pb_datetime(to)

    url <- build_posts_url(
        "all",
        tag = tags,
        start = start,
        results = results,
        fromdt = fromdt,
        todt  = todt,
        meta = meta
    )

    response <- GET_1_5m(httr::build_url(url))
    response_list <- process(response)

    if (length(response_list) == 0L) df <- data.frame(
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
    else df <- response_list

    df$shared <- yn_tf(df$shared)
    df$toread <- yn_tf(df$toread)
    df$time <- lubridate::ymd_hms(df$time)
    structure(df, class = c("pinboard_posts", "tbl_df", "tbl", "data.frame"))
}

