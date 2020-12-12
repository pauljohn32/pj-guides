## Paul Johnson
## 2015-10-28

Most of my lectures are Sweaved, with the R code
actually in the LaTeX document.

Sometimes I use a 2 document approach.

1. A Sweaved document that has only code chunks. Here, it is
mcExperiment-code.Rnw.

Run that and it plops output into the plots directory.

2. A LaTeX document that is not weaved.  That's mcExperiment-1.

I think this approach is a little nicer because it separates the
calculations from the LaTeX document preparation. They VITAL element
in this procedure is the Sweave setup has an argument split=T, so
each chunk is output separately.

The disadvantage of this approach is that it requires working on 2
documents, and unless you have 2 or 3 monitors, it is somewhat
inconvenience.
