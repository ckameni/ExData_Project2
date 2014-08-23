#Plot3.R
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


  #NEI data ist tooo big: we have to reduce it first
  # create a smaller data frame with relevant data for this problem
    Data<-NEI[,4:6]
   

  # Remove the NEI data from Work space  to make space in the RAM
    rm(NEI)

  # preparing the data:
  # calculate the mean foreach of the fours types with the function "aggregate()"
    AggData <- aggregate(Emissions~year + type ,Data, sum)
    

##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################

    library(ggplot2)
    
  # open png function to safe the file as  png 
    png("Plot3.png",height= 700,width=850, units="px")

        
  #Plotting 
    g<-ggplot(AggData,aes(year,Emissions))
    g+
    geom_point() +
    geom_smooth(method="lm") + 
    facet_grid(.~type)
        
    #close the connection
    dev.off()
