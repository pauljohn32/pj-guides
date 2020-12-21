### Filename: plotMathProblem.R
### Paul Johnson July 7, 2010
### email me <pauljohn@ku.edu>

### This is a tale of "coercion" of items in vectors.

### Run this code through and see if you can explain the
### puzzle at the end.

  sigma <- 10.0
  mu <- 4.0

  myx <- seq( mu - 3.5*sigma,  mu+ 3.5*sigma, length.out=500)

  myDensity <- dnorm(myx,mean=mu,sd=sigma)

  ### xpd needed to allow writing outside strict box of graph
  ### Need big bottom margin to add several x axes
  par(xpd=TRUE, ps=10, mar=c(18,2,2,2))

  plot(myx, myDensity, type="l", xlab="", ylab="Probability Density ", main="Normal", axes=FALSE)
  axis(2, pos= mu - 3.6*sigma)
  axis(1, pos=0)

  lines(c(myx[1],myx[length(myx)]),c(0,0)) ### closes off axes


  addInteriorLine <- function(x, m, sd){
    for (i in 1:(length(x))){
      lines( c(x[i],x[i]), c(0, dnorm(x[i],m=m,sd=sd)), lty= 14, lwd=.2)
    }
  }


  dividers <- c(qnorm(0.025), -1, 0, 1, qnorm(0.975))

  addInteriorLine(mu+sigma*dividers, mu,sigma)

  # bquote gets the value of mu from the environment with .(mu).
  t1 <- bquote( mu == .(mu))
   mtext(t1, 1, at=mu, line=-1)


  addInteriorLabel <- function(pos1, pos2, m, s){
    area <- abs(100*( pnorm(m+pos1*s,m,s)-pnorm(m+pos2*s, m,s)))
    mid <- m+0.5*(pos1+pos2)*s
    text(mid, 0.5*dnorm(mid,m,s),label=paste(round(area,2),"%"))
  }


  addInteriorLabel(dividers[1],dividers[2],  mu, sigma)
  addInteriorLabel(dividers[2],dividers[3],  mu, sigma)
  addInteriorLabel(dividers[3],dividers[4],  mu, sigma)
  addInteriorLabel(dividers[4],dividers[5],  mu, sigma)

   b1 <- substitute( mu ~ d*sigma, list(d=round(dividers[1],2)))
   b2 <- substitute( mu ~ d*sigma, list(d=round(dividers[2],2)))
   b3 <- substitute( mu )
   b4 <- substitute( mu + d*sigma, list(d=round(dividers[4],2)))
   b5 <- substitute( mu + d*sigma, list(d=round(dividers[5],2)) )

  ## 1. Fails, labels not ready yet. R needs expressions to do plotmath
  axis(1, line=4, at=mu+dividers*sigma, labels=c(b1,b2,b3,b4,b5), padj=-1)

   ## 2. Also fails, but in an interesting way. Puzzle. Why do all
   ## but b1 display properly. 
   axis(1, line=7, at=mu+dividers*sigma, labels=c(expression(b1),b2,b3,b4,b5), padj=-1)

   ## 3. Works, probably the recommended way
   axis(1, line=10, at=mu+dividers*sigma, labels=as.expression(c(b1,b2,b3,b4,b5)), padj=-1)
   ### Duncan Murdoch explained that as.expression is needed in r-help.
   ### The reason that "as." is required is difficult, I think.

   ## 4. Also Works, but hard to understand why.
   axis(1, line=13, at=mu+dividers*sigma, labels=c(as.expression(b1),b2,b3,b4,b5), padj=-1)
   ##  Why does it work with the as.expression applied only to first
   ## element?


   ### Puzzle: Why does 2 fail, and why does 4 work?


   ### Several r-help members helped me understand this.
   ### It comes back to this:
   ### a vector in R has to be a homogeneous collection of items.
   ### All elements have to be numbers, or characters, or expressions.

   ### Putting things into a vector with c() signals R
   ### you want to "coerce" all of the things into the same type.
   ### What happens if you do
   ### x <- c("a", 1, 2, 3, 4) ##?
   ### You don't end up with one character and 4 numbers.  You get 5
   ### characters.
   ### > x
   ### [1] "a" "1" "2" "3" "4"
   ### Behind the scenes, R applies "as.character".

   ### Try #2 sets the first thing as expression(b1), and
   ### then in the effort to build the vector, R runs "as.expression"
   ### on b2, b3, b4, b5 automatically. Because "as.expression" is the
   ### required fix, then we get the correct output for those items.

   ### Why does Try #4 succeed?  Same answer.  After the first item
   ### is seen as an expression, then R coerces the rest with as.expression.

   ### So the approach in #4 works, but only luckily, and when #2 failed,
   ### it creates a very hard to debug problem (for me, at least).

   ### Anyway, now that this "works" I can concentrate on putting this to
   ### use in another project. 
