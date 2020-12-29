# Write an R Package on GitHub



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
