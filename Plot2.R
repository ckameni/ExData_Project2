Plot2.R
#############################################################################
######################                        ###############################
######################    resizing the data   ###############################
######################                        ###############################
#############################################################################

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

 
  # reduce the NEI dataframe to a data frame with only value concening
  # the baltimore city
    baltimore <- subset(NEI,fips == "24510")
    
   # find the sum of the emmissions for each year in the baltimore city
    mySubset<-tapply(baltimore$Emissions, baltimore$year, sum)


#############################################################################
###########################             #####################################
###########################  plotting   #####################################
###########################             #####################################
#############################################################################


  # open png function to safe the file as  png 
    png("Plot2.png",height = 500,width = 600, units="px")

  # plotting
    barplot(mySubset, main= "Plot2", xlab="years", ylab="Sum of Emissions")
    
  # adding regression line
    abline(coef(line(mySubset)))

  #close the connection
    dev.off()


