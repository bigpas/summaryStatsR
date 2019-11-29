#'
#' A Simple Custom-defined Summary Stats Function for a single variable
#' It works with data.frame, data.table and tibble.
#'
#' @param data     A data frame
#' @param target_var       A character representing the outcome variable
#' @param decimals Number of decimals in the output frame
#'
#' @return         A data frame with min, mean, median, sd, max
#'
#' @name summary_stats
#'
#'@examples
#'
#' library(rlang)
#' library(dplyr)
#' library(purrr)
#' library(glue)
#' library(summaryStatsR)
#' library(datasets)
#'
#' summary_stats(datasets::iris, "Sepal.Length", decimals = 2)
#' @importFrom stats median na.omit sd
#' @importFrom dplyr `%>%`
#' @importFrom rlang `:=`
#' @export
summary_stats  <- function(data, target_var, decimals=2){
    
    stopifnot(exprs = {
        is.data.frame(data)
        is.character(target_var)
        rlang::is_integerish(decimals)
    })

    sym_om  <- rlang::sym(target_var)

    meanOM    <- glue::glue("avg_{toupper(target_var)}")
    medianOM  <- glue::glue("median_{toupper(target_var)}")
    minOM     <- glue::glue("min_{toupper(target_var)}")
    maxOM     <- glue::glue("max_{toupper(target_var)}")
    sdOM      <- glue::glue("sd_{toupper(target_var)}")
    semOM     <- glue::glue("sem_{toupper(target_var)}")
    N         <- "N"

    data %>%
        dplyr::summarise(
            !!minOM    := min(!!sym_om, na.rm = TRUE),
            !!meanOM   := mean(!!sym_om, na.rm = TRUE),
            !!medianOM := median(!!sym_om, na.rm = TRUE),
            !!sdOM     := sd(!!sym_om, na.rm = TRUE),
            !!semOM    := sem(na.omit(!!sym_om)),
            !!maxOM    := max(!!sym_om, na.rm = TRUE),
            !!N        := dplyr::n()
        ) %>%
        round(decimals)
}

#' Summary Stats with a grouping variable
#' It works with data.frame, data.table and tibble.
#'
#' @param data       A data frame
#' @param group      A character representing a grouping variable
#' @param target_var A character representingthe outcome variable
#' @param decimals   Number of decimals in the output frame
#'
#' @return         A data frame with min, mean, median, sd, max
#'
#' @name grouped_summary_stats
#'
#' @importFrom stats median na.omit sd
#' @importFrom dplyr `%>%`
#' @importFrom rlang `:=`
#' @examples
#'
#' library(rlang)
#' library(dplyr)
#' library(purrr)
#' library(glue)
#' library(summaryStatsR)
#' library(datasets)
#'
#' grouped_summary_stats(datasets::iris, group = "Species", target_var = "Sepal.Length")
#'
#' @export
grouped_summary_stats  <- function(data, group, target_var, decimals=2){

    stopifnot(exprs = {
        is.data.frame(data)
        is.character(group)
        is.character(target_var)
        rlang::is_integerish(decimals)
    })

    sym_var <- rlang::sym(group)
    sym_om  <- rlang::sym(target_var)

    meanOM    <- glue::glue("avg_{toupper(target_var)}")
    medianOM  <- glue::glue("median_{toupper(target_var)}")
    minOM     <- glue::glue("min_{toupper(target_var)}")
    maxOM     <- glue::glue("max_{toupper(target_var)}")
    sdOM      <- glue::glue("sd_{toupper(target_var)}")
    semOM     <- glue::glue("sem_{toupper(target_var)}")
    N         <- "N"

    data %>%
        dplyr::group_by(!!sym_var) %>%
        dplyr::summarise(
            !!minOM    := min(!!sym_om, na.rm = TRUE),
            !!meanOM   := mean(!!sym_om, na.rm = TRUE),
            !!medianOM := median(!!sym_om, na.rm = TRUE),
            !!sdOM     := sd(!!sym_om, na.rm = TRUE),
            !!semOM    := sem(na.omit(!!sym_om)),
            !!maxOM    := max(!!sym_om, na.rm = TRUE),
            !!N        := dplyr::n()
        ) %>%
        dplyr::ungroup() %>%
        purrr::map_df(function(col)
            if (is.numeric(col)) {
                return(round(col, decimals))
            } else {
                as.character(col)
            })
}

#'
#' Summary Stats with 2 grouping variables
#'
#'
#' It works with data.frame, data.table and tibble.
#'
#' @param data     A data frame
#' @param group1   A character representing a grouping variable
#' @param group2   A character representing a grouping variable
#' @param target_var       An outcome variable
#' @param decimals Number of decimals in the output frame
#'
#' @return         A data frame with min, mean, median, sd, max
#'
#' @name grouped2_summary_stats
#'
#' @importFrom stats median na.omit sd
#' @importFrom dplyr `%>%`
#' @importFrom rlang `:=`
#' @examples
#'
#' library(rlang)
#' library(dplyr)
#' library(purrr)
#' library(glue)
#' library(summaryStatsR)
#' library(datasets)
#'
#' grouped2_summary_stats(datasets::mtcars, group1 = "gear", group2 = "cyl", target_var='mpg')
#'
#' @export
grouped2_summary_stats <- function(data, group1, group2, target_var, decimals=2){

    stopifnot(exprs = {
        is.data.frame(data)
        is.character(group1)
        is.character(group2)
        is.character(target_var)
        rlang::is_integerish(decimals)
    })

    sym_group1 <- rlang::sym(group1)
    sym_group2 <- rlang::sym(group2)
    sym_om     <- rlang::sym(target_var)

    meanOM    <- glue::glue("avg_{toupper(target_var)}")
    medianOM  <- glue::glue("median_{toupper(target_var)}")
    minOM     <- glue::glue("min_{toupper(target_var)}")
    maxOM     <- glue::glue("max_{toupper(target_var)}")
    sdOM      <- glue::glue("sd_{toupper(target_var)}")
    semOM     <- glue::glue("sem_{toupper(target_var)}")
    N         <- "N"

    data %>%
        dplyr::group_by(!!sym_group1, !!sym_group2) %>%
        dplyr::summarise(
            !!minOM    := min(!!sym_om, na.rm = TRUE),
            !!meanOM   := mean(!!sym_om, na.rm = TRUE),
            !!medianOM := median(!!sym_om, na.rm = TRUE),
            !!sdOM     := sd(!!sym_om, na.rm = TRUE),
            !!semOM    := sem(na.omit(!!sym_om)),
            !!maxOM    := max(!!sym_om, na.rm = TRUE),
            !!N        := dplyr::n()
        ) %>%
        dplyr::ungroup() %>%
        purrr::map_df(function(col)
            if (is.numeric(col)) {
                return(round(col, decimals))
            } else {
                as.character(col)
            })
}
