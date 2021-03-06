% File src/library/base/man/specify_sem.Rd
\name{specify_sem}
\alias{specify_sem}
\title{Specify a structural equation model}
\description{
  Specify a structural equation model with constraints.
}
\usage{
  specify_sem(num.x, num.y, num.xi, num.eta, xi, eta, 
              constraints = c("indirect", "direct1", "direct2"),
              num.classes = 1, rel.lat = "default", interaction = "none")
}
\arguments{
  \item{num.x}{number of observed variables for xi.}
  \item{num.y}{number of observed variables for eta.}
  \item{num.xi}{number of latent exogenous variabeles.}
  \item{num.eta}{number of latent endognous variables.}
  \item{xi}{which observed variables are indicators for which exogenous
  variable. See Details.}
  \item{eta}{which observed variables are indicators for which endogenous
  variable. See Details.}
  \item{constraints}{which should be set for a model with more than one
  latent class. See Details.}
  \item{num.classes}{number of latent classes.}
  \item{interaction}{define which interaction terms should be included.
  Default is `none'. See Details for how to enter interaction terms.}
  \item{rel.lat}{define relations between latent variables.
  Influences Beta and Gamma matrices. For `defaults' and how to define
  see Details.}
}
\details{
  The notation for the \code{matrices} given back by \code{specify_sem}
  follows typical notation used in structural equation modeling. The
  notation, of course, may vary dependingly. Therefore, here are examples
  for typical structural equation models with the notation used by
  \code{specify_sem} (in matrix notation):

  Structural model for LMS, QML (nonlinear SEM), and NSEMM (nonlinear SEM
  with latent classes):
  \deqn{\boldsymbol{\eta} = \boldsymbol{\alpha} + \boldsymbol{\Gamma}
        \boldsymbol{\xi} + \boldsymbol{\xi}' \boldsymbol{\Omega}
        \boldsymbol{\xi} + \boldsymbol{\zeta}}{
        eta = alpha + Gamma xi + xi' Omega xi + zeta}

  Structural model for SEMM (linear SEM with latent classes):
  \deqn{\boldsymbol{B} \boldsymbol{\eta} = \boldsymbol{\alpha} +
        \boldsymbol{\Gamma} \boldsymbol{\xi} + \boldsymbol{\zeta}}{
        B eta = alpha + Gamma xi + zeta}

  Measurement model:
  \deqn{\textbf{x} = \boldsymbol{\nu}_x + \boldsymbol{\lambda}_x
        \boldsymbol{\xi} + \boldsymbol{\delta}}{
        x = nu_x + lambda_x xi + delta}
  \deqn{\textbf{y} = \boldsymbol{\nu}_y + \boldsymbol{\lambda}_y
        \boldsymbol{\eta} + \boldsymbol{\varepsilon}}{
        y = nu_y + lambda_y eta + epsilon}

  Which indicators belong to which latent variable is defined by
  \code{xi} and \code{eta}. Must be specified in the following way:
  \code{xi='x1-x2,x3-x4'} which means that variables \code{x1, x2} are
  indicators for \code{xi1} and \code{x3, x4} are indicators for
  \code{xi2}. And accordingly for the endogenous variables \code{eta}.

  Interactions between latent exogenous variables are defined by\cr
  \code{interaction='eta1~xi1:xi2,eta1~xi1:xi1'}. It is important to note,
  that interactions must always start with \code{xi1} and build from there.
  A definition like \code{interaction='eta1~xi1:xi2,eta1~xi2:xi3'} is not
  feasible and must be changed to
  \code{interaction='eta1~xi1:xi2,eta1~xi1:xi3'} (by simple switching
  \code{xi1} and \code{xi2} in one's definitions). \code{interaction} fills
  the \eqn{\bf \Omega}{Omega} matrix (see above) and must always be a
  triangular matrix where the lower triangle is filled with 0's (see Klein
  & Moosbrugger, 2000, for details).

  \code{rel.lat} defines which latent variables influence each
  other. It must be defined like\cr
  \code{rel.lat='eta1~xi1+xi2,eta2~eta1'}. Free parameters will be
  set accordingly in \eqn{\bf B}{Beta} and \eqn{\bf \Gamma}{Gamma}
  matrices. When nothing is defined, \eqn{\bf \Gamma}{Gamma} defaults to
  all \code{NA}s (which means all \eqn{\xi}{xi}'s influence all
  \eqn{\eta}{eta}'s) and \eqn{\bf B}{Beta} is an identity matrix.

  Structural equation models with latent classes like SEMM and NSEMM can be
  used in two different approaches usually called direct and indirect. When
  constraints are set to \code{indirect} then parameters for the latent
  classes are constraint to be equal except for the parameters for the
  mixture distributions (\eqn{\tau}{tau}'s and \eqn{\Phi}{Phi}). In a
  direct approach, parameters for the latent classes are estimated
  independently. For \code{direct1} all parameters will be estimated
  independently for each latent class. For \code{direct2} it is assumed
  that the measurement model is equal for both groups and only the
  parameters for the mixtures and the structural model are estimated
  separately.
}
\value{
  An object of class \code{singleClass}, \code{semm}, or \code{nsemm}
  which can be used to estimate parameters using \code{\link{em}} that
  consists of the following components:
  \item{matrices}{list of matrices specifying the structural equation
  model.}
  \item{info}{list of informations about structural equation model.}
}
\references{
  Jedidi, K., Jagpal, H. S., & DeSarbo, W. S. (1997). STEMM: A General
  Finite Mixture Structural Equation Model, \emph{Journal of
  Classification, 14}, 23--50. doi:http://dx.doi.org/10.1007/s003579900002

  Kelava, A., Nagengast, B., & Brandt, H. (2014). A nonlinear structural
  equation mixture modeling approach for non-normally distributed latent
  predictor variables. \emph{Structural Equation Modeling, 21}, 468-481.
  doi:http://dx.doi.org/10.1080/10705511.2014.915379

  Klein, A. &, Moosbrugger, H. (2000). Maximum likelihood estimation of
  latent interaction effects with the LMS method. \emph{Psychometrika, 65},
  457--474. doi:http://dx.doi.org/10.1007/bf02296338

  Klein, A. &, Muthen, B. O. (2007). Quasi-Maximum Likelihood Estimation of
  Structural Equation Models With Multiple Interaction and Quadratic
  Effects. \emph{Multivariate Behavior Research, 42}, 647--673.
  doi:http://dx.doi.org/10.1080/00273170701710205
}
\seealso{\code{\link{create_sem}}}
\examples{
# with default constraints
model <- specify_sem(num.x = 6, num.y = 3, num.xi = 2, num.eta = 1,
  xi = "x1-x3,x4-x6", eta = "y1-y3")

# create data frame
specs <- as.data.frame(model)
# and add custom constraints
constr <- c(1, NA, NA, 0, 0, 0, 0, 0, 0, 1, NA, NA, 1, NA, NA, NA, NA, 1, NA,
  0, 0, 0, 0, 0, 0, NA, 0, 0, 0, 0, 0, 0, NA, 0, 0, 0, 0, 0, 0, NA, 0, 0, 0,
  0, 0, 0, NA, 0, 0, 0, 0, 0, 0, NA, NA, 0, 0, 0, NA, 0, 0, 0, NA, NA, NA,
  NA, 0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 0, 0, 0, 0, NA, 0)
specs$class1 <- constr
# create model from data frame
model.custom <- create_sem(specs)
}

