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
