Site with Resources of the Linguistic Convergence Laboratory.

## Prerequisits

The system should have an `R`, `quarto` and the following R packages: `tidyverse`, `ymlthis`, and `yaml`. It is also nice to have `GNU Make`, but it is possible to complile website without it.

## Compilation

In order to compile you can clone the repository, `cd` to it and type `make`.

If you do not have `GNU Make` on the system, you can compile English and Russian versions of the website manually:

a) English version

```
quarto render ./
```

b) Russian version

```
quarto render ./ru
```

## Update of the website

1. In order to update the website you need to update information in `data.tsv`. In case you need to change text of the website, see `index.qmd`, `resources.qmd`, `ru/index.qmd`, and `ru/resources.qmd`.
2. After the update you need to run an R script stored in `scripts/create_ymls.R`. This script will create a bunch of `.yml` files in the `./ymls` folder including two general `.yml` files: `_quarto-english.yml` and `_quarto-russian.yml`.
3. After the update of `.yml` files you need to replace files in `./` and `./ru` folders:

```
cp ymls/_quarto-english.yml ./_quarto.yml
cp ymls/_quarto-russian.yml ru/_quarto.yml
```

4. After `_quarto.yml` is updated in all folders, we can render the site as in [compilation section](#compilation).

## Update the website on the server

1. Create an archive of the docs folder:

```
tar -cf site.tar docs/*
```

2. Pull archive to the server:

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
