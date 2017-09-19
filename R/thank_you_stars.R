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
      endpoint <- paste(USER_STARRED_URL, repo_url, sep="/")
      req <- httr::PUT(endpoint, config = github_config)
      result <- github_check(req)
      message(result, ' ', repo_url)
    }
  }
}
