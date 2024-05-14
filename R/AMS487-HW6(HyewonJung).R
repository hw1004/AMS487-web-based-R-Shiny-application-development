### AMS 394 - HW6 (your name)
## Problem 1
library(MASS)
head(painters)

x <- subset(painters, Colour >= 17 & School == 'D')
x

y <- subset(painters, row.names(painters) %in% c("Da Udine", "Barocci"))
y

z <- subset(x, select = c("Composition", "Drawing"))
z

painters$Comp.cat <- cut(painters$Composition, breaks = quantile(painters$Composition, probs = seq(0,1,0.25)), labels = c("Q1","Q2","Q3","Q4"))
painters

anova_result <- aov(cbind(Composition, Drawing, Colour, Expression) ~ Comp.cat, data = painters)
anova_result
summary(anova_result)

## Problem 2
file.path <- "C:/Users/USER/Assignment6/Assignment 6 (Data)/sal.sam.dat.qc.txt"
dat <- read.table(file.path, header=TRUE, sep="\t", na.strings = "NA")
dat

rows <- nrow(dat)
cols <- ncol(dat)
rows
cols

unique_id <- length(unique(dat$id))
unique_id
duplicated_id <- sum(duplicated(dat$id))
duplicated_id

sort_asc <- dat[order(dat$id, dat$time.pt),]
sort_asc
sort_desc <- dat[order(dat$id, -dat$time.pt),]
sort_desc

first.visit.dat <- subset(dat, time.pt == 1)
first.visit.dat

last.visit.dat <- subset(dat, time.pt == max(dat$time.pt))
last.visit.dat

first.visit.dat <- subset(sort_asc, time.pt == 1, select = -alphacode)
first.visit.dat

second.time.dat <- subset(sort_asc, time.pt == 2, select = -alphacode)
second.time.dat

welch.t.test.result <- t.test(age ~ ecig_status, data = first.visit.dat, var.equal = FALSE)
welch.t.test.result
# since p-value is 0.4139 > 0.05, accept null hypothesis(mean value is the same)

anova_result <- aov(age ~ infla, data = first.visit.dat)
anova_result
summary(anova_result)
# P-value is 0.026 < 0.05 reject null hypothesis. There is a significant differences in mean age by infla

com_dat <- rbind(first.visit.dat, second.time.dat)
com_dat

## Problem 3
fev <- data.frame(
  ID = c(1,1,1,2,2,2,3),
  Year = c(1,2,3,1,2,3,1),
  FEV = c(2500, 2700, 2900, 2450, 2550, 2750, 1600)
)
fev

asthma <- data.frame(
  ID = c(1,1,1,2,2,3),
  Year = c(1,3,2,1,2,1),
  Asthma = c("No", "Yes", "No", "No", "Yes", "No")
)
asthma

fev.asthma <- merge(fev, asthma, by = c("ID", "Year"))
fev.asthma

fev.asthma.sub <- merge(fev, asthma, by = c("ID", "Year"), all.y = TRUE)
fev.asthma.sub

health <- data.frame(
  ID = c(1,2,3,4,5,6),
  City = c("RIV", "RIV", "RIV", "UPL", "UPL", "UPL"),
  Gender = c("M", "F", "M", "F", "M", "F"),
  FEV = c(2600, 2450, 2300, 2200, 2700, 2500)
)
health

pollution <- data.frame(
  Town = c("RIV", "UPL", "LKA"),
  Ozone = c(81.1, 75.5, 100),
  PM10 = c(50.1, 45.2, 35.0)
)
pollution

health.pollution <- merge(health, pollution, by.x = 'City', by.y = 'Town')
health.pollution

## Problem 4
wide.data.frame <- data.frame(
  ID = c(1,2,3),
  Program = c("CONT", "RI", "WI"),
  S1 = c(85,79,84),
  S2 = c(85,79,85),
  S3 = c(86,79,84),
  S4 = c(85,80,83)
)
library(reshape2)
long <- melt(wide.data.frame, id.vars = "ID") 
long
wide <- melt(long, id.vars = "ID")
wide
