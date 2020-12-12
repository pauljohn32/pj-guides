dyn.load("rngEx.so")

x <- vector("double", 3)
set.seed(223232)
result <- .C("rngFunc", as.integer(3), as.double(1), as.double(2), x)

result

## Above, x was double by declaration. Could do this as well
x <- rep(0, 3)

set.seed(223232)
result <- .C("rngFunc", as.integer(3), as.double(1), as.double(2), as.double(x))

result
