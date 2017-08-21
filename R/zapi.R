#' Use the Pinboard API
#'
#' \code{posts} and \code{tags} implement the associated endpoints in the
#' Pinboard API documentation (\url{https://pinboard.in/api/}). See the links
#' below for documentation of the individual functions.
#'
#' @examples
#' \dontrun{
#' # to view all bookmarks with the "rstats" tag
#' posts$dates(tags = "rstats")
#' }
#'
#' @section Posts:
#' \itemize{
#' \item{\code{add}: \code{\link{add_post}}}
#' \item{\code{delete}: \code{\link{delete_post}}}
#' \item{\code{update}: \code{\link{last_updated}}}
#' \item{\code{all}: \code{\link{all_posts}}}
#' \item{\code{recent}: \code{\link{recent_posts}}}
#' \item{\code{get}}: \code{\link{get_posts}}
#' \item{\code{suggest}}: \code{\link{suggest}}
#' }
#'
#' @section Tags:
#' \itemize{
#' \item{\code{get}: \code{\link{get_tags}}}
#' \item{\code{delete}: \code{\link{delete_tag}}}
#' \item{\code{rename}: \code{\link{rename_tag}}}
#' }
#'
#' @name api
NULL

#' @rdname api
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

#' @rdname api
#' @export
tags <- list(
    get = get_tags,
    delete = delete_tag,
    rename = rename_tag
)
