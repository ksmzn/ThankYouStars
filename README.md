ThankYouStars
====

A tool for starring GitHub repositories of R package.

## Installation

```console
> devtools::install_github("ksmzn/ThankYouStars")
```

## Setup

Save your GitHub personal access token like the many other `thank-you-stars Family`

1. Open https://github.com/settings/tokens and click "Generate new token"
2. Input desc, select only "public_repo" as scope and click "Generate token"
3. Copy the token and save as `~/.thank-you-stars.json`.
```json
{
    "token": "YOUR_TOKEN"
}
```

Alternatively, one can set the `GITHUB_PAT` environment variable or the `.token` argument of `thank_you_stars()` like [`gh` package](https://github.com/r-lib/gh).

## Usage

Run `thank_you_stars()`, then it stars your installed packages if they are hosted on GitHub.

```console
> library(ThankYouStars)
> thank_you_stars()
Starred! https://github.com/mllg/backports
Starred! https://github.com/gaborcsardi/crayon
Starred! https://github.com/hadley/devtools
Starred! https://github.com/ropensci/git2r
Starred! https://github.com/rstudio/htmltools
Starred! https://github.com/rstudio/httpuv
Starred! https://github.com/r-lib/httr
Starred! https://github.com/hadley/memoise
Starred! https://github.com/yihui/mime
Starred! https://github.com/wch/R6
Starred! https://github.com/klutometis/roxygen
Starred! https://github.com/rstudio/rstudioapi
Starred! https://github.com/hadley/xml2
```

## thank-you-stars Family

| Language   | Author    | URL                                          |
|------------|-----------|----------------------------------------------|
| JavaScript | teppeis   | https://github.com/teppeis/thank-you-stars   |
| Go         | mattn     | https://github.com/mattn/thank-you-stars     |
| Haskell    | y-taka-23 | https://github.com/y-taka-23/thank-you-stars |
| R          | ksmzn     | https://github.com/ksmzn/ThankYouStars       |

