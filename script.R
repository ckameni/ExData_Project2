
# load the data
Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile="E:/data/ExData_Project2/Assignment.zip")
unzip("./Assignment.zip")

dir()

#read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

rm(list=ls())


#I'm playing around with aggregate(emissions, list(year), sum) 
#and using barplot() to plot the results.  
#'
#So, tapply, aggregate could help..

#tapply(emissions, year, sum) # you may have to edit the argument as I have just put for example. So, this should return you with the sum of emissions group by year.

#aggregate(emissions, year, sum)
#aggregate(emissions, by=list(year, type), sum) # here you can also give a list of variables you may wish to group by… say emissions group by year and type…#

#Another one could be...#
#ddply(emissions, ~year, function) # this will need the plyr package to be installed.'

#In conjunction, you can use facet layer in the ggplot for plotting…. I like to use facet..

#Hope this helps..




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

xy <- aggregate(Emissions~year + type ,NEI, sum) # my favourite way to do it
xy
qplot(year,Emissions,data =xy, facets= .~type,geom=c("point","smooth"),method = "lm")


g<-ggplot(xy,aes(year,Emissions))
g + geom_point() +
  geom_smooth(method="lm") + facet_grid(.~type)

######P2_q4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# column "Short.Namer" has coal 
coal<-SCC[grep(".*[cC]oal.*",SCC$Short.Name),]

# column "EI.Sector" has coal too
coal2 <-SCC[grep(".*[cC]oal.*",SCC$EI.Sector),] 



diff<-setdiff(coal2,coal)

dim(diff)
#merge the data
mergedData <- merge(coal,NEI,by.x = "SCC", by.y = "SCC")

dim(coal)
dim(coal2)

par(mar = rep(2, 4))
mD<-tapply(mergedData $Emissions, mergedData $year, sum)# right answer!
mD
barplot(mD, main="Emmisssions Distribution", 
        xlab="Number of years")


############################## little Explanation#############
#find the rows where "coal" appears! 
s<-grep(".*[cC]oal.*",SCC$Short.Name) # in column "Short.names"
c<-grep(".*[cC]oal.*",SCC$EI.Sector) # in column "Ei.Sector"
# which elements ofc are not in s?
c
s
z<-setdiff(c,s)
dim(z)
z
#
as<- z + s # unique(s,c)

#what means coal related? what is coal?
#####################################################################

head(SCC)

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

