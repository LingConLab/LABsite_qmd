Site with the Resources of the Linguistic Convergence Laboratory.

## Prerequisites

The system should have `R`, `quarto` and the following R packages: `tidyverse`, `ymlthis`, and `yaml`. It would be good to have `GNU Make` too, but it is also possible to complile the website without it.

## Compilation

In order to compile you can clone the repository, `cd` to it and type `make`.

If you do not have `GNU Make` on the system, you can compile the English and Russian versions of the website manually:

a) English version

```
quarto render ./
```

b) Russian version

```
quarto render ./ru
```

## Update of the website

1. To update the website you will need to update information in `data.tsv`. In case you need to change the text of the website, see `index.qmd`, `resources.qmd`, `ru/index.qmd`, and `ru/resources.qmd`.
2. After the update you will need to run the R script stored in `scripts/create_ymls.R`. This script will create a bunch of `.yml` files in the `./ymls` folder including two general `.yml` files: `_quarto-english.yml` and `_quarto-russian.yml`.
3. After the update of the `.yml` files you will need to replace the files in the `./` and `./ru` folders:

```
cp ymls/_quarto-english.yml ./_quarto.yml
cp ymls/_quarto-russian.yml ru/_quarto.yml
```

4. Once `_quarto.yml` is updated in all folders, we can render the site as in the [compilation section](#compilation).

## Update the website on the server

1. Create an archive of the docs folder:

```
tar -cf site.tar docs/*
```

2. Pull the archive to the server:

```
rsync -avz /path/to/your/archive/site.tar lingconlab.ru:/home/your_username/
```

3. Log in to the server and extract data from the archive

```
tar -xvf site.tar
```

4. Move everything to the `/var/www/html` folder.

```
sudo rsync -a _site/* /var/www/html/
```

5. Clean:

```
rm -dr _site/
rm site.tar
```
