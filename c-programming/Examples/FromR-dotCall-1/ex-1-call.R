dyn.load("ex-1-callRobj.so")
a <- 1
ret <- .Call("poison", as.integer(a))

ret
