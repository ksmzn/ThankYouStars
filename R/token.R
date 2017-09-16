#'@importFrom jsonlite fromJSON
read_token_from_json <- function() {
  configPath <- file.path(path.expand('~'), '.thank-you-stars.json')
  if (!file.exists(configPath)) {
    return(NULL)
  }

  token <- jsonlite::fromJSON(configPath)[['token']]
  if (is.null(token)) {
    return(NULL)
  }
  return(token)
}

read_token_from_env <- function() {
  token <- Sys.getenv('GITHUB_PAT', '')
  if (token == '')
    token <- Sys.getenv('GITHUB_TOKEN', '')
  if (token == '')
    NULL
  else
    token
}

read_token <- function(token=NULL) {
  if (is.null(token)) {
    token <- read_token_from_json()
  }
  if (is.null(token)) {
    token <- read_token_from_env()
  }
  if (is.null(token)) stop("Required GitHub token.")
  return(token)
}
