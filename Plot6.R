#Plot6.R
################################################################################
#########################                        ###############################
#########################    resizing the data   ###############################
#########################                        ###############################
################################################################################

  # download and unzip the data
    if (!file.exists("./exdata-data-NEI_data.zip")){
      Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(Url, destfile="./exdata-data-NEI_data.zip")
      unzip("./exdata-data-NEI_data.zip")
      downloadTime<-date()
    }

  #load the 2 data sets
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

  # subseting the Table
  # search for the relevant informations in the SCC data frame
    onRoad<-subset(NEI,type =="ON-ROAD")
    
    
  # subset the onRoad data frame to find relevant data 
    #for both cities Baltimore and Los Angeles  
    cities<- subset(onRoad,fips == "24510" | fips == "06037")

  
  # insert the names of the concerned cities in the data frame
    for (i in 1:nrow(cities)){
      
      if(cities[i,"fips"]=="06037"){
        cities[i,"fips"]<-"Los Angeles"
      }
  
      if(cities[i,"fips"]=="24510"){
        cities[i,"fips"]<-"Baltimore"
      }
    }


##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################

    
library(ggplot2)

  #open png function to safe the file as  png 
    png("Plot6.png",height= 600,width=700, units="px")


  #Plotting 
    qplot(year,
          Emissions,
          data=cities,
          color=fips,
          geom=("smooth"),
          method="lm")


  #close the connection
    dev.off()


