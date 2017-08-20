#'  The most recent time a bookmark was added, updated or deleted
#'
#'  Use this before calling posts/all to see if the data has changed since the last fetch.
#'
#'  @param auth_token Your auth_token
#'
#'  @export
last_updated <- function(auth_token = NULL) {
    url <- build_posts_url("update", auth_token = auth_token)
    response <- GET_1_3s(httr::build_url(url))
    li <- process(response)
    if (!"update_time" %in% names(li))
        stop("Unexpected error: response from Pinboard did not contain update_time")
    lubridate::ymd_hms(li[["update_time"]])
}
