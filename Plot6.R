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

  # group the Emissions by years and by fips(cities)
    mySubset<- aggregate(Emissions~year + fips ,cities, sum)

  # insert the names of the concerned cities in the data frame
    for (i in 1:8){
      
      if(mySubset[i,"fips"]=="06037"){
        mySubset[i,"fips"]<-"Los Angeles"
      }
  
      if(mySubset[i,"fips"]=="24510"){
        mySubset[i,"fips"]<-"Baltimore"
      }
    }

##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################

    
library(ggplot2)

  #open png function to safe the file as  png 
    png("Plot6.png",height= 700,width=850, units="px")


  #Plotting 
    g<-ggplot(mySubset,aes(year,Emissions))
    g+
    geom_point() +
    geom_smooth(method="lm") + 
    facet_grid(.~fips)

  #close the connection
    dev.off()



