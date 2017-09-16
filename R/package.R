#' ThankYouStars
#'
#' Give your dependencies stars on GitHub!
#' @docType package
#' @name ThankYouStars
NULL

## Main API URL
default_api_url <- 'https://api.github.com'

## Starring endpoint
user_starred_url <- paste0(default_api_url, '/user/starred')

pattern_github <- '^http[s]://github.com'
