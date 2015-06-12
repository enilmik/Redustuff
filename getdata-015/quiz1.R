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

#quiz3
q1
Idaho <- read.csv("getdata-data-ss06hid.csv")

#ACR 1
#Lot size
#b .N/A (GQ/not a one-family house or mobile home)
#1 .House on less than one acre
#2 .House on one to less than ten acres
#3 .House on ten or more acres
#AGS 1
#Sales of Agriculture Products
# b.N/A (less than 1 acre/GQ/vacant/
#  .2 or more units in structure)
#1 .None
#2 .$ 1 - $ 999
#3 .$ 1000 - $ 2499
#4 .$ 2500 - $ 4999
#5 .$ 5000 - $ 9999
#6 .$10000+

agricultureLogical <- Idaho$ACR == "3" & Idaho$AGS == "6"

which(agricultureLogical)
# [1]  125  238  262  470  555 ...

q2

library(jpeg)
jf <-  readJPEG( "jeff.jpg", native = TRUE)
quantile(jf, probs= c(0.3,0.8))

#      30%       80% 
#-15259150 -10575416 