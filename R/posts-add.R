#' Add a new bookmark
#'
#' @param url URL for the bookmark (required)
#' @param title Title (required)
#' @param tags Up to 100 tags
#' @param timestamp If NULL, current time is used
#' @param replace Replace any existing bookmark with this URL. Default is TRUE. If set to FALSE, will throw an error if bookmark exists
#' @param shared Make bookmark public. Default is TRUE unless user has enabled the "save all bookmarks as private" user setting, in which case default is FALSE
#' @param toread Marks the bookmark as unread. Default is FALSE
#' @param auth_token Your auth_token
#'
#' @export
add_post <- function(
    url,
    title,
    text = NULL,
    tags = NULL,
    timestamp = NULL,
    replace = NULL,
    shared = NULL,
    toread = NULL,
    auth_token = NULL
) {
    url <- pb_url(url)
    if (is.null(url)) stop("URL required")
    title <- pb_title(title)
    if (is.null(title)) stop("Title required")
    text <- pb_text(text)
    tags <- pb_tag(tags)
    if (taglength(tags) > 100L) stop("Maximum of 100 tags allowed")
    date <- pb_datetime(timestamp)
    replace = pb_yn(replace)
    shared = pb_yn(shared)
    toread = pb_yn(toread)

    add_url <- build_posts_url(
        "add",
        url = url, description = title, extended = text, tags = tags,
        dt = date, replace = replace, shared = shared,
        toread = toread, auth_token = auth_token
    )

    response <- GET_1_3s(httr::build_url(add_url))
    res <- process(response)

    if (!"result_code" %in% names(res))
        stop("Unexpected error. Did not receive result code from Pinboard when attempting to add ", url)
    res[["result_code"]]
}
