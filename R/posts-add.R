add_post <- function(
    url,
    title,
    text = NULL,
    tags = NULL,
    date = NULL,
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
    date <- pb_date(date)
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
