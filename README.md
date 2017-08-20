<!-- README.md is generated from README.Rmd. Please edit that file -->
pinboardr
=========

An R client application for the Pinboard API. Work in progress.

Usage
-----

So far the `posts` and `tags` endpoints described in the [pinboard documentation](https://pinboard.in/api/) have been implemented.

``` r
library(pinboardr)

# see dates and counts of bookmarks with the "rstats" tag.
rstats_bookmarks <- posts$dates(tags = "rstats")
head(rstats_bookmarks)
#>       user    tag       date count
#> 1 tarakc02 rstats 2017-08-15     2
#> 2 tarakc02 rstats 2017-08-08     1
#> 3 tarakc02 rstats 2017-07-29     2
#> 4 tarakc02 rstats 2017-07-20     2
#> 5 tarakc02 rstats 2017-07-17     1
#> 6 tarakc02 rstats 2017-07-15     1

# available endpoints
ls(posts)
#> [1] "add"     "all"     "dates"   "delete"  "get"     "recent"  "suggest"
#> [8] "update"
ls(tags)
#> [1] "delete" "get"    "rename"
```
