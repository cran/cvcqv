% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BootCoefQuartVar.R
\name{BootCoefQuartVar}
\alias{BootCoefQuartVar}
\title{R6 Bootstrap Resampling for Coefficient of Quartile Variation}
\arguments{
\item{x}{An \code{R} object. Currently there are methods for numeric vectors}

\item{na.rm}{a logical value indicating whether \code{NA} values should be
stripped before the computation proceeds.}

\item{alpha}{The allowed type I error probability}

\item{R}{integer indicating the number of bootstrap replicates.}
}
\description{
The R6 class \code{BootCoefQuartVar} produces the bootstrap
  resampling for the coefficient of quartile variation (cqv) of the given
  numeric vectors. It uses \link[boot]{boot} from the package \pkg{boot}.
  Also, it produces the bootstrap confidence intervals for the cqv based on
  the \link[boot]{boot.ci} from the package \pkg{boot}.
}
\examples{
x <- c(
    0.2, 0.5, 1.1, 1.4, 1.8, 2.3, 2.5, 2.7, 3.5, 4.4,
    4.6, 5.4, 5.4, 5.7, 5.8, 5.9, 6.0, 6.6, 7.1, 7.9
)
cqv_x <- BootCoefQuartVar$new(x)
cqv_x$boot_cqv()
cqv_x$boot_basic_ci()
cqv_x$boot_norm_ci()
cqv_x$boot_perc_ci()
cqv_x$boot_bca_ci()
R6::is.R6(cqv_x)
}
\references{
Canty, A., & Ripley, B, 2017, boot: Bootstrap R (S-Plus)
  Functions. R package version 1.3-20.

Davison, AC., & Hinkley, DV., 1997, Bootstrap Methods and Their
  Applications. Cambridge University Press, Cambridge. ISBN 0-521-57391-2

Altunkaynak, B., Gamgam, H., 2018, Bootstrap confidence intervals
  for the coefficient of quartile variation, Simulation and Computation, 1-9,
  DOI:
  \href{http://doi.org/10.1080/03610918.2018.1435800}{http://doi.org/10.1080/03610918.2018.1435800}
}
