#question1
data_1 <- tapply(NEI$Emissions, NEI$year, sum) 
  data_1  <- data_1/1000

  png("plot1.png")
  plot(names(data_1), data_1, type="l", 
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (thousand tons)"), 
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year")) 

  dev.off()    
#question2
NEI <- readRDS("summarySCC_PM25.rds")
NEI_B<-NEI[NEI$fips==24510,]
plot2<-aggregate(Emissions ~ year, data = NEI_B, sum)
plot(plot2, type="l")


#question3
  EI<-readRDS("summarySCC_PM25.rds")
  SCC<-readRDS("Source_Classification_Code.rds")
  
  NEI2<-NEI[NEI$fips == 24510,]
  df<-transform(NEI2,
                type = as.factor(type),
                year = as.factor(year)
  )
 
  library(ggplot2)
  z<-aggregate(df$Emissions, by=list(df$year, df$type), sum)
  colnames(z)<-c("Year", "Type", "Emissions")
  png(file = "plot3.png")
  ggplot(data = z, aes(x=Year, y = Emissions)) +
    geom_bar(stat="identity") + 
    facet_grid(. ~ Type) +
    labs(title = "Fine Particulate Matter Emissions in Baltimore City, MD
         by Source Type (1999 - 2008)")
  dev.off()
###################
###################

NEI <- readRDS("summarySCC_PM25.rds")

library(reshape)
library(ggplot2)

sources <- aggregate(NEI$Emissions[NEI$fips==24510] ~ NEI$type[NEI$fips==24510]+NEI$year[NEI$fips==24510] , NEI, sum)

colnames(sources) <- c("type","year","emissions")
ggplot(sources, aes(x=factor(year),y=emissions,group=type)) + geom_line(aes(colour=type)) +
  ggtitle("Emissions in Baltimore City") + labs(x = "Years", y="Emissions")
ggsave(file="plot3.png")
#########
#########
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_B<-NEI[NEI$fips==24510,]
plot3<-aggregate(Emissions ~ year + type, data = NEI_B, sum)
qplot(year, Emissions, data = plot3, geom = "line", color = type)

#######################################################################
#######################################################################
#question4
  data_4 <-aggregate(NEI$Emissions[NEI$SCC %in% code$SCC[grep("Coal",code$Short.Name)]] ~ NEI$year[NEI$SCC %in% code$SCC[grep("Coal",code$Short.Name)]] , NEI, sum)
  colnames(data_4)<-c("year","emissions")
  ggplot(data_4, aes(x=factor(year),y=emissions)) + geom_bar(stat = "identity") +
  ggtitle("Emissions by Coal Combustion") + labs(x = "Years", y="Emissions")
  ggsave(file="plot4.png")

#question5
data_5 <-aggregate(NEI$Emissions[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & NEI$fips==24510] ~ NEI$year[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & NEI$fips==24510] , NEI, sum)
colnames(data_5)<-c("year","emissions")
ggplot(data_5, aes(x=factor(year),y=emissions)) + geom_bar(stat = "identity") +
  ggtitle("Emissions by vehicle sources in Baltimore City") + labs(x = "Years", y="Emissions")
ggsave(file="plot5.png")

#question6
  NEI<-readRDS("summarySCC_PM25.rds")
  
  ##subset NEI by "ON-ROAD" to account for motor vehicle emission sources
  NEI2<-NEI[NEI$type == "ON-ROAD",]
  ##subset for data from Baltimore City
  NEIbalt<-NEI2[NEI2$fips == "24510",]
  x<-tapply(NEIbalt$Emissions, NEIbalt$year, sum)
  ##subset for data from Los Angeles County
  NEILA<-NEI2[NEI2$fips == "06037",]
  z<-tapply(NEILA$Emissions, NEILA$year, sum)
  ##find value of change 1999-2008 for Baltimore
  bach<-x[4]-x[1]
  ##find value of change 1999-2008 for LA County
  lach<-z[4]-z[1]
  compare<-array(data = c(bach, lach))
  ##create two graphs
  png("plot6.png")
  par(mfrow = c(1,2))
  mtext("Motor Vehicle Fine Particulate Emmissions in Baltimore
        and Los Angeles Counties, 1999 to 2008", outer = TRUE)
  barplot(x,
          col = "blue",
          xlab = "Year", 
          ylab = "Fine particulate emmissions in tons",
          main = "Baltimore, MD"
  )
  barplot(z,
          col = "purple",
          xlab = "Year", 
          ylab = "Fine particulate emmissions in tons",
          main = "Los Angeles, CA"
  )
  
  
  dev.off()

