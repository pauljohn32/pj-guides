---
title: "Group Means, Group Mean Deviations"
subtitle: "Multilevel recoding chores"
author:
 - name: Paul Johnson
   affiliation: Center for Research Methods and Data Analysis, University of Kansas
   email: pauljohn@ku.edu
 - name: "CRMDA Guide #43. Please visit [http://crmda.ku.edu/guides](http://crmda.ku.edu/guides) for updates."
 - name: "Tags: guides, R, multilevel models"

abstract:
    This is about recoding chores that come with multilevel models
checked_by: "First Last"
Note to Authors: please_dont_change_the_next 4 lines!
date: "`r format(Sys.time(), '%Y %B %d')`"
output:
  html_document:
    highlight: haddock
---

```{r setup, include=FALSE}
##This Invisible Chunk is required in all CRMDA documents
outdir <- paste0("tmpout")
if (!file.exists(outdir)) dir.create(outdir, recursive = TRUE)
knitr::opts_chunk$set(echo=TRUE, comment=NA, fig.path=paste0(outdir, "/p-"))
options(width = 70)
```

## Multilevel modelers need group means

Multilevel modelers might need group-level summary information for
various reasons.  Here are two of them.

1. "Mundlak's" suggestion for exploring the effect of a numeric
predictors requires us to include, as a predictor, the within group mean.

As discussed in Snijders and Bosker, it is necessary to also include either the

1. predictor at the individual level, or
2. the predictor recoded as individual-level deviations about the group mean




## In our KU css file, we have special highlighted elements for callouts.

Callout usage is demonstrated in the following. These
   are always preceeded by four # signs. Yes, ####. We stole this idea
   from other styles and put them into ours. See usage of {.bs-callout
   .bs-callout-whatever_you_put here}, where whatever_you_put_here is
   either "gray", "red", "orange", "blue", or "green". We might be able to negotiate
   you you on the choice of colors.  Run the render script with this
   document, you'll see what we mean.

```{r, eval=FALSE, include=FALSE}
bscols <- data.frame(old = c("info", "warning", "danger"),
                     new = c("blue", "orange", "red"))
```

## Demonstrating Callouts

#### Gray Callout {.bs-callout .bs-callout-gray}
Content here

#### Red Callout {.bs-callout .bs-callout-red}
Content here

#### Orange Callout {.bs-callout .bs-callout-orange}
Content here

#### Blue Callout {.bs-callout .bs-callout-blue}
Content here

#### Green Callout {.bs-callout .bs-callout-green}
Content here


#### Policies about writing in these documents. {.bs-callout .bs-callout-red}

1. Use these callouts to attract attention

2. Blank rows separate paragraphs.

3. The character width of rows should be 80 or less.  I have
no idea how anybody thinks they have a right to impose an
infinitely long row, but its bad.  Edit the document
with Emacs, run M-q to get repositioned text.  If your
editor cannot do that, quit using it.

4. Must make sure compiling using the kutils.css located in the crmda package
e.g., `crmda::render2html("filename.Rmd")`

## You have the ability to include tabs {.tabset .tabset-fade}

If you'd like, you can include different tabs. Maybe you want to show two similar versions of the same analysis. Or maybe something else. Whatever it may be, be sure to include `{.tabset .tabset-fade}` along with a level 2 header (##). For each tab, put the information under the level 3 header (###). Use another level 2 header to get out of the tabs mode.

The only way (that we know of) to get colors is to wrap the tab headers in a `<span style>` as shown below. This might be useful to draw attention to the tabs. Blue is the default color.

#### What it looks like {.bs-callout .bs-callout-blue}

```
## You have the ability to include tabs {.tabset .tabset-fade}

If you'd like, you can include different tabs. Maybe you want to show two similar versions of the same analysis. Or maybe something else. Whatever it may be, be sure to include `{.tabset .tabset-fade}` along with a level 2 header (##). For each tab, put the information under the level 3 header (###). Use another level 2 header to get out of the tabs mode.

The only way (that we know of) to get colors is to wrap the tab headers in a `<span style>` as shown below. This might be useful to draw attention to the tabs. Blue is the default color.

### <span style="color:red">First Tab Here</span>

Some information you'd like to show.

### <span style="color:orange">Second Tab Here</span>

Some more information you'd like to show.

Some more information you'd like to show.

### Third Tab Here

Some final information you'd like to show.

Some final information you'd like to show.

Some final information you'd like to show.

## Equations can be written in LaTeX, either "inline" or "display" mode.
```

## {.tabset .tabset-fade}

### <span style="color:red">First Tab Here</span>

Some information you'd like to show.

### <span style="color:orange">Second Tab Here</span>

Some more information you'd like to show.

Some more information you'd like to show.

### Third Tab Here

Some final information you'd like to show.

Some final information you'd like to show.

Some final information you'd like to show.


## Equations can be written in LaTeX, either "inline" or "display" mode.

Equations can be introduced in the style of LaTeX.  If the document
is processed into a pdf file, the LaTeX programs will be used, but
if the document is rendered to HTML, then symbolic questions are positioned
into the output and then the MathJax javascript framework is used to
display the math in the browser.

