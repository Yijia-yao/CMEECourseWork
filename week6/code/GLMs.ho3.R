# ===== GLMs.ho3.R =====


# GLMs - 03

# Set working directory (user-provided)
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week6/handout/tuesday and wednesday")

# Load libraries
require(ggplot2)
require(ggpubr)

# ---------- Binary Models: Varoa spp in Honeycomb Cells ----------
# Data: workerbees.csv
d<-read.table("SparrowSize(2).txt", header=TRUE)
str(d)
names(d)
head(d)

#Centrality	and	spread
hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey")

mean(d$Tarsus, na.rm = TRUE)

var(d$Tarsus, na.rm = TRUE)

sd(d$Tarsus, na.rm = TRUE)


hist(d$Tarsus, main = "", xlab = "Sparrow tarsus length (mm)", col = "grey", prob = TRUE)
lines(density(d$Tarsus, na.rm = TRUE), lwd = 2)
abline(v = mean(d$Tarsus, na.rm = TRUE), col = "red", lwd = 2)
abline(v = mean(d$Tarsus, na.rm = TRUE) - sd(d$Tarsus, na.rm = TRUE), col = "blue", lwd = 2, lty = 5)
abline(v = mean(d$Tarsus, na.rm = TRUE)+sd(d$Tarsus, na.rm = TRUE), col = "blue",lwd = 2, lty=5)

t.test(d$Tarsus~d$Sex)

par(mfrow=c(2,1))
hist(d$Tarsus[d$Sex==1], main="", xlab="Male sparrow tarsus length (mm)", col
     ="grey", prob=TRUE) 
lines(density(d$Tarsus[d$Sex==1],na.rm=TRUE), lwd = 2) 
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "red",lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)-sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "blue",lwd = 2, lty=5)
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)+sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "blue",lwd = 2, lty=5)
hist(d$Tarsus[d$Sex==0], main="", xlab="Female sparrow tarsus length (mm)", col="grey", prob=TRUE) 
lines(density(d$Tarsus[d$Sex==0],na.rm=TRUE), lwd = 2) 
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "red",lwd = 2)
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)-sd(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "blue",lwd = 2, lty=5)
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)+sd(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "blue",lwd = 2, lty=5)
dev.off()

#Variance
var(d$Tarsus,na.rm=TRUE)

sd(d$Tarsus,na.rm=TRUE)

sd(d$Tarsus,na.rm=TRUE)^2

sqrt(var(d$Tarsus,na.rm=TRUE))

d1<-subset(d, d$Tarsus!="NA")
d1<-subset(d1, d1$Wing!="NA")
sumz<-var(d1$Tarsus)+var(d1$Wing)
test<-var(d1$Tarsus+d1$Wing)
sumz
test

plot(jitter(d1$Wing),d1$Tarsus, pch=19, cex=0.4)

cov(d1$Tarsus,d1$Wing)

sumz<-var(d1$Tarsus)+var(d1$Wing)+2*cov(d1$Tarsus,d1$Wing)
test<-var(d1$Tarsus+d1$Wing)
sumz
test

var(d1$Tarsus*10)

var(d1$Tarsus)*10^2


# Linear models
uni<-read.table("RUnicorns(1).txt", header=T)
str(uni)

head(uni)
mean(uni$Bodymass)
sd(uni$Bodymass)
var(uni$Bodymass)
hist(uni$Bodymass)

mean(uni$Hornlength)
## [1] 5.709
sd(uni$Hornlength)
## [1] 1.229192
var(uni$Hornlength)
## [1] 1.510912
hist(uni$Hornlength)

