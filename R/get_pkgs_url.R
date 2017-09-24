GITHUB_PATTERN <- '^https?://github.com'

#' @importFrom utils installed.packages
get_pkgs_url <- function() {
  pkgs <-
    utils::installed.packages(priority = 'NA',
                              fields = c('URL', 'BugReports', 'GithubRepo', 'GithubUsername'))

  repos_from_cran_url <- filter_github_cran(pkgs[, c('URL')])
  repos_from_cran_bugreports <- filter_github_cran(pkgs[, c('BugReports')])
  repos_from_cran <- union(repos_from_cran_url, repos_from_cran_bugreports)

  repos_by_devtools <-
    filter_github_devtool(pkgs[, c('GithubRepo', 'GithubUsername')])
  repos <- union(repos_from_cran, repos_by_devtools)
  return(repos)
}

filter_github_cran <- function(pkgs) {
  GITHUB_PATTERN <- '^https?://github.com'
  pkgs <- strsplit(pkgs, '( |,|#|\n|\t|\\(|\\))')
  # Filtering
  pkgs <-
    sapply(pkgs, function(pkg) {
      grep(GITHUB_PATTERN, pkg, value = TRUE)[1]
    })
  pkgs <- pkgs[!is.na(pkgs)]

  # split to ('https:', '', 'github.com', ':owner', ':repo', others)
  pkgs <- strsplit(pkgs, '/')
  repo_name <-
    sapply(pkgs, function(vec)
      paste(vec[4:5], collapse = '/'))
  return(repo_name)
}

#' @importFrom stats na.omit
filter_github_devtool <- function(pkgs) {
  pkgs <- na.omit(data.frame(pkgs))
  repos_name <-
    paste(pkgs$GithubUsername, pkgs$GithubRepo, sep = "/")
  return(repos_name)
}
