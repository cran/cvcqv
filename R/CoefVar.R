#' @title R6 Coefficient of Variation (cv)
#' @name CoefVar
#' @description The R6 class \code{CoefVar} for the coefficient of variation
#'   (cv)
#' @param x An \code{R} object. Currently there are methods for numeric vectors
#' @param na.rm a logical value indicating whether \code{NA} values should be
#'   stripped before the computation proceeds.
#' @param digits integer indicating the number of decimal places to be used.
#' @details \describe{ \item{\strong{Coefficient of Variation}}{ The \emph{cv}
#'   is a measure of relative dispersion representing the degree of variability
#'   relative to the mean \code{[1]}. Since \eqn{cv} is unitless, it is useful
#'   for comparison of variables with different units. It is also a measure of
#'   homogeneity \code{[1]}. } }
#' @examples
#' x <- c(
#'     0.2, 0.5, 1.1, 1.4, 1.8, 2.3, 2.5, 2.7, 3.5, 4.4,
#'     4.6, 5.4, 5.4, 5.7, 5.8, 5.9, 6.0, 6.6, 7.1, 7.9
#' )
#' CoefVar$new(x)$est()
#' cv_x <- CoefVar$new(x, digits = 2)
#' cv_x$est()
#' cv_x$est_corr()
#' R6::is.R6(cv_x)
#' @references \code{[1]} Albatineh, AN., Kibria, BM., Wilcox, ML., & Zogheib,
#'   B, 2014, Confidence interval estimation for the population coefficient of
#'   variation using ranked set sampling: A simulation study, Journal of Applied
#'   Statistics, 41(4), 733–751, DOI:
#'   \href{http://doi.org/10.1080/02664763.2013.847405}{http://doi.org/10.1080/02664763.2013.847405}
#'
#' @export
#' @import dplyr SciViews boot R6 utils
NULL
#' @importFrom stats quantile sd qchisq qnorm
#' @importFrom MBESS conf.limits.nct
NULL
CoefVar <- R6::R6Class(
    classname = "CoefVar",
    inherit = BootCoefVar,
    public = list(
        # ---------------- determining defaults for arguments -----------------
        x = NA,
        na.rm = FALSE,
        digits = 1,
        est = NA,
        # --------- determining constructor defaults for arguments ------------
        initialize = function(
            x = NA,
            na.rm = FALSE,
            digits = 1,
            ...
        ) {
            # ---------------------- check NA or NAN -------------------------
            if (missing(x) || is.null(x)) {
                stop("object 'x' not found")
            } else if (!missing(x)) {
                self$x <- x
            }
            if (!missing(na.rm)) {
                self$na.rm <- na.rm
            }
            if (self$na.rm == TRUE) {
                self$x <- x[!is.na(x)]
            } else if (anyNA(x) & self$na.rm == FALSE) {
                stop(
                    "missing values and NaN's not allowed if 'na.rm' is FALSE"
                )
            }
            # ------------- stop if input x vector is not numeric -------------
            if (!is.numeric(x)) {
                stop("argument is not a numeric vector")
            }
            # ------------------- set digits with user input ------------------
            if (!missing(digits)) {
                self$digits <- digits
            }
            # ----------- initialize cv estimate i.e., est() function ---------
            self$est = function(...) {
                return(
                    round(
                        100 * (
                            (sd(self$x, na.rm = self$na.rm)) /
                                (mean(self$x, na.rm = self$na.rm))
                        ), digits = self$digits
                    )
                )
            }
        },
        # -- public method of corrected cv estimate i.e., est_corr() function -
        est_corr = function(...) {
            return(
                round(
                    100 * ((self$est()/100) * (
                        (1 - (1/(4 * (length(self$x) - 1))) +
                             (1/length(self$x)) * (self$est()/100)^2) +
                            (1/(2 * (length(self$x) - 1)^2))
                        )), digits = self$digits
                    )
                )
        }
    ),
    # ---- define super_ function to enable multiple levels of inheritance ----
    active = list(
        super_ = function() super
    )
)
