library(devtools)

#TOKEN: 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

#set config
usethis::use_git_config(user.name = "Fernando Cruz", user.email = "fernandoilcruz@gmail.com")

#Go to github page to generate token
usethis::create_github_token()

#paste your PAT (Personal Access Token) into pop-up that follows...
credentials::set_github_pat()

#now remotes::install_github() will work
library(devtools)
remotes::install_github(repo = "fernandoilcruz/DEEDadosR",
                        auth_token = "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")
