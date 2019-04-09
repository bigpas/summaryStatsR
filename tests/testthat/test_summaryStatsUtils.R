context("Summary Stats Funcitons for Data Frame(s) in R")

suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(rlang))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(glue))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(jsonlite))

test_that("`summary_stats` works on data.table", {
    irisDT <- data.table(iris)

    expect_equal(toJSON(summary_stats(irisDT, target_var = "Sepal.Length")),
                 toJSON(summary_stats(iris, "Sepal.Length"))
                 )
})

test_that("`summary_stats` works on tibble", {

    irisTibble <- as_tibble(iris)

    expect_equal(toJSON(summary_stats(irisTibble, "Sepal.Length")),
                 toJSON(summary_stats(iris, "Sepal.Length"))
    )
})


test_that("`grouped_summary_stats` works on data.table", {

    irisDT <- data.table(iris)

    expect_equal(toJSON(grouped_summary_stats(irisDT,
                                              group = "Species",
                                              target_var = "Sepal.Length")
    ),
    toJSON(grouped_summary_stats(iris,
                                 group = "Species",
                                 target_var = "Sepal.Length")
    )
    )
})

test_that("`grouped_summary_stats` works on tibble", {

    mtcarsTibble <- as_tibble(mtcars)

    expect_equal(object  = toJSON(grouped2_summary_stats(mtcarsTibble,
                                                         group1 = "gear",
                                                         group2 = "cyl",
                                                         target_var='mpg')
                                  ),

                 expected = toJSON(grouped2_summary_stats(mtcars,
                                                          group1 = "gear",
                                                          group2 = "cyl",
                                                          target_var='mpg')
                                   )
    )
})


test_that("`grouped_summary_stats` works on tibble", {

    mtcarsTibble <- as_tibble(mtcars)

    expect_equal(object  = toJSON(grouped2_summary_stats(mtcarsTibble,
                                                         group1 = "gear",
                                                         group2 = "cyl",
                                                         target_var='mpg')
                                  ),

                 expected = toJSON(grouped2_summary_stats(mtcars,
                                                          group1 = "gear",
                                                          group2 = "cyl",
                                                          target_var='mpg')
                                   )
    )
})

test_that("`grouped_summary_stats` works on data.table", {

    mtcarsDT <- data.table(mtcars)

    expect_equal(object  = toJSON(grouped2_summary_stats(mtcarsDT,
                                                         group1 = "gear",
                                                         group2 = "cyl",
                                                         target_var='mpg')
                                  ),

                 expected = toJSON(grouped2_summary_stats(mtcars,
                                                          group1 = "gear",
                                                          group2 = "cyl",
                                                          target_var='mpg')
                                   )
    )
})
