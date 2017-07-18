get_tags <- function(auth_token = NULL) {
    url <- build_url("tags", "get", auth_token = auth_token)
    response <- GET_1_3s(httr::build_url(url))
    processed <- process(response)
    if (length(processed) == 0)
        df <- data.frame(
            tag = character(),
            count = integer(),
            stringsAsFactors = FALSE)
    else df <- data.frame(
        tag = names(processed),
        count = as.integer(processed),
        stringsAsFactors = FALSE
    )
    structure(df, class = c("pinboard_tags", "tbl_df", "tbl", class(df)))
}
