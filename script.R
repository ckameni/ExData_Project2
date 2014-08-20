
# load the data
Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile="E:/data/ExData_Project2/Assignment.zip")
unzip("./Assignment.zip")

dir()

#read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

rm(list=ls())


##P2_q1
# first alternativ- my prefered
zy<-tapply(NEI$Emissions, NEI$year, sum)# right answer!
zy
barplot(zy, main="Emmisssions Distribution", 
        xlab="Number of years")


zm<-tapply(NEI$Emissions, NEI$year, mean)# right answer!
barplot(zm, main="Emmisssions Distribution", 
        xlab="Number of years")

#### P2_q2 
#Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008?

baltimore <- subset(NEI,fips == "24510")

zb<-tapply(baltimore$Emissions, baltimore$year, sum)# right answer!
zb
barplot(zb, main="Emmisssions", xlab=" years")

#####p2_q3
library(ggplot2)
# one of the options

# look for the mean not the sum like q1 & q2
xy <- aggregate(Emissions~year + type ,NEI, meam) # my favourite way to do it
xy
qplot(year,Emissions,data =xy, facets= .~type,geom=c("point","smooth"),method = "lm")


g<-ggplot(xy,aes(year,Emissions))
g + geom_point() +
  geom_smooth(method="lm") + facet_grid(.~type)

######P2_q4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# column "Short.Namer" has coal 
     # coal_Short 
      coal_Short<-grep(".*[cC]oal.*",SCC$Short.Name)

# column "EI.Sector" has coal too
      #coal_EI
      coal_EI<-grep(".*[cC]oal.*",SCC$EI.Sector)

# coal_Short & coal_Short have different lengths
 #find the differents rows betrween boths variables
      diff<-setdiff(coal_EI,coal_Short) 

# Coal_short contains the coal_Ei vrctor except the "diff" vector that we calculated
      #combine coal_Short and diff
    coal_df<-SCC[coal_Short,]
    diff_df<-SCC[diff,]

      # merging
    coal_df<- rbind(coal_df,diff_df) #here're all the coal related tada

      #merge the data
    coalData <- merge(coal_df,diff_df,all= TRUE)

  
#merge NEI and CoalData from SCC
     Data <-  merge(coalData ,NEI,by.x = "SCC", by.y = "SCC")

# Prepare the data for plotting by grouping them
group<-tapply(Data $Emissions, Data $year, sum)# right answer!

# Plotting
par(mar = rep(2, 4))
barplot(group, main="Emmisssions Distribution", 
        
        xlab="Number of years")



myMeltData<-melt(myDataFrame, id.var="Year")
#####################################################################

####p2_q5
# go to epa website 4.1 P.89 and 4.6 P.113 to find the definition of motor vehicle sources
#http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf
  #view the source list
kl<-unique(as.vector(SCC[,4]))

#  search fo the relevant informations in the SCC data frame

 motor <-SCC[grep("[Ll]ocomotives|[Mm]arine |[Aa]ircraft|[Gg]asoline [Ll]ight|[Dd]iesel [Ll]ight|[Gg]asoline [Hh]eavy|[Dd]iesel [Hh]eavy",
               SCC$EI.Sector),];dim(bd_l);dim(motor)
  
#merge the motor and the NEI data frames

mergedData <- merge(motor,NEI,by.x = "SCC", by.y = "SCC")
dim(mergedData)
Baltimore <- subset(mergedData,fips == "24510")

 # group data
mB<-tapply(Baltimore$Emissions,Baltimore$year, sum)# right answer!
mB

# plotting
par(mar = rep(2, 4))
barplot(mB, main="Emmisssions Distribution", 
        xlab="Number of years")


######P2_Q6
# Batimore data
Baltimore <- subset(mergedData,fips == "24510")
mB<-tapply(Baltimore$Emissions,Baltimore$year, sum)# right answer!
mB

#Losangeles data
LosAngeles <- subset(mergedData,fips == "06037")
mLA<-tapply(LosAngeles$Emissions,LosAngeles$year, sum)# right answer!
mLA

#plotting

par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))

    barplot(mB, main="Baltimore", 
            xlab="Number of years")
    barplot(mLA, main="Los Angeles", 
            xlab="Number of years")


