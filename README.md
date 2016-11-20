<!-- README.md is generated from README.Rmd. Please edit that file -->
benchr
======

 [![GitLab CI Build Status](https://gitlab.com/artemklevtsov/benchr/badges/master/build.svg)](https://gitlab.com/artemklevtsov/benchr/pipelines) [![AppVeyror Build status](https://ci.appveyor.com/api/projects/status/hoq3abe0kn34ie56/branch/master?svg=true)](https://ci.appveyor.com/project/artemklevtsov/benchr) [![Codecov Code Coverage](https://codecov.io/gl/artemklevtsov/benchr/branch/master/graph/badge.svg)](https://codecov.io/gl/artemklevtsov/benchr) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) [![CRAN Status](http://www.r-pkg.org/badges/version/benchr)](https://cran.r-project.org/package=benchr)

Package `benchr` provides an infrastructure (framework) for precise measurement of R expressions execution time.

Key features:
-------------

-   Cross-platform implementation of the timer (the same code for all supported platforms);
-   High precision measurement of time intervals: usually nano or microseconds;
-   The reliability of the results due to a preliminary estimation of the timer error and subsequent correction of measurement results;
-   The stability of the results due to multiple repetitions of the measurements and the use of robust (resistant to outliers) statistics (quantile);
-   Informative output, including measurement accuracy, execution regime and descriptive statistics for each expression;
-   Various graphical representation of measurement results, including box plots, scatter plots and violin plots.

Installation
------------

To install the package from the CRAN run the following command:

``` r
install.packages("benchr", repos = "https://cloud.r-project.org/")
```

To install the development version from git repository the `install_git()` function from `devtools` package can be used:

``` r
devtools::install_git("https://gitlab.com/artemklevtsov/benchr")
```

This package contains the compiled code, so to install it on Windows you will also need [Rtools](https://cran.r-project.org/bin/windows/Rtools/).

Usage
-----

To measure execution time of arbitrary R code, `benchr` provides function `benchmark()`, as well as a number of additional methods for analysis and representation of results. Here's an example of time measurement for several expressions.

``` r
library(benchr)
benchmark(rep(1:10, each = 10), rep.int(1:10, rep.int(10, 10)))
#> Benchmark summary:
#> Time units : microseconds
#>                            expr n.eval  min lw.qu median mean up.qu  max total relative
#>            rep(1:10, each = 10)    100 2.28  2.44   2.50 2.52  2.56 4.32   252     1.32
#>  rep.int(1:10, rep.int(10, 10))    100 1.63  1.80   1.89 1.92  1.99 4.34   192     1.00
```

The resulting object can be saved as a variable and reused later in further methods:

``` r
res <- benchmark(NULL, {NULL}, {{{NULL}}})
summary(res)
#> Time units : nanoseconds
#>              expr n.eval min lw.qu median  mean up.qu max total relative
#>              NULL    100   8    14     16  16.4    19  31  1640     1.00
#>          { NULL }    100  97   109    115 116.0   120 197 11600     7.19
#>  { { { NULL } } }    100 159   178    181 190.0   187 871 19000    11.30
```

To present the results of measurements implemented additional methods for the class `benchmark` object:

-   `mean` -- means and confidence intervals for each R expression;
-   `summary` -- statistics (quantiles, means) for each R expression;
-   `print` -- text representation of results based on method `summary`;
-   `plot` -- scatter plot the execution time of each expression measure;
-   `boxplot` -- box plot the execution time of each expression.

For further details refer to the manual pages and vignettes:

``` r
help(package = "benchr")
```

Bug reports
-----------

Use the following command to go to the page for bug report submissions:

``` r
bug.report(package = "benchr")
```

Before reporting a bug or submitting an issue, please do the following:

-   Make sure that no error was found and corrected previously identified. You can use the search by the bug tracker;
-   Check the news list for the current version of the package. An error it might have been caused by changes in the package. This can be done with `news(package = "benchr", Version == packageVersion("benchr"))` command;
-   Make a minimal reproducible example of the code that consistently causes the error;
-   Make sure that the error triggered in the function from the `benchr` package, rather than in the code that you pass, that is other functions or packages;
-   Try to reproduce the error with the last development version of the package from the git repository.

When submitting a bug report please include the output produced by functions `traceback()` and `sessionInfo()`. This may save a lot of time.

License
-------

The `benchr` package is distributed under [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) license.
