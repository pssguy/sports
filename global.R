## 

library(shiny)
library(dplyr)
library(ggvis)
library("rmarkdown")
library(shinythemes)

testBatting <- readRDS("testBatting.rds")

playerChoices <- sort(unique(as.character(testBatting$Player))) #2750S
teamChoices <- sort(unique(as.character(testBatting$Country)))
teamChoices <- teamChoices[-4]
teamChoices_All <- c("All Countries",teamChoices)  