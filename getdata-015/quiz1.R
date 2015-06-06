Idaho2006 <- read.csv("~/Cousera/Getting Data/getdata-data-ss06hid.csv")
  View(getdata.data.ss06hid)

# VAL - property value, cat 24 => 53

table(Idaho2006$VAL)
# or
filter(Idaho2006,VAL == 24) # returns 53 rows 

