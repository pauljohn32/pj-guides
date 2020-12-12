###########################################################################################
#
# Missing Data Panel-Correct Standard Errors
# Scott Konzem, Carleton College, 2/20/2006
# Version 1.0
#
# Description: Use these functions in R to calculate panel-correct standard errors when
# 		you don't have rectangular data because some data is missing.
#
###########################################################################################
#
# Based on code by Simon Jackman (http://jackman.stanford.edu/classes/350C/pcse.r),
# code by Paul Johnson (http://www.ku.edu/~pauljohn/stats/CXTS/), code and techniques
# by Robert Franzese (http://www-personal.umich.edu/~franzese/Publications.html),
# and on the panel-correct standard errors technique of Beck and Katz (1995).
#
# Code to print results neatly originally by Jasjeet Sekhon
# (http://sekhon.polisci.berkeley.edu/gov2000/R/agl1.R).
#
# Special thanks to Dr. Laura Chihara of Carleton College for her help with R programming.
#
###########################################################################################
#
# Usage Overview: Use prep.mdpcse to pare down your data frame to valid cross-section
# 		units, then calculate PCSEs with mdpcse() and display with printpcse()
#
# Assumption: Data are sorted by unit then time (for the ordering of residuals).
# Assumption: Data are rectangularized using missing values, so the total number of
#		cases is equal to (# units) * (max year - min year), but the cases with
#		missing data aren't included in the regression.
# Assumption: The regression was run with na.action=na.exclude, so the residuals 
#		stored by lmobj line up with the group identifier yet the data remain
#		rectangular.
# Note: Results appear to be identical if there are extra years "padding" either side of
#		the data.  There is no need to rectangularize these extra years away.
#
###########################################################################################
#
# Example usage:
#
# In this example, df$COUNTRY is the grouping variable.
#
# Run the regression once with your full data frame:
#	ols <- lm( TRADE ~ LABGDP*W + CAPGDP*W + LANDGDP*W, na.action=na.exclude, data=df )
# 
# Generate a list of cases to exclude because their units don't overlap with others:
#	exclude <- prep.mdpcse(ols, df$COUNTRY)
# 
# Create a new data frame, minus invalid countries (where cases don't overlap with others):
#	newdf <- df[ !is.element(c(1:length(residuals(ols))),exclude), ]
#
# Run the regression again
#	ols <- lm( TRADE ~ LABGDP*W + CAPGDP*W + LANDGDP*W, na.action=na.exclude, data=newdf )
#
# Calculate panel-correct standard errors
#	pcse<-mdpcse(ols,newdf$COUNTRY)
#
# Print results with 4 significant digits
#	printpcse(ols,pcse, sigdig=4)
#
###########################################################################################


###########################################################################################
# prep.mdpcse - Create a list of invalid cases (country-years) to exclude from the data
#		frame before calculating PCSEs.  If a country's data does not overlap with
#		any other country's, it needs to be excluded, because it's not possible to
#		calculate a covariance.
###########################################################################################

prep.mdpcse <- function(lmobj, group){

  	id <- unique(group)		# List of group identifiers
 	N <- length(id)			# Number of groups
	resids <- residuals(lmobj)	# Get residuals
	J <- length(resids)/N		# Number of years

	##############################################################################
	# Generate a T x N matrix M by which to divide the matrix of residuals.
	# Each element is a 1 if data exists or 0 if data is missing.
	##############################################################################
	
	resids3 <- resids
	resids3[!is.na(resids3)] <- 1
	resids3[is.na(resids3)] <- 0
	
	M <- matrix(0,J,N)
	for(i in 1:N){
 		M[,i] <- resids3[group==id[i]]
	}

	MTRANSM <- (t(M) %*% M)

	##############################################################################
	# If an element on the diagonal of (M'M) is a zero, the corresponding
	# cross-section unit has no valid observations, so exclude that unit from
	# future analysis and re-do (M'M)
	##############################################################################

	valid.units <- diag(MTRANSM) != 0.		# Units with data have diag() != 0
	dropped.groups <- id[!valid.units]		# Save names of dropped groups, if any
	id <- id[valid.units]				# Update list of valid groups

	if( length(id) != N ){
		print("Dropped the following cross-section units because they had no data:")
		print( as.vector(dropped.groups) )

		N <- length(id)

		M <- matrix(0,J,N)
		for(i in 1:N){
	 		M[,i] <- resids3[group==id[i]]
		}
		MTRANSM <- (t(M) %*% M)
	}

	##############################################################################
	# Now that we've removed elements that don't contribute at all, if there's a
	# zero anywhere in the matrix, that means that unit has data that doesn't
	# overlap with other units, so exclude that unit from future analysis and
	# re-do (M'M).
	##############################################################################

	row.prods <- apply(MTRANSM,1,prod)	# if one value in row is 0, product will be too
	col.prods <- apply(MTRANSM,2,prod)	# if one value in col is 0, product will be too

	valid.units <- !(row.prods == 0. & col.prods == 0.)	# List of units with non-overlapping data
	dropped.groups <- id[!valid.units]		# Save names of dropped groups, if any
	id <- id[valid.units]				# Update list of valid groups

	ids.to.remove <- c(0)

	if( length(id) != N ){
		print("Dropped the following cross-section units because their data did not overlap:")
		print( as.vector(dropped.groups) )
	}

	########################################################################## 
	# Report cases we dropped that contributed to the regression.
	##########################################################################

	# Create a list of which cases we're using
	all.ids <- unique(group)
	invalid.cases <- !is.element( group, id )
	
	remcases <- as.vector(c(1:(length(resids)) )[invalid.cases])
	print(remcases)
	cat("Total invalid cases: ", sum(invalid.cases), "\n")

	remcases
}


