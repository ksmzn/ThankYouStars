#'@importFrom jsonlite fromJSON
read_token_from_json <- function() {
  configPath <- file.path(path.expand('~'), '.thank-you-stars.json')
  if (!file.exists(configPath)) {
    return(character())
  }

  token <- jsonlite::fromJSON(configPath)[['token']]
  if (is.null(token)) {
    return(character())
  }
  return(token)
}

read_token_from_env <- function() {
  token <- Sys.getenv('GITHUB_PAT', '')
  if (token == '')
    Sys.getenv('GITHUB_TOKEN', '')
  else
    token
}

read_token <- function() {
  token <- read_token_from_json()
  if (token == '') {
    token <- read_token_from_env()
  }
  return(token)
}
