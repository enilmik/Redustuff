Idaho2006 <- read.csv("~/Cousera/Getting Data/getdata-data-ss06hid.csv")
  View(getdata.data.ss06hid)

# VAL - property value, cat 24 => 53

table(Idaho2006$VAL)
# or
filter(Idaho2006,VAL == 24) # returns 53 rows

Q3

 library(xlsx)

 colIndex <- 7:15
 rowIndex <- 18:23

dat <- read.xlsx("NGAP2.xlsx",sheetIndex =1,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
36534720

Q4

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
direct http read of xml , gives error.

library(tools)
target_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
target_localfile = "restaurants.xml"
download.file(target_url, target_localfile, method = "curl")
md5sum(target_localfile)
getwd()

fileurl = "restaurants.xml"
doc <- xmlTreeParse(fileurl,useInternal = TRUE)
rootNode <- xmlRoot(doc)
table(xpathSApply(doc,"//zipcode",xmlValue))