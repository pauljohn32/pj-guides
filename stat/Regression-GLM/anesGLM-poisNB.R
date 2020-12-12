load("/home/pauljohn/ps/ps707/ANES00data/ANES00.rda")
##colnames(naes)[1:50]
attach(naes)
# put continuous thermometers at the front
newdata <- data.frame(
clinton=naes$V001292,V000359=naes$V000359,V000361=naes$V000361,V000368=naes$V000368,
V000369=naes$V000369,V000370=naes$V000370,V000372=naes$V000372,
V001294=naes$V001294,V001297=naes$V001297,
income=naes$V000184A,tvnews=naes$V000329, newspaper=naes$V000335,
clintonecon=naes$V001603
)

detach(naes)


# 1292 Clinton
# VAR 001292    D1a/D1a.T. Thermometer Clinton



#VAR 000359    C1a/C1a.T. Thermometer Bill Clinton 1-100
#VAR 000361    C1c/C1c.T. Thermometer George W Bush 1-100
#VAR 000368    C1k/C1k.T. Thermometer Hillary Clinton 1-100
#VAR 000369    C2a. Thermometer Dem Party
#VAR 000370    C2b. Thermometer Rep Party
#VAR 000372    C2d. Thermometer parties in general
#VAR 001294    D1c/D1c.T. Thermometer GW Bush
#VAR 001297    D1f/D1f.T. Thermometer former Pres Bush




# 184 income
# VAR 000184a   Post-CSheet.30. CSMS estimated income 1/2/3/4/5

# 329 news watching
# VAR 000329    A6. Number of days R watched nat'l news 1/2/3/4/5/6/7

# 335 paper reading
# VAR 000335    A10. Days R read a daily newspaper 1/2/3/4/5/6/7
# 1603 Clinton economy
# VAR 001603    S4x. Summary - Clinton made econ better/worse 1/2/3/4/5


# VAR 000301    A1. Attention R paid to campaigns                           

newdata$V000301 <- factor(naes$V000301)
# VAR 000303 vote in 1996
newdata$V000303 <- factor(naes$V000303)

# VAR 000304 who vote for 1996
#newdata$V000304 <- factor(naes$V000304)

# VAR 000330    A6a/A6a.T. Attention to national news 1/2/3/4/5
newdata$V000330 <- factor(naes$V000330)
# VAR 000331    A7. Days R watched early local news 1/2/3/4/5/6/7
newdata$V000331 <- factor(naes$V000331)

# VAR 000332    A8. Days R watched late local news 1/2/3/4/5/6/7
newdata$V000332 <- factor(naes$V000332)
# VAR 000333    A8a/A8a.T. Attention to local news 1/2/3/4/5           
newdata$V000333 <- factor(naes$V000333)
# VAR 000336    A10a. Did R read about campaign in paper                           
newdata$V000336 <- factor(naes$V000336)

# VAR 000337    A10b/A10b.T. Attention to newspaper articles 1/2/3/4/5    
#newdata$V000337 <- factor(naes$V000337)

# VAR 000338    A11. Did R see ads for candidates on tv 1/5
newdata$V000338 <- factor(naes$V000338)
# VAR 000339    A12. Approve/disappr Clinton job 1/5
newdata$V000339 <- factor(naes$V000339)
#VAR 000340    A12a. Strength of approval/disapproval of Clinton 1/5
newdata$V000340 <- factor(naes$V000340)
#VAR 000341    A12x. Summary app/disapp Clinton job 1/2/4/5
newdata$V000341 <- factor(naes$V000341)
#VAR 000356    B3. Congress job approve/dissapr
newdata$V000356 <- factor(naes$V000356)
#VAR 000357    B3a. Strength of approval/disapproval of Cong 1/5
newdata$V000357 <- factor(naes$V000357)
#VAR 000358    B3x. Summary R approval of US Congress 1/2/4/5
newdata$V000358 <- factor(naes$V000358)
#VAR 000373    D1. Like anything- Dem Party 1/5
newdata$V000373 <- factor(naes$V000373)
#VAR 000379    D2. Dislike anything- Dem Party 1/5
newdata$V000379 <- factor(naes$V000379)
#VAR 000385    D3. Like anything- Rep Party
newdata$V000385 <- factor(naes$V000385)
#VAR 000391    D4. Dislike anything- Rep Party 1/5
newdata$V000391 <- factor(naes$V000391)
#VAR 000398    E1/E1.T. Better/worse off in last year 1/3/5
newdata$V000398 <- factor(naes$V000398)
#VAR 000399    E1a. How much better off- last year 1/5
newdata$V000399 <- factor(naes$V000399)
#VAR 000400    E1b. How much worse off- last year 1/5
newdata$V000400 <- factor(naes$V000400)
#VAR 000401    E1x. Summary R econ situation last year 1/2/3/4/5
newdata$V000401 <- factor(naes$V000401)
#VAR 000406    E3x. Summary R econ situation next year 1/2/3/4/5
newdata$V000406 <- factor(naes$V000406)
#VAR 000440    G1ax. Summary: combined FTF/ph 1/2/3/4/5/6/7/9=havent thought
newdata$V000440 <- factor(naes$V000440)
#VAR 000523    K1x. Party ID summary 1/2/3/4/5/6/7
newdata$V000523 <- factor(naes$V000523)
#VAR 001604    S5. Clinton admin hurt/help R personally 1/3/5
newdata$V001604 <- factor(naes$V001604)
#VAR 001604a   S5x. Clinton admin hurt/help R economically? 1/3/5
newdata$V001604A <- factor(naes$V001604A)
#VAR 001608    S6x. Summary - U.S. security 1/2/3/4/5
newdata$V001608 <- factor(naes$V001608)
#VAR 001612    S7x. Summ-Clinton impact on U.S. security 1/2/3/4/5
newdata$V001612 <- factor(naes$V001612)
#VAR 001616a   S8x1. Summary pre & post - U.S. crime rate
newdata$V001616A <- factor(naes$V001616A)
#VAR 001620a   S9x1.Summ pre & post - Clinton impact on crime 1/2/3/4/5
newdata$V001620A <- factor(naes$V001620A)
#VAR 001624    S10x. Summary - moral climate since 92
newdata$V001624 <- factor(naes$V001624)

#newspaper is DV

paper1 <- glm(newspaper~V001604A ,data=newdata, family=poisson)

summary(paper1)


paper1 <- glm(newspaper~V001604A+V000330 ,data=newdata, family=poisson)
summary(paper1)

library(MASS)
paper2 <- glm.nb(newspaper~V001604A+V000330 ,data=newdata)
summary(paper2)


paper3 <- glm.nb(newspaper~V001604A+V000330+V000401 ,data=newdata)
summary(paper3)


library(effects)

eff3 <- all.effects(paper3)
eff3


print(eff3,type="response")

print(eff3,type="link")

par(mfcol=c(3,1))
plot(eff3, rescale.axis=F, ask=F)

dev.copy(postscript,file="anesGLM1.eps",height=9, width=6.5, horizontal=F, onefile=F)
dev.off()
