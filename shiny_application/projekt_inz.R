#================================= BIBLIOTEKI ===============================================================

library(ggplot2)
library(openxlsx)
library(dplyr)
library(tidyverse)
library(plotly)
library(gridExtra)

#============================== IMPORT DANYCH I WSTEPNA OBROBKA ============================================

setwd("C:/Users/mateu/OneDrive/Pulpit/dane_inz/")
Wskaznik_HDI <- read.csv(file= "INEQUALITY_ADJUSTED_HDI_PROJ.csv", sep= ",", header=TRUE)
PKB_na_mieszkanca <- read.xlsx(xlsxFile = "GDP_PER_CAPITA_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Wspolczynnik_Giniego <- read.xlsx(xlsxFile = "GINI_INDEX_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Smiertelnosc_niemowlat <- read.xlsx(xlsxFile = "INFANT_MORTALITY_RATE_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
Ogolne_szczescie <- read.xlsx(xlsxFile = "HAPPINESS_SCORE_PROJ.xlsx", sheet = 1, skipEmptyRows = FALSE)
# Dla danych "Ogolne_szczescie" jest oddzielny plik R, w którym zosta³ utworzony plik Excel - HAPPINESS_SCORE_PROJ.xlsx.

names(Wskaznik_HDI) <- c("ranking", "region", "rok.2010","rok.2011","rok.2012","rok.2013",
                     "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019")

names(PKB_na_mieszkanca) <- c("region", "rok.2010","rok.2011","rok.2012","rok.2013",
                     "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019",
                     "rok.2020","rok.2021")

names(Wspolczynnik_Giniego) <- c("region","rok.2009", "rok.2010","rok.2011","rok.2012","rok.2013",
                            "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019",
                            "rok.2020")

names(Smiertelnosc_niemowlat) <- c("region","rok.2009", "rok.2010","rok.2011","rok.2012","rok.2013",
                                  "rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019")


Wskaznik_HDI <- select(Wskaznik_HDI,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019"))
PKB_na_mieszkanca <- select(PKB_na_mieszkanca,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019","rok.2020","rok.2021"))
Wspolczynnik_Giniego <- select(Wspolczynnik_Giniego,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019","rok.2020"))
Smiertelnosc_niemowlat <- select(Smiertelnosc_niemowlat,c("region","rok.2012","rok.2013","rok.2014","rok.2015","rok.2016","rok.2017","rok.2018","rok.2019"))


Wspolczynnik_Giniego <- Wspolczynnik_Giniego[-37, ]
Smiertelnosc_niemowlat <- Smiertelnosc_niemowlat[-c(38,40,42,43,44,46,47,48), ]
rownames(Smiertelnosc_niemowlat) <- 1:nrow(Smiertelnosc_niemowlat)
Ogolne_szczescie[,2:6] <- round(Ogolne_szczescie[,2:6], 3)    # zaokr¹glanie wszystkich kolumn do 3 miejsc po przecinku

# Tworze dodatkowa ramke danych dla "Ogolne_szczescie" w celu usprawnienia dzialania wykresow w aplikacji
Ogolne_szczescie_2012_2019 <- Ogolne_szczescie %>%
  add_column(
    rok.2012 = "NA",   #dodawanie 0 kolumn
    rok.2013 = "NA",
    rok.2014 = "NA", .after="region")


