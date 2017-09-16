# ThankYouStars
#
# Give your dependencies stars on GitHub!

## Main API URL
default_api_url <- 'https://api.github.com'

## Starring endpoint
user_starred_url <- paste0(default_api_url, '/user/starred')

pattern_github <- '^http[s]://github.com'

#' @title Starring Sependencies
#'
#' @description Send stars to installed packages on GitHub
#' @param .token your github token
#' @export
#' @importFrom httr add_headers PUT
#' @examples
#' thank_you_stars()
#' \dontrun{
#' thank_you_stars(.token="<your-github-token>")
#' }
thank_you_stars <- function(.token = NULL) {
  token = if (!is.null(.token)) .token else read_token()
  if (is.null(token)) stop("Required GitHub token.")
  github_config <- httr::add_headers('Authorization' = paste('token', token))
  pkgs <- get_pkgs_url()
  if (length(pkgs) != 0) {
    for (repo_url in pkgs) {
      endpoint <- gsub(pattern_github, user_starred_url, repo_url)
      req <- httr::PUT(endpoint, config = github_config)
      result <- github_check(req)
      message(result, ' ', repo_url)
    }
  }
}

#' @importFrom utils installed.packages
get_pkgs_url <- function() {
  pkgs <- utils::installed.packages(priority = 'NA', fields = 'URL')[, 'URL']
  pkgs <- strsplit(pkgs, '( |,|#|\n|\t|\\(|\\))')

  # Filtering
  pkgs <- grep(pattern_github, pkgs, value = TRUE)

  # split to ('https:', '', 'github.com', ':owner', ':repo', others)
  pkgs <- strsplit(pkgs, '/')
  pkgs <-
    sapply(pkgs, function(vec)
      paste(vec[1:5], collapse = '/'))
  return(pkgs)
}

github_check <- function(req) {
  if (req$status_code < 400)
    return('Starred!')

  message <- github_parse(req)$message
  return(paste(req$status_code, message, ":"))
}

#'@importFrom httr content
#'@importFrom jsonlite fromJSON
github_parse <- function(req) {
  text <- httr::content(req, as = 'text')
  if (identical(text, ''))
    stop('No output to parse', call. = FALSE)
  jsonlite::fromJSON(text, simplifyVector = FALSE)
}
