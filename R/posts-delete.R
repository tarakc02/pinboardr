delete_post <- function(
    url,
    auth_token = NULL
) {
    url <- pb_url(url)
    if (is.null(url)) stop("URL required")

    delete_url <- build_posts_url(
        "delete",
        url = url,
        auth_token = auth_token
    )

    response <- GET_1_3s(httr::build_url(delete_url))
    res <- process(response)
    if (!"result_code" %in% names(res))
        stop("Unexpected error. Did not receive result code from Pinboard when attempting to add ", url)
    res[["result_code"]]
}
