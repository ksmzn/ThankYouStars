#' ThankYouStars
#'
#' Give your Dependencies Stars on GitHub!
#' @docType package
#' @name ThankYouStars
NULL

## Main API URL
DEFAULT_API_URL <- 'https://api.github.com'

## Starring endpoint
USER_STARRED_URL <- paste0(DEFAULT_API_URL, '/user/starred')
