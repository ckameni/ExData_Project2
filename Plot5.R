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


  # subset the onRoad data frame to find
    #relevant data for Baltimore   
    Baltimore <- subset(onRoad,fips == "24510")


  # group the Emissions by years 
    mySubset<-tapply(Baltimore$Emissions,Baltimore$year, sum)


##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################



# open png function to safe the file as  png 
png("Plot5.png",height = 500,width = 600, units="px")


#plotting
barplot(mySubset, main="Plot5", 
        xlab="years",ylab="Emissions")


#close the connection
dev.off()
