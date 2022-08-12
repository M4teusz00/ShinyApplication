install.packages("writexl")
library(writexl)

setwd("C:/Users/mateu/OneDrive/Pulpit/dane_inz/")
rok_2015 <- read.csv(file= "2015.csv", sep= ",", header=TRUE)
rok_2015 <- select(rok_2015, c("Country","Happiness.Score"))
names(rok_2015) <- c("region","rok.2015")

rok_2016 <- read.csv(file= "2016.csv", sep= ",", header=TRUE)
rok_2016 <- select(rok_2016, c("Country","Happiness.Score"))
names(rok_2016) <- c("region","rok.2016")

rok_2017 <- read.csv(file= "2017.csv", sep= ",", header=TRUE)
rok_2017 <- select(rok_2017, c("Country","Happiness.Score"))
names(rok_2017) <- c("region","rok.2017")

rok_2018 <- read.csv(file= "2018.csv", sep= ",", header=TRUE)
rok_2018 <- select(rok_2018, c("Country.or.region","Score"))
names(rok_2018) <- c("region","rok.2018")

rok_2019 <- read.csv(file= "2019.csv", sep= ",", header=TRUE)
rok_2019 <- select(rok_2019, c("Country.or.region","Score"))
names(rok_2019) <- c("region","rok.2019")


df_list <- list(rok_2015, rok_2016, rok_2017, rok_2018, rok_2019)

#merge all data frames in list
dane_happiness <- df_list %>% reduce(full_join, by='region')

write_xlsx(dane_happiness,"C:/Users/mateu/OneDrive/Pulpit/dane_inz/HAPPINESS_SCORE_PROJ.xlsx")
