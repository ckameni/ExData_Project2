#Plot1.R
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


  #subseting the data
    # find the sum of the emmissions for each year
    mySum<-tapply(NEI$Emissions, NEI$year, sum)



##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################



  # open png function to safe the file as  png 
    png("Plot1.png",height = 500,width = 600, units="px")
    
  # plot mySum
    barplot(mySum, main="Plot1", xlab="years", ylab="Sum of Emissions")  
    
  # adding regression line
    abline(coef(line(mySum)))

  #close the connection
    dev.off()


