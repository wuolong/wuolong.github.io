# Write an R Package on GitHub

It has been a while since I last developed packages for R. Some things have
changed. Here is a quick primer of setting up a package on
[Github](https://github.com).

## R Package 

### Set up a Skeleton

One easy way to get a package started is to use the `r package.skeleton()`
function. One can use a dummy object that can be deleted later.

```r
> setwd ("~/tmp")
> myfun <- function (x) x
> setwd ("~/tmp")
> myfun <- function (x) x
> package.skeleton ("awesomer", list = myfun)
Error in package.skeleton("awesomer", list = myfun) : 
  'list' must be a character vector naming R objects
> package.skeleton ("awesomer", list = "myfun")
Creating directories ...
Error in package.skeleton("awesomer", list = "myfun") : 
  directory './awesomer' already exists
> package.skeleton ("awesomer", list = "myfun")
Creating directories ...
Creating DESCRIPTION ...
Creating NAMESPACE ...
Creating Read-and-delete-me ...
Saving functions and data ...
Making help files ...
Done.
Further steps are described in './awesomer/Read-and-delete-me'.
```

```shell
tmp % ls -F awesomer 
DESCRIPTION        NAMESPACE          R/                  Read-and-delete-me man/
```

### Required Files

The `DESCRIPTION` file is the most important:

- Package: the name of the package.
- Title: a short one-sentence description of the package.
- Author: this can be a function as the following. Register a free ORCID at https://orcid.org
```r
Authors@R: 
    person(given = "Na (Michael)",
           family = "Li",
           role = c("aut", "cre"),
           email = "wuolong@gmail.com",
           comment = c(ORCID = "https://orcid.org/0000-0002-7709-5664"))
```

## GitHub

### Add the R Package to a Git Repository

``` shell
git init
git add
git commit
git remote add origin https://github.com/username/new_repo
$ git push -u origin master
```