plot(uni$Bodymass~uni$Hornlength, pch=19, xlab="Unicorn horn length", ylab="U
nicorn body mass", col="blue")
mod<-lm(uni$Bodymass~uni$Hornlength)
abline(mod, col="red")
res <- signif(residuals(mod), 5)
pre <- predict(mod) 
segments(uni$Hornlength, uni$Bodymass, uni$Hornlength, pre, col="black")

hist(uni$Bodymass)
hist(uni$Hornlength)
hist(uni$Height)

cor.test(uni$Hornlength,uni$Height)

boxplot(uni$Bodymass~uni$Gender)

par(mfrow=c(2,1))
boxplot(uni$Bodymass~uni$Pregnant)
plot(uni$Hornlength[uni$Pregnant==0],uni$Bodymass[uni$Pregnant==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(uni$Hornlength[uni$Pregnant==1],uni$Bodymass[uni$Pregnant==1], pch=19, 
       col="red")
dev.off()
boxplot(uni$Bodymass~uni$Pregnant)

plot(uni$Hornlength[uni$Gender=="Female"],uni$Bodymass[uni$Gender=="Female"], 
     pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(uni$Hornlength[uni$Gender=="Male"],uni$Bodymass[uni$Gender=="Male"],pch=19, col="red")
points(uni$Hornlength[uni$Gender=="Undecided"],uni$Bodymass[uni$Gender=="Undecided"],pch=19, col="green")

plot(uni$Hornlength[uni$Glizz==0],uni$Bodymass[uni$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(uni$Hornlength[uni$Glizz==1],uni$Bodymass[uni$Glizz==1], pch=19, col="red")

FullModel<-lm(uni$Bodymass~uni$Hornlength+uni$Gender+uni$Pregnant+uni$Glizz)
summary(FullModel)

u1<-subset(uni, uni$Pregnant==0)
FullModel<-lm(u1$Bodymass~u1$Hornlength+u1$Gender+u1$Glizz)
summary(FullModel)

ReducedModel<-lm(u1$Bodymass~u1$Hornlength+u1$Glizz)
summary(ReducedModel)

plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red"
)
abline(ReducedModel)

ModForPlot<-lm(u1$Bodymass~u1$Hornlength)
summary(ModForPlot)

plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19))
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red"
)
abline(ModForPlot)

boxplot(u1$Hornlength~u1$Glizz)

t.test(u1$Hornlength~u1$Glizz)

plot(ReducedModel)
View(u1)

plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(3,8), ylim=c(6,15))
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red"
)
abline(ReducedModel)


#Linear	models	- interpretation	of	interactions	- two-level	fixed	factor and	continuous variable
rm(list=ls())
dat<-read.table("data(1).txt", header=TRUE)
head(dat)
str(dat)
summary(dat)
fullmodel<-(lm(species_richness~fertilizer*method,data=dat))
summary(fullmodel)

plot(
  dat$species_richness[dat$method == "conventional"] ~ 
    dat$fertilizer[dat$method == "conventional"],
  pch = 16, col = "grey",
  xlim = c(0, 50), ylim = c(0, 70),
  xlab = "Fertilizer (units)",
  ylab = "Species richness"
)
points(
  dat$fertilizer[dat$method == "organic"],
  dat$species_richness[dat$method == "organic"],
  pch = 16, col = "black"
)


#Linear	models	- interpretation	of	interactions	- three-level	fixed	factor and	continuous variable
rm(list=ls())
getwd()
d<-read.table("Three-way-Unicorn(1).txt", header=TRUE)
str(d)
names(d)
head(d)

mean(d$Bodymass)
## [1] 86.22465
sd(d$Bodymass)
## [1] 5.299923
var(d$Bodymass)
## [1] 28.08919
par(mfrow=c(1,2))
hist(d$Bodymass, main="")
mean(d$HornLength)
## [1] 9.061447
sd(d$HornLength)
## [1] 2.997955

var(d$HornLength)
## [1] 8.987736
hist(d$HornLength, main="")

dev.off()

plot(d$HornLength[d$Gender=="male"]~d$Bodymass[d$Gender=="male"], xlim=c(70,100),ylim=c(0,18), pch=19, xlab="Bodymass (kg)", ylab="Hornlength (cm)")
points(d$Bodymass[d$Gender=="female"],d$HornLength[d$Gender=="female"], col="red", pch=19)
points(d$Bodymass[d$Gender=="not_sure"],d$HornLength[d$Gender=="not_sure"], col="green", pch=19)

mod<-lm(HornLength~Gender*Bodymass, data=d)
summary(mod)

