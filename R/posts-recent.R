#' Get recent posts
#'
#' @param tags Up to 3 tags to filter by
#' @param count How many posts to retrieve. Default is 15, maximum is 100
#' @param auth_token Your auth_token
#'
#' @export
recent_posts <- function(
    tags = NULL,
    count = NULL,
    auth_token = NULL
) {
    taglist <- pb_tag(tags)
    if (!is.null(count)) assert_that(is.count(count), count < 100)
    if (taglength(taglist) > 3) stop("Only 3 tags allowed")
    geturl <- build_posts_url(
        "recent",
        tag = taglist,
        auth_token = auth_token
    )
    response <- GET_1_1m(httr::build_url(geturl))
    posts_process(response)
}
