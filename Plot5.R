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
head(NEI)

  # search for the relevant informations in the SCC data frame
onRoad<-subset(NEI,type =="ON-ROAD")
dim(onRoad)                                # 3183599  rows
head(onRoad,20)

    motor <-SCC[grep(".*[Gg]asoline [Ll]ight.*|.*[Dd]iesel [Ll]ight.*|
                     .*[Gg]asoline [Hh]eavy.*|.*[Dd]iesel [Hh]eavy.*",
                     SCC$EI.Sector),]
 dim(motor)
# testing
m1<-SCC[grep(".*[Gg]asoline [Ll]ight.*",SCC$EI.Sector),];dim(m1)
m2<-SCC[grep(".*[Dd]iesel [Ll]ight.*",SCC$EI.Sector),];dim(m2)
m3<-SCC[grep(".*[Gg]asoline [Hh]eavy.*",SCC$EI.Sector),];dim(m3)
m4<-SCC[grep(".*[Dd]iesel [Hh]eavy.*",SCC$EI.Sector),];dim(m4)

b<-merge(m1,m2,all=TRUE)
c<-merge(m3,m4,all=TRUE)
a<-merge(c,b,all=TRUE)
head(a)
merg <- merge(a,NEI,by.x = "SCC", by.y = "SCC")

#merge the motor and the NEI data frames
    
    mergedData <- merge(motor,NEI,by.x = "SCC", by.y = "SCC")
    dim(mergedData)  #2911807 Rows
    Baltimore <- subset(mergedData,fips == "24510")

  #Prepare for Plotting group data
    Group<-tapply(Baltimore$Emissions,Baltimore$year, sum)# right answer!
ls()
rm(b,c)

##################################################################################
##############################             #######################################
##############################  plotting   #######################################
##############################             #######################################
##################################################################################



# open png function to safe the file as  png 
png("Plot5.png",height = 500,width = 600, units="px")


#plotting
par(mar = rep(2, 4))
barplot(Group, main="Emmisssions Distribution", 
        xlab="Number of years")


#close the connection
dev.off()
