## Paul E. Johnson
## 20130723



## One to many merge.
## Example. many students sit within one teacher's class.
## There may be individual-level and class variables we put together.
##
## Example. surveys collect data in various cities. We might
## have individual-level phenomena mixed with city-level phenomena.
## Then state effects, national effects...


dat1 <- data.frame(id = 1: 20, teacherID = rep(1:5, 4), math = rnorm(20))


dat2 <- data.frame(teacherID = 1:5, teach1 = c(20, 10, 5, 30, 40),
                   teach2 = rnorm(5)) 


## How to put the teacherID information "onto" the students?
## various ways.

## If you just want teach1, then "manufacture" by using indices


dat2$teach1
dat2$teach1[dat1$teacherID]


dat1$teach1 <- dat2$teach1[dat1$teacherID]
dat1

dat1$teach1 <- NULL ## erased that variable

## Method 2


d1matchd2 <- match(dat1$teacherID, dat2$teacherID)
## asks bits of dat2 would you line up with dat1
d1matchd2
## What's this:
dat2$teach1
dat2$teach1[d1matchd2]
## manufactures a column of the correct size

dat1$teach1 <- dat2$teach1[d1matchd2]
dat1

dat1$teach2 <- dat2$teach2[d1matchd2]
dat1

## Sort that to understand better:

dat1 <- dat1[ order(dat1$teacherID, dat1$id), ]
dat1


## Not so simple to re-order columns as you might wish

## can use numeric indexes
dat1n <- dat1[ , c(2, 1, 4, 5, 3)]
dat1n

## I think that's error prone, use named values instead.

dat1n <- dat1[ , c("teacherID", "id", "math", "teach1", "teach2")]
dat1n


## Lets try merge now

merge(dat1, dat2, by = c("teacherID"))



## That's OK, now lets cause some trouble.

dat1$teacherID[7] <- NA
dat2$teach1[3] <- NA
merge(dat1, dat2, by = c("teacherID"))
merge(dat1, dat2, by = c("teacherID"), all.x = TRUE)
merge(dat1, dat2, by = c("teacherID"), all = TRUE)
## all.x = TRUE same as all = TRUE, but that's not always true :)


## Now more  trouble. Add a teacher for whom there are no students.

dat2[6, ] <- c(19, 55, 2.1)
dat2
merge(dat1, dat2, by = c("teacherID"))
merge(dat1, dat2, by = c("teacherID"), all.x = TRUE)
merge(dat1, dat2, by = c("teacherID"), all.y = TRUE)
merge(dat1, dat2, by = c("teacherID"), all = TRUE)




