#' @title Star For Dependency Packages
#'
#' @description Send stars to installed packages on GitHub.
#' @param .token your GitHub token
#' @export
#' @importFrom httr add_headers PUT
#' @examples
#' \dontrun{
#' thank_you_stars()
#' thank_you_stars(.token="<your-github-token>")
#' }
thank_you_stars <- function(.token = NULL) {
  pkgs <- get_pkgs_url()
  if (length(pkgs) != 0) {
    token <- read_token(.token)
    github_config <- httr::add_headers('Authorization' = paste('token', token))
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
