# ===== GLMs.ho2.R =====


# GLMs - 02


# Set working directory (user-provided)
setwd("D:/Users/lenovo/Desktop/Statistic in R/Week6/handout/monday")

# Load libraries
require(ggplot2)
require(ggpubr)

# ---------- Binary Models: Varoa spp in Honeycomb Cells ----------

worker<- read.csv("workerbees.csv", stringsAsFactors = T)
str(worker)

# Visualization
scatterplot<-ggplot(worker, aes(x=CellSize, y=Parasites))+
  geom_point()+
  labs(x= "Cell Size (cm)", y="Probability of Parasite")+
  theme_classic()
boxplot<- ggplot(worker, aes(x=factor(Parasites), y=CellSize))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Presence/Absence of Parasites", y="Cell Size (cm)")

# Arrange plots
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

# Fit binomial GLM (binary)
M1<- glm(Parasites~CellSize, data = worker, family = "binomial")
summary(M1)

# ANOVA (deviance)
anova(M1, test = "Chisq")

# Plot predicted probability with CIs
range(worker$CellSize)
new_data <- data.frame(CellSize=seq(from=min(worker$CellSize), to=max(worker$CellSize), length=100))
predictions<- predict(M1, newdata = new_data, type = "link", se.fit = TRUE)
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

ggplot(new_data, aes(x=CellSize, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(worker, mapping = aes(x=CellSize, y=Parasites), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Cell Size (cm)")+
  theme_classic()

# ---------- Binary Models: Chytrid Infection Status in the Pyrenees ----------

chytrid<- read.csv("chytrid.csv", stringsAsFactors = T)
str(chytrid)

# Visualisation
scatterplot<-ggplot(chytrid, aes(x=Springavgtemp, y=InfectionStatus))+
  geom_point()+
  labs(x= "Probability of Infection", y="Average Spring Temperature (Degrees Celsius)")+
  theme_classic()
boxplot<- ggplot(chytrid, aes(x=factor(InfectionStatus), y=Springavgtemp))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Presence/Absence of Infection", y="Average Spring Temperature (Degrees Celsius)")

ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

# Fit binary GLM
M2<- glm(InfectionStatus~Springavgtemp, data = chytrid, family = "binomial")
summary(M2)
anova(M2, test="Chisq")

# Flipping point and plot
# flipping point = -Intercept / Slope
range(chytrid$Springavgtemp)
new_data <- data.frame(Springavgtemp=seq(from=min(chytrid$Springavgtemp), to=max(chytrid$Springavgtemp), length=100))
predictions<- predict(M2, newdata = new_data, type = "link", se.fit = TRUE)
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

ggplot(new_data, aes(x=Springavgtemp, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(chytrid, mapping = aes(x=Springavgtemp, y=InfectionStatus), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Average Spring Temperature (Degrees Celsius)")+
  theme_classic()

# ---------- Binomial Models: aggregated chytrid data ----------

chytrid_binomial<- read.csv("chytrid_binomial.csv", stringsAsFactors = T)
str(chytrid_binomial)

# Fit binomial GLM using cbind(Positives, Total-Positives)
M3<- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family = "binomial")
summary(M3)
anova(M3, test="Chisq")

par(mfrow=c(2,2))
plot(M3)
sum(cooks.distance(M3)>1)

# Fit quasibinomial to account for overdispersion
M4<- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family = "quasibinomial")
summary(M4)
anova(M4, test="F")

# Plot quasibinomial model (as in handout)
range(chytrid_binomial$AverageSpringTemp)
new_data <- data.frame(AverageSpringTemp=seq(from=min(chytrid_binomial$AverageSpringTemp), to=max(chytrid_binomial$AverageSpringTemp), length=100))
predictions<- predict(M4, newdata = new_data, type = "link", se.fit = TRUE)
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

ggplot(new_data, aes(x=AverageSpringTemp, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(chytrid_binomial, mapping = aes(x=AverageSpringTemp, y=(Positives/Total)), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Average Spring Temperature (Degrees Celsius)")+
  theme_classic()

# ---------- Revisit Bee Mites: now as binomial ----------
mites<- read.csv("bee_mites.csv")
M5<- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data = mites, family = "binomial")
summary(M5)
anova(M5, test = "Chisq")

par(mfrow=c(2,2))
plot(M5)

# Check dispersion
# DispersionParameter = Residual deviance / residual df

# Fit quasibinomial if overdispersed
M6<- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data = mites, family = "quasibinomial")

# Plot quasibinomial model as in handout
range(mites$Concentration)
new_data <- data.frame(Concentration=seq(from=min(mites$Concentration), to=max(mites$Concentration), length=100))
predictions<- predict(M6, newdata = new_data, type = "link", se.fit = TRUE)
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

ggplot(new_data, aes(x=Concentration, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(mites, mapping = aes(x=Concentration, y=(Dead_mites/Total)), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Concentration")+
  theme_classic()

