path <- function(endpoint, verb) paste("v1", endpoint, verb, sep = "/")

process <- function(response) {
    httr::stop_for_status(response)
    response_text <- httr::content(
        response, as = "text",
        type = "text/plain; charset=UTF-8")

    # will these end up being used for anything?
    #hdrs <- httr::headers(response)

    jsonlite::fromJSON(
        response_text,
        simplifyVector = TRUE,
        simplifyDataFrame = TRUE,
        simplifyMatrix = TRUE)
}
