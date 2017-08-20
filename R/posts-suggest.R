#' List of popular tags and recommended tags for a given URL.
#'
#' Popular tags are tags used site-wide for the url; recommended tags are drawn from
#' the user's own tags.
#'
#' @param url A URL
#' @param auth_token Your auth_token
#'
#' @export
suggest <- function(url, auth_token = NULL) {
    url <- pb_url(url)
    request_url <- build_posts_url("suggest", url = url, auth_token = auth_token)
    response <- GET_1_3s(httr::build_url(request_url))
    response_list <- process(response)

    recommended <- Filter(function(x) !is.null(x), response_list$recommended)
    recommended <- recommended[[1]]
    popular <- Filter(function(x) !is.null(x), response_list$popular)
    popular <- popular[[1]]

    if (length(recommended) > 0L) res <- data.frame(
        suggestion_type ="recommended",
        suggestion = recommended,
        stringsAsFactors = FALSE
    )
    else res <- data.frame(
        suggestion_type = character(),
        suggestion = character(),
        stringsAsFactors = FALSE
    )

    if (length(popular) > 0L) res <- rbind(
        res, data.frame(
            suggestion_type = "popular",
            suggestion = popular,
            stringsAsFactors = FALSE
        )
    )

    structure(res, class = c("pinboard_tag_suggesions", "tbl_df", "tbl", "data.frame"))
}
