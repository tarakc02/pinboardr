#' Delete an existing tag
#'
#' @param tag the tag to delete
#' @param auth_token Your auth_token
#'
#' @export
delete_tag <- function(tag = NULL, auth_token = NULL) {
    tag <- pb_tag(tag)
    if (taglength(tag) != 1L) stop("must provide exactly one tag to delete")

    url <- build_url("tags", "delete", tag = tag, auth_token = auth_token)
    response <- GET_1_3s(httr::build_url(url))
    processed <- process(response)
    if (!"result" %in% names(processed))
        stop("Unexpected error. Did not receive confirmation from Pinboard when attempting to delete tag ", tag)
    processed[["result"]]
}
