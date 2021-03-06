% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rvar-rfun.R
\name{rvar_rng}
\alias{rvar_rng}
\title{Create random variables from existing random number generators}
\usage{
rvar_rng(.f, n, ..., ndraws = NULL)
}
\arguments{
\item{.f}{(function) A function (or string naming a function) representing a
random-number generating function that follows the pattern of base random
number generators (like \code{rnorm()}, \code{rbinom()}, etc). It must:
\itemize{
\item Have a first argument, \code{n}, giving the number of draws to take from the
distribution
\item Have vectorized parameter arguments
\item Return a single vector of length \code{n}
}}

\item{n}{(positive integer) The length of the output \code{\link{rvar}} vector (\strong{not}
the number of draws).}

\item{...}{Arguments passed to \code{.f}. These arguments may include \code{\link{rvar}}s,
so long as they are vectors only (no multidimensional \code{\link{rvar}}s are
allowed).}

\item{ndraws}{(positive integer) The number of draws used to construct the
returned random variable if no \code{\link{rvar}}s are supplied in \code{...}. If \code{NULL},
\code{getOption("posterior.rvar_ndraws")} is used (default 4000). If \code{...}
contains \code{\link{rvar}}s, the number of draws in the provided \code{\link{rvar}}s is used
instead of the value of this argument.}
}
\value{
A single-dimensional \code{\link{rvar}} of length \code{n}.
}
\description{
Specialized alternative to \code{rdo()} or \code{rfun()} for creating \code{\link{rvar}}s from
existing random-number generator functions (such as \code{rnorm()}, \code{rbinom()}, etc).
}
\details{
This function unwraps the arrays underlying the input \code{\link{rvar}}s in
\code{...} and then passes them to \code{.f}, relying on the vectorization of \code{.f}
to evaluate it across draws from the input \code{\link{rvar}}s. This is why the arguments
of \code{.f} \strong{must} be vectorized. It asks for \code{n} times the number of draws
in the input \code{\link{rvar}}s (or \code{ndraws} if none are given) draws from the
random number generator \code{.f}, then reshapes the output from \code{.f} into an
\code{\link{rvar}} with length \code{n}.

\code{rvar_rng()} is a fast alternative to \code{rdo()} or \code{rfun()}, but you \strong{must}
ensure that \code{.f} satisfies the preconditions described above for the result
to be correct. Most base random number generators satisfy these conditions.
It is advisable to test against \code{rdo()} or \code{rfun()} (which should be correct,
but slower) if you are uncertain.
}
\examples{

mu <- rvar_rng(rnorm, 10, mean = 1:10, sd = 1)
sigma <- rvar_rng(rgamma, 1, shape = 1, rate = 1)
x <- rvar_rng(rnorm, 10, mu, sigma)
x

}
\seealso{
Other rfun: 
\code{\link{rdo}()},
\code{\link{rfun}()}
}
\concept{rfun}
