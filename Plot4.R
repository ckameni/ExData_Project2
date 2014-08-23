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
     
  
  #search for Coal in column "EI.Sector" 
    coal_EI<-grep(".*[cC]oal.*",SCC$EI.Sector)
  
  #create a data frame with coal related data
    coalDf<-SCC[coal_EI,]

    
  #merge NEI and EIdf
    Data <-  merge(coalDf ,NEI,by.x = "SCC", by.y = "SCC")
    
    
    
  # Prepare the data for plotting by grouping them
    mySubset <- tapply(Data $Emissions, Data $year, sum)


##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################



  # open png function to safe the file as  png 
    png("Plot4.png",height = 500,width = 600, units="px")


  # Plotting
    barplot(mySubset, main = "Plot4",xlab="years", ylab="Sum of Emissions")
    

  # close the connection
    dev.off()

