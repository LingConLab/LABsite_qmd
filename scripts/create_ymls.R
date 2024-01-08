library(tidyverse)
library(ymlthis)
library(yaml)

read_tsv("data.tsv") |> 
  filter(is.na(ignore)) ->
  df

map(list.files("ymls", pattern = ".yml", full.names = TRUE), file.remove)

# dial --------------------------------------------------------------------

df |> 
  filter(subtype == "dialectal") |> 
  distinct(name, name_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial.yml")

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial_ru.yml")

# l2 ----------------------------------------------------------------------

df |> 
  filter(subtype == "bilingual") |> 
  distinct(name, name_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2.yml")

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2_ru.yml")

# minority ----------------------------------------------------------------

df |> 
  filter(subtype == "minority") |> 
  distinct(name, name_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority.yml")

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority_ru.yml")

# dicts -------------------------------------------------------------------

df |> 
  filter(subtype == "dictionary") |> 
  distinct(name, name_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts.yml")

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts_ru.yml")

# other -------------------------------------------------------------------

df |> 
  filter(is.na(subtype)) |> 
  distinct(name, name_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other.yml")

map(seq_along(filtered$name_ru), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other_ru.yml")

# quarto-english ----------------------------------------------------------

list(project = list(type = "website",
                    title = "Linguistic Convergence Laboratory",
                    `output-dir` = "./docs",
                    render = list("index.qmd", "resources.qmd")),
     execute = list(echo = FALSE,
                    warning = FALSE,
                    message = FALSE),
     format = list(html = list(theme = "flatly",
                               `header-includes` = '<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">')),
     lang = "en",
     mainfont = "Open Sans",
     website = list(search = FALSE,
                    favicon = "images/favicon-32x32.png",
                    `page-footer` = "![](images/hse_logo.png){width=12mm}<br>2021--<span id='year'></span>, Linguistic Convergence Laboratory, HSE University<script>document.getElementById('year').innerHTML = new Date().getFullYear();</script>",
                    navbar = list(left = list(list(text = "ru",
                                                   href = "./ru/index.html")),
                                  right = list(
                                    list(text = "All resources",
                                         href = "./resources.html"),
                                    list(text = "Dialect corpora",
                                         menu = read_yaml("ymls/dial.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Bilingual Russian",
                                         menu = read_yaml("ymls/l2.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Minority languages",
                                         menu = read_yaml("ymls/minority.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Dictionaries",
                                         menu = read_yaml("ymls/dicts.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Other Resources",
                                         menu = read_yaml("ymls/other.yml") |> modify_depth(1, function(i) discard_at(i, "content"))))))) |> 
  as_yml() |> 
  use_yml_file("ymls/_quarto-english.yml")

# quarto-russian ----------------------------------------------------------

list(project = list(type = "website",
                    title = "Международная лаборатория языковой конвергенции",
                    `output-dir` = "./../docs/ru",
                    render = list("index.qmd", "resources.qmd")),
     execute = list(echo = FALSE,
                    warning = FALSE,
                    message = FALSE),
     format = list(html = list(theme = "flatly",
                               `header-includes` = '<link rel="preconnect" href="https://fonts.gstatic.com"><link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">')),
     lang = "ru",
     mainfont = "Open Sans",
     website = list(search = FALSE,
                    favicon = "../images/favicon-32x32.png",
                    `page-footer` = "![](../images/hse_logo.png){width=12mm}<br>2021--<span id='year'></span>, Международная лаборатория языковой конвергенции, НИУ ВШЭ<script>document.getElementById('year').innerHTML = new Date().getFullYear();</script>",
                    navbar = list(left = list(list(text = "en",
                                                   href = "./../index.html")),
                                  right = list(
                                    list(text = "Все ресурсы",
                                         href = "./resources.html"),
                                    list(text = "Диалектные корпуса",
                                         menu = read_yaml("ymls/dial_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Билингвальный русский",
                                         menu = read_yaml("ymls/l2_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Малые языки",
                                         menu = read_yaml("ymls/minority_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Словари",
                                         menu = read_yaml("ymls/dicts_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))),
                                    list(text = "Другие проекты",
                                         menu = read_yaml("ymls/other_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))))))) |> 
  as_yml() |> 
  use_yml_file("ymls/_quarto-russian.yml")
