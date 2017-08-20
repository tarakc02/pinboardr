pb_tag <- function(tags) {
    if (is.null(tags)) return(NULL)
    if (!inherits(tags, "character")) stop("Dunno how to work with these tags")

    tags <- tags[!is.na(tags), drop = FALSE]
    if (length(tags) == 0L) return(NULL)
    if (any(nchar(tags) > 255L)) stop("Tag too long")
    if (any(grepl(",|\\s", tags))) stop("No commas or whitespace allowed in tags")

    structure(
        paste(tags, collapse = "+"),
        length = length(tags),
        class = c("pb_taglist", "AsIs", "character")
    )
}

taglength <- function(taglist) {
    if (is.null(taglist)) 0
    else attr(taglist, "length")
}

pb_date <- function(date) {
    if (is.null(date)) return(NULL)
    assert_that(is.date(date))
    # lowest <- as.Date('01-01-0001', '%m-%d-%Y')
    # highest <- as.Date('01-01-2100', '%m-%d-%Y')

    # if (date < lowest) stop("Date too early")
    # if (date > lowest) stop("Date too far in the future")

    format(date, "%Y-%m-%d")
}

pb_datetime <- function(datetime) {
    if (is.null(datetime)) return(NULL)
    assert_that(is.time(datetime))
    datetime <- as.POSIXlt(datetime, tz = "UTC")
    format(datetime, "%Y-%m-%dT%H:%M:%SZ")
}

pb_url <- function(url) url
pb_yn <- function(val) {
    if (is.null(val)) return(NULL)
    assert_that(is.flag(val))
    if (val) "yes" else "no"
}

yn_tf <- function(yn) {
    tf <- c(yes = TRUE, no = FALSE)
    unname(tf[yn])
}

pb_title <- function(title) {
    if (is.null(title)) return(title)
    assert_that(is.string(title), !is.na(title), nchar(title) <= 255)
    title
}

pb_text <- function(text) {
    if (is.null(text)) return(text)
    assert_that(is.string(text), !is.na(text), nchar(text) <= 65536)
    text
}
