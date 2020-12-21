## Paul Johnson
## 20130705

## Main points

## 1. Please review FirstR lecture 1.

##  For next time, review FirstR lecture 2. 


## 2. If you use Windows, DO NOT use the R-provided editor as your
## only editor. Use something more powerful.

## All good people suggest Emacs, but some others use Notepad++ and
## some use R Studio.  Many other editors exist, such as Eclipse, VIM,
## etc.

## Package installation and maintenance


## priviledges of "ordinary" users versus the "administrator"

install.packages("lme4", dep = TRUE)


## Know your rights.

## For security reasons, do not log in as the administrator. Log in
## as a limited user. Become administrator when needed.


## When you install packages, your identity can make a difference.
## Where do the packages get installed for administrators?

## where do they go for individual users?

## Run this often

update.packages( , checkBuilt = TRUE)

## Speed it up, accept everything
update.packages(ask = FALSE , checkBuilt = TRUE)

## Speed to choose mirror server close to us

update.packages(ask = FALSE , checkBuilt = TRUE, repos = "http://rweb.quant.ku.edu/cran")



## 3. When you start R, where does R think your working directory is?  Run:

getwd()

## to see.

## Don't start R from the desktop icon or the start menu or finder.
## Do open an R file and let your editor be smart enough to know
## where the R file was found.

## Do not customize  your R icon's "start in" setting. That's not flexible.

## Please do not litter all of your projects with setwd() commands. Put
## your R folders into a directory structure and open them in an editor
## that can notice where they are found and use that as the working
## directory.

## Use relative directory locations.  That's emphasized in First-R lecture 3.


## 4. Avoid using pull down menus or cutting and pasting of commands.

## Write out the commands you run, keep them in an R script file.

## You may need to replicate something later, so write out the R
## commands in order in a file, so that somebody else can run them if
## needed.


## 5. Windows editors are compared in a fine YouTube video prepared
## by a professor you know. Watch StartR-02!

