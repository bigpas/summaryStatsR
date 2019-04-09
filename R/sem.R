#' Calculate Standard Error of the Meam (SEM)
#'
#' @param x Input Vector
#'
#' @return Standard Error of the Mean. A single value
#'
#' @name sem
#'
#' @examples
#'
#' library(summaryStatsR)
#'
#' sem(iris[['Petal.Length']])
#'
#' @export
sem <- function(x) sd(na.omit(x))/sqrt(length(na.omit(x)))