Typing the markup is like writing in LaTeX.  Two dollar signs ($\$$)
surround an inline mathematical expression while a display equation
(centered and separated) is bracketed by two dollar signs ($\$\$$).
The two dollar signs are often written on a line by themseves
for visual separation. We note that other methods that are used to
initiate display equations in latex also work, including $\[$ or
$\begin{equation}$.

\textbackslash{}begin\{equation\} and \textbackslash{}end\{equation\}
and \textbackslash{}[ and \textbackslash{}] generate the same. We need
to know if there is a recommended style.

Fractions (\\frac{}{}): $\frac{2}{3}$.

Hats (\\hat{}): $\hat{\lambda}=1.02$.

Square Root (\\sqrt{}), $\sqrt{4}=2$.

$$\alpha, \beta,  \gamma, \Gamma$$

Some popular binary operators are
$$ + - = \ne \ge \lt \pm $$
$$x \ge 15$$
$$a_i \ge 0~~~\forall i$$

## Matrix

$$
A_{m,n} =
 \begin{pmatrix}
  a_{1,1} & a_{1,2} & \cdots & a_{1,n} \\
  a_{2,1} & a_{2,2} & \cdots & a_{2,n} \\
  \vdots  & \vdots  & \ddots & \vdots  \\
  a_{m,1} & a_{m,2} & \cdots & a_{m,n}
 \end{pmatrix}
$$

This example uses the alternative display math $\[$, and
a different type of matrix.

\begin{equation}
A_{m,n} = \left(\begin{array}{ccc}
a & b & c\\
d & e & f\\
g & h & i
\end{array}\right)
\label{eq:another1}
\end{equation}

After some testing, it appears also that many
LaTeX symbols that we would expect to use have no benefit in Rmd
documents.



We don't know if there is a comprehensive list of which LaTeX math
symbols are allowed, but we wish somebody would find one.



## Statistics

The binomial probability:

$$
f(y|N,p) = \frac{N!}{y!(N-y)!}\cdot p^y \cdot (1-p)^{N-y} = {{N}\choose{y}} \cdot p^y \cdot (1-p)^{N-y}
$$

To calculate the **mean** of \textit{n} observations of variable \textit{x}, you can use: $$\bar{x} = \frac{1}{n} \sum_{i=1}^{n}x_{i}$$

Note that this equation looks quite nice above where it's in display math mode. It is more compact but not quite as nice looking if we present it using inline mode, e.g., $\bar{x} = \frac{1}{n} \sum_{i=1}^{n}x_{i}$.

Let's do the same with the equation for **variance**. First the inline version, which is
$\sigma^{2} = \frac{\sum\limits_{i=1}^{n} \left(x_{i} - \bar{x}\right)^{2}} {n-1}$. And then the display mode version:
$$\sigma^{2} = \frac{\sum_{i=1}^{n}
  \left(x_{i} - \bar{x}\right)^{2}}
  {n-1}$$

And, finally, we'll end with the **standard deviation**. Here's the inline version, $\sigma = \sqrt{\frac{\sum\limits_{i=1}^{n} \left(x_{i} - \bar{x}\right)^{2}} {n-1}}$. And here's the display version.
$$\sigma = \sqrt{\frac{\sum\limits_{i=1}^{n} \left(x_{i} - \bar{x}\right)^{2}} {n-1}}$$

There are helpful online editors - [like this one](http://mathstat.uohyd.ernet.in/equationeditor/equationeditor.php)

## Let's look at some plots


```{r myFirstPlot, dev=c('png','pdf'), fig.keep='all'}
hist(rnorm(500))

```

```{r}
x <- rnorm(1000)
print(x[1:20])
```

```{r mySecondPlot, dev=c('png','pdf'), fig.keep='all'}
hist(rnorm(20))
```

#### R code inside a callout {.bs-callout .bs-callout-red}
```{r xsummary}
summary(x)
```

## Tables

```{r, results="html"}
  xx <- "<table><tr><td>hipaul</td><td>zach</td></tr></table>\n"
  xx
```


```{r, results="asis"}
library(rockchalk)
   set.seed(2134234)
   dat <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
   dat$y1 <- 30 + 5 * rnorm(100) + 3 * dat$x1 + 4 * dat$x2
   dat$y2 <- rnorm(100) + 5 * dat$x2
   m1 <- lm(y1 ~ x1, data = dat)
   m2 <- lm(y1 ~ x2, data = dat)
   m3 <- lm(y1 ~ x1 + x2, data = dat)
   gm1 <- glm(y1 ~ x1, family = Gamma, data = dat)

or1 <- outreg(list("Amod" = m1, "Bmod" = m2, "Gmod" = m3),
title = "My Three Linear Regressions", float = FALSE, type = "html",
browse = FALSE)
or1 <- gsub("&nbsp;"," ", or1)
or1 <- gsub("^\\ *", "", or1)
or1 <- paste(or1, collapse = "")
or1 <- gsub("\\ \\ \\ \\ \\ \\ ", " ", or1)
or1 <- gsub("\\ \\ \\ ", " ", or1)
cat(or1)
```

```{r, results="asis"}
    library(xtable)
    or2 <- xtable(summary(m1))
    print(or2, type="html")
```



[//]: (All guides must have this as the final stanza)

```{r sessionInfo, echo = FALSE}
sessionInfo()
```

Available under
[Created Commons license 3.0 <img src="http://crmda.dept.ku.edu/images/cc-3.0.png" alt="CC BY"
style="width: 75px;height: 20px;"/>](http://creativecommons.org/licenses/by/3.0/)

