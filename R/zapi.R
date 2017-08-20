#' @export
posts <- list(
    add = add_post,
    delete = delete_post,
    update = last_updated,
    all = all_posts,
    recent = recent_posts,
    dates = post_dates,
    get = get_posts,
    suggest = suggest
)

#' @export
tags <- list(
    get = get_tags,
    delete = delete_tag,
    rename = rename_tag
)