###########################################################################################
# mdpcse - Calculate panel-correct standard errors when data is missing.
#
# Assumption: prep.mdpcse has been applied to the data before this function is
#		called.  It will go ahead and calculate PCSEs whether doing so is
#		appropriate or not.
#
# Returns: A matrix, for which the square root of the diagonal values is the list of
#		panel-correct standard errors.
###########################################################################################

mdpcse <- function(lmobj, group){

 	id <- unique(group)		# List of group identifiers
 	N <- length(id)			# Number of groups

	resids <- residuals(lmobj)	# Get residuals
	J <- length(resids)/N		# Number of years: this assumes rectangular data

	##############################################################################
	# Find E, the T x N matrix of residuals, with T observations for each group
	##############################################################################

	# Replace all "missing" residuals with zeros
	resids2 <- resids
	resids2[is.na(resids2)] <- 0

	# Put the residuals into the E matrix in their proper places
	# E <- as.matrix(unstack(resids2, form=resids2~group))

	E <- matrix(0,J,N)
	for(i in 1:N){
 		E[,i] <- resids2[group==id[i]]
	}

	##############################################################################
	# Generate a T x N matrix M by which to divide the matrix of residuals.
	# Each element is a 1 if data exists or 0 if data is missing.
	##############################################################################
	
	resids3 <- resids
	resids3[!is.na(resids3)] <- 1
	resids3[is.na(resids3)] <- 0
	
	M <- matrix(0,J,N)
	for(i in 1:N){
 		M[,i] <- resids3[group==id[i]]
	}

	MTRANSM <- (t(M) %*% M)

	row.prods <- apply(MTRANSM,1,prod)	# if one value in row is 0, product will be too
	if( length(row.prods[row.prods==0.]) != 0){
		cat("WARNING: Invalid cross-section units may be present in data.  ",
			"Run prep.mdpcse.\n")
	}

	##############################################################################
	# Sigma = (E'E) / (M'M), an NxN empirical covariance matrix
	# 	This is an element-by-element division.
	#	In the original version, you divide (E'E) by T.
	#	Note: If no variables are missing, each element of (M'M) is T.
	##############################################################################

	SIGMA <- (t(E) %*% E) / MTRANSM
	
	##############################################################################
	# Next, grab "model" data and put [0 0 0 .... 0] in any missing rows.
	# We delete data for the other variables, even though only one is missing,
	# because the case is excluded from the regression anyway.
	##############################################################################

	# Get the data that was used in the model.  Note: this data is missing rows
	# if there was missing data in it.
	XMODEL <- model.matrix(lmobj)

	num.cols <- dim(XMODEL)[2]		# number of parameters in the regression

	# Get the list of missing rows from the residuals
	missing.rows <- as.numeric(row.names(as.matrix(resids[is.na(resids)])))

	# Create a new matrix containing zeros, with one row per missing row
	zeromatrix<-data.frame( matrix(0,nrow=length(missing.rows),ncol=num.cols) )
	
	dimnames(zeromatrix)[[1]] <- missing.rows			# Relabel the rows in our matrix of zeros
	dimnames(zeromatrix)[[2]] <- dimnames(XMODEL)[[2]]	# Make sure column names are the same
	B<-rbind(XMODEL,zeromatrix)					# Add the rows to the matrix

	XMODEL <- B[sort.list( as.numeric( dimnames(B)[[1]] ) ), ]	# Sort the data

	##############################################################################
	# Use Jackman's code, without modification, to finish off the calculation.
	##############################################################################

	X <- as.matrix(XMODEL)
	k <- dim(X)[2]			# number of parameters in the regression
	V1 <- matrix(0,k,k)
	V2 <- matrix(0,k,k)

	for(i in 1:N){						## loop over units
		oki <- group==id[i]
		V1 <- V1 + crossprod(X[oki,])		## accumulate x-products
		for(j in 1:N){					## loop again for x-correlations
 			okj <- group==id[j]
			V2 <- V2 + (SIGMA[i,j] * t(X[oki,])%*%X[okj,]) ## the "middle matrix"
		}
	}
 	iV1 <- solve(V1)
	V <- iV1%*%V2%*%iV1
	V

}


##############################################################################
# printpcse - Print results for any of the PCSE functions
#
# Original code by Jasjeet Sekhon, UC Berkeley:
#	http://sekhon.polisci.berkeley.edu/gov2000/R/agl1.R
#
# Modified by Scott Konzem, 2/20/2006 to increase significant digits and
# add significance values.
##############################################################################
printpcse <- function(ols, VC.pcse, sigdig=4){
	
	#put on nice labels
	se  <-sqrt(diag(VC.pcse))
	parms  <- as.data.frame(cbind(ols$coef, se, ols$coef/se,
		summary(ols)$coef[,2:3], 2*(1-pt(abs(ols$coef/se), df=ols$df) )))
	names(parms)  <- c("parms", "pcse", "pcse t-stats", "ols se",
		"ols t-stats", "pcse signif")

	#print the results with df significant digits
	print(signif(parms, digits=sigdig))
}