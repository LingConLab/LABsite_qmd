library(tidyverse)
library(ymlthis)
library(yaml)

df <- read_tsv("data.tsv")
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
     format = list(html = list(theme = "litera")),
     lang = "en",
     website = list(search = FALSE,
                    `page-footer` = "![](images/hse_logo.png){width=12mm}<br>2021--2024, Linguistic Convergence Laboratory, HSE University",
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
     format = list(html = list(theme = "litera")),
     lang = "ru",
     website = list(search = FALSE,
                    `page-footer` = "![](../images/hse_logo.png){width=12mm}<br>2021--2024, Международная лаборатория языковой конвергенции, НИУ ВШЭ",
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
