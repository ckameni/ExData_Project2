
# load the data
Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile="E:/data/ExData_Project2/Assignment.zip")
unzip("./Assignment.zip")

dir()

#read the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


str(NEI)
head(NEI);
tail(NEI)
head(SCC);
tail(SCC)
names(SCC)
names(NEI)



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

