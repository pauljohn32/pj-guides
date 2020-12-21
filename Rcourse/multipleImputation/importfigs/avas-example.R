
pdf.options(onefile=F,family="Times",pointsize=12, height=6, width=6)
ps.options(horizontal=F, onefile=F, family="Times", paper="special", height=12, width=6)
options(papersize="special")


library(car)
library(acepack)

UN2 <- na.omit(UN)


pdf()

plot(infant.mortality~gdp, data=UN2, xlab="Gross Domestic Product", ylab="Infant Mortality (per 1000 live births)")


A2 <- avas(x=UN2$gdp, y=UN2$infant.mortality)

plot(A2$tx, A2$ty, xlab="avas transformed x", ylab="avas transformed y")
m1 <- lm(A2$ty ~ A2$tx)
abline(m1)

dev.off()
