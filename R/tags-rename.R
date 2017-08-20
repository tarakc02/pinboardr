#' Rename a tag
#'
#' @param old Tag to rename
#' @param new Replacement tag
#' @param auth_token Your auth_token
#'
#' @export
rename_tag <- function(old = NULL, new = NULL, auth_token = NULL) {
    old <- pb_tag(old)
    if (taglength(old) != 1L) stop("must provide exactly one tag to rename")

    new <- pb_tag(new)
    if (taglength(new) != 1L) stop("must provide exactly one new name for the tag")

    url <- build_url("tags", "rename", old = old, new = new, auth_token = auth_token)
    response <- GET_1_3s(httr::build_url(url))
    processed <- process(response)
    if (!"result" %in% names(processed))
        stop("Unexpected error. Did not receive confirmation from Pinboard when attempting to delete tag ", tag)
    processed[["result"]]
}
