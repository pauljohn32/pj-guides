## Make a shared object first
## R CMD SHLIB geyerex-1.c


set.seed(42)
rbeta(5, 1.5, 2.5)
dyn.load("geyerex-1.so")

baz <- function(n, s, t) {
    .C("baz", n = as.integer(n), s = as.double(s), t = as.double(t),
        x = double(n))$x
}


set.seed(42)
baz(5, 1.5, 2.5)

set.seed(42)
baz(10, 1.5, 2.5)
