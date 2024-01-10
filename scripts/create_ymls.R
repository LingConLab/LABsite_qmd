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
  distinct(name, name_ru, card_title, card_title_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial.yml")

filtered |> 
  arrange(name_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial_ru.yml")

filtered |> 
  arrange(card_title) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial_card.yml")

filtered |> 
  arrange(card_title_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dial_ru_card.yml")

# l2 ----------------------------------------------------------------------

df |> 
  filter(subtype == "bilingual") |> 
  distinct(name, name_ru, card_title, card_title_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2.yml")

filtered |> 
  arrange(card_title) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2_card.yml")

filtered |> 
  arrange(name_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2_ru.yml")

filtered |> 
  arrange(card_title_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/l2_ru_card.yml")


# minority ----------------------------------------------------------------

df |> 
  filter(subtype == "minority") |> 
  distinct(name, name_ru, card_title, card_title_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority.yml")

filtered |> 
  arrange(card_title) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority_card.yml")

filtered |> 
  arrange(name_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority_ru.yml")

filtered |> 
  arrange(card_title_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/minority_ru_card.yml")

# dicts -------------------------------------------------------------------

df |> 
  filter(subtype == "dictionary") |> 
  distinct(name, name_ru, card_title, card_title_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts.yml")

filtered |> 
  arrange(card_title) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title[i],
       href = filtered$link[i],
       content = str_c("Tokens: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts_card.yml")

filtered |> 
  arrange(name_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts_ru.yml")

filtered |> 
  arrange(card_title_ru) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title_ru[i],
       href = filtered$link[i],
       content = str_c("Словоупотр.: ", 
                       filtered$n_tokens[i] |> as.integer() |> format(big.mark = "\u00A0")))
}) |> 
  as_yml() |> 
  use_yml_file("ymls/dicts_ru_card.yml")

# other -------------------------------------------------------------------

df |> 
  filter(is.na(subtype)) |> 
  distinct(name, name_ru, card_title, card_title_ru, link, n_tokens) |> 
  arrange(name) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$name[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other.yml")

filtered |> 
  arrange(card_title) ->
  filtered

map(seq_along(filtered$name), function(i){
  list(text = filtered$card_title[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other_card.yml")

filtered |> 
  arrange(name_ru) ->
  filtered

map(seq_along(filtered$name_ru), function(i){
  list(text = filtered$name_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other_ru.yml")

filtered |> 
  arrange(card_title_ru) ->
  filtered

map(seq_along(filtered$name_ru), function(i){
  list(text = filtered$card_title_ru[i],
       href = filtered$link[i])
}) |> 
  as_yml() |> 
  use_yml_file("ymls/other_ru_card.yml")

# quarto-english ----------------------------------------------------------

list(project = list(type = "website",
                    title = "Resources of the Linguistic Convergence Laboratory",
                    `output-dir` = "./docs",
                    render = list("index.qmd", "resources.qmd")),
     execute = list(echo = FALSE,
                    warning = FALSE,
                    message = FALSE),
     format = list(html = list(theme = "flatly",
                               linkcolor = "#2c3e50",
                               `header-includes` = '<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">')),
     lang = "en",
     mainfont = "Open Sans",
     website = list(search = FALSE,
                    favicon = "images/favicon-32x32.png",
                    `page-footer` = "![](images/hse_logo.png){width=12mm}<br>2021--<span id='year'></span>, Linguistic Convergence Laboratory, HSE University<script>document.getElementById('year').innerHTML = new Date().getFullYear();</script>",
                    navbar = list(right = list(list(text = "ru",
                                                    href = "./ru/index.html"))),
                    sidebar = list(style = "docked",
                                   background = "dark",
                                   `collapse-level` = 1,
                                   contents =  list(
                                     list(text = "Resources overview",
                                          href = "./resources.html"),
                                     list(section = "Dialect corpora",
                                          contents = read_yaml("ymls/dial.yml")),
                                     list(section = "Corpora of bilingual Russian",
                                          contents = read_yaml("ymls/l2.yml")),
                                     list(section = "Corpora of minority languages of Russia",
                                          contents = read_yaml("ymls/minority.yml")),
                                     list(section = "Dictionaries",
                                          contents = read_yaml("ymls/dicts.yml")),
                                     list(section = "Other Resources",
                                          contents = read_yaml("ymls/other.yml") |> modify_depth(1, function(i) discard_at(i, "content"))))))) |> 
  as_yml() |> 
  use_yml_file("ymls/_quarto-english.yml")

# quarto-russian ----------------------------------------------------------

list(project = list(type = "website",
                    title = "Ресурсы Международной лаборатории языковой конвергенции",
                    `output-dir` = "./../docs/ru",
                    render = list("index.qmd", "resources.qmd")),
     execute = list(echo = FALSE,
                    warning = FALSE,
                    message = FALSE),
     format = list(html = list(theme = "flatly",
                               linkcolor = "#2c3e50",
                               `header-includes` = '<link rel="preconnect" href="https://fonts.gstatic.com"><link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">')),
     lang = "ru",
     mainfont = "Open Sans",
     website = list(search = FALSE,
                    favicon = "../images/favicon-32x32.png",
                    `page-footer` = "![](../images/hse_logo.png){width=12mm}<br>2021--<span id='year'></span>, Международная лаборатория языковой конвергенции, НИУ ВШЭ<script>document.getElementById('year').innerHTML = new Date().getFullYear();</script>",
                    navbar = list(right = list(list(text = "en",
                                                    href = "./../index.html"))),
                    sidebar = list(style = "docked",
                                   background = "dark",
                                   `collapse-level` = 1,
                                   contents =  list(
                                     list(text = "Обзор ресурсов",
                                          href = "./resources.html"),
                                     list(section = "Диалектные корпуса",
                                          contents = read_yaml("ymls/dial_ru.yml")),
                                     list(section = "Корпуса билингвального русского",
                                          contents = read_yaml("ymls/l2_ru.yml")),
                                     list(section = "Малые языки России",
                                          contents = read_yaml("ymls/minority_ru.yml")),
                                     list(section = "Словари",
                                          contents = read_yaml("ymls/dicts_ru.yml")),
                                     list(section = "Другие проекты",
                                          contents = read_yaml("ymls/other_ru.yml") |> modify_depth(1, function(i) discard_at(i, "content"))))))) |> 
  as_yml() |> 
  use_yml_file("ymls/_quarto-russian.yml")
