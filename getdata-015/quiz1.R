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

Q3
EDSTATS <- read.csv ( "getdata-data-EDSTATS_Country.csv")
GDP <- read.csv ( "getdata-data-GDP.csv", skip = 5, nrows = 190, header = FALSE)
mymerdat <- merge(EDSTATS,GDP ,by.x = "CountryCode", by.y ="V1")
mymerdat <- arrange(mymerdat,desc(V2))

q4
flt <- select(mymerdat,1:3,V2)
flt2 <- filter(flt,Income.Group == "High income: OECD" | Income.Group == "High income: nonOECD" )
tapply(flt2$V2,flt2$Income.Group,mean, na.remove = TRUE)
                     High income: nonOECD    High income: OECD           Low income  Lower middle income  Upper middle income 
                  NA             91.91304             32.96667                   NA                   NA                   NA 

q5
library(Hmisc)
flt$cuts <- cut2(flt$V2,g=5)
table(flt$cuts,flt$Income.Group)
               High income: nonOECD High income: OECD Low income Lower middle income Upper middle income
  [  1, 39)  0                    4                18          0                   5                  11

wk4 lect

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))

Fixing character vectors - strsplit()
Good for automatically splitting variable names
Important parameters: x, split

splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]

Fixing character vectors - sapply()
Applies a function to each element in a vector or list
Important parameters: X,FUN
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)


fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)

Fixing character vectors - sub()
Important parameters: pattern, replacement, x
names(reviews)

sub("_","",names(reviews),)


testName <- "this_is_a_test"
sub("_","",testName)

[1] "thisis_a_test"
gsub("_","",testName)
[1] "thisisatest"

Finding values - grep(),grepl()
grep("Alameda",cameraData$intersection)
[1]  4  5 36
table(grepl("Alameda",cameraData$intersection))

FALSE  TRUE 
   77     3 
subsettig
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

More on grep()
grep("Alameda",cameraData$intersection,value=TRUE)
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"
grep("JeffStreet",cameraData$intersection)
integer(0)
length(grep("JeffStreet",cameraData$intersection))
[1] 0

library(stringr)
nchar("Jeffrey Leek")
[1] 12
substr("Jeffrey Leek",1,7)
[1] "Jeffrey"
paste("Jeffrey","Leek")
[1] "Jeffrey Leek"

more useful string functions
paste0("Jeffrey","Leek")
[1] "JeffreyLeek"
str_trim("Jeff      ")
[1] "Jeff"

mportant points about text in data sets
Names of variables should be
All lower case when possible
Descriptive (Diagnosis versus Dx)
Not duplicated
Not have underscores or dots or white spaces
Variables with character values
Should usually be made into factor variables (depends on application)
Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F)

Literals
Simplest pattern consists only of literals. The literal “nuclear” would match to the following lines:

Ooh. I just learned that to keep myself alive after a
nuclear blast! All I have to do is milk some rats
then drink the milk. Aweosme. :}

Laozi says nuclear weapons are mas macho

Chaos in a country that has nuclear weapons -- not good.

my nephew is trying to teach me nuclear physics, or
possibly just trying to show me how smart he is
so I’ll be proud of him [which I am].

lol if you ever say "nuclear" people immediately think
DEATH by radiation LOL

Literals
The literal “Obama” would match to the following lines

Politics r dum. Not 2 long ago Clinton was sayin Obama
was crap n now she sez vote 4 him n unite? WTF?
Screw em both + Mcain. Go Ron Paul!

Clinton conceeds to Obama but will her followers listen??

Are we sure Chelsea didn’t vote for Obama?

thinking ... Michelle Obama is terrific!

jetlag..no sleep...early mornig to starbux..Ms. Obama
was moving

Regular Expressions
Simplest pattern consists only of literals; a match occurs if the sequence of literals occurs anywhere in the text being tested

What if we only want the word “Obama”? or sentences that end in the word “Clinton”, or “clinton” or “clinto”?

Regular Expressions
We need a way to express

whitespace word boundaries
sets of literals
the beginning and end of a line
alternatives (“war” or “peace”) Metacharacters to the rescue!

Metacharacters
Some metacharacters represent the start of a line

^i think
will match the lines

i think we all rule for participating
i think i have been outed
i think this will be quite fun actually
i think i need to go to work
i think i first saw zombo in 1999.

Metacharacters
$ represents the end of a line

morning$
will match the lines

well they had something this morning
then had to catch a tram home in the morning
dog obedience school in the morning
and yes happy birthday i forgot to say it earlier this morning
I walked in the rain this morning
good morning

Character Classes with []
We can list a set of characters we will accept at a given point in the match

[Bb][Uu][Ss][Hh]
will match the lines

The democrats are playing, "Name the worst thing about Bush!"
I smelled the desert creosote bush, brownies, BBQ chicken
BBQ and bushwalking at Molonglo Gorge
Bush TOLD you that North Korea is part of the Axis of Evil
I’m listening to Bush - Hurricane (Album Version)

Character Classes with []
^[Ii] am
will match

i am so angry at my boyfriend i can’t even bear to
look at him

i am boycotting the apple store

I am twittering from iPhone

I am a very vengeful person when you ruin my sweetheart.

I am so over this. I need food. Mmmm bacon...

Character Classes with []
Similarly, you can specify a range of letters [a-z] or [a-zA-Z]; notice that the order doesn’t matter

^[0-9][a-zA-Z]
will match the lines

7th inning stretch
2nd half soon to begin. OSU did just win something
3am - cant sleep - too hot still.. :(
5ft 7 sent from heaven
1st sign of starvagtion

Character Classes with []
When used at the beginning of a character class, the “” is also a metacharacter and indicates matching characters NOT in the indicated class

[^?.]$
will match the lines

i like basketballs
6 and 9
dont worry... we all die anyway!
Not in Baghdad
helicopter under water? hmmm


More Metacharacters
“.” is used to refer to any character. So

9.11
will match the lines

its stupid the post 9-11 rules
if any 1 of us did 9/11 we would have been caught in days.
NetBios: scanning ip 203.169.114.66
Front Door 9:11:46 AM
Sings: 0118999881999119725...3 !

More Metacharacters: |
This does not mean “pipe” in the context of regular expressions; instead it translates to “or”; we can use it to combine two expressions, the subexpressions being called alternatives

flood|fire
will match the lines

is firewire like usb on none macs?
the global flood makes sense within the context of the bible
yeah ive had the fire on tonight
... and the floods, hurricanes, killer heatwaves, rednecks, gun nuts, etc.


We can include any number of alternatives...

flood|earthquake|hurricane|coldfire
will match the lines

Not a whole lot of hurricanes in the Arctic.
We do have earthquakes nearly every day somewhere in our State

More Metacharacters: |
The alternatives can be real expressions and not just literals

^[Gg]ood|[Bb]ad
will match the lines

good to hear some good knews from someone here
Good afternoon fellow american infidels!


More Metacharacters: ( and )
Subexpressions are often contained in parentheses to constrain the alternatives

^([Gg]ood|[Bb]ad)
will match the lines

bad habbit
bad coordination today
good, becuase there is nothing worse than a man in kinky underwear

More Metacharacters: ?
The question mark indicates that the indicated expression is optional

[Gg]eorge( [Ww]\.)? [Bb]ush
will match the lines

i bet i can spell better than you and george bush combined
BBC reported that President George W. Bush claimed God told him to invade I
a bird in the hand is worth two george bushes

One thing to note...
In the following

[Gg]eorge( [Ww]\.)? [Bb]ush
we wanted to match a “.” as a literal period; to do that, we had to “escape” the metacharacter, preceding it with a backslash In general, we have to do this for any metacharacter we want to include in our match
More metacharacters: * and +
The * and + signs are metacharacters used to indicate repetition; * means “any number, including none, of the item” and + means “at least one of the item”

(.*)
will match the lines

anyone wanna chat? (24, m, germany)
hello, 20.m here... ( east area + drives + webcam )
(he means older men)
()

More metacharacters: * and +
The * and + signs are metacharacters used to indicate repetition; * means “any number, including none, of the item” and + means “at least one of the item”

[0-9]+ (.*)[0-9]+
will match the lines

working as MP here 720 MP battallion, 42nd birgade
so say 2 or 3 years at colleage and 4 at uni makes us 23 when and if we fin
it went down on several occasions for like, 3 or 4 *days*
Mmmm its time 4 me 2 go 2 bed

More metacharacters: { and }
{ and } are referred to as interval quantifiers; the let us specify the minimum and maximum number of matches of an expression

[Bb]ush( +[^ ]+ +){1,5} debate
will match the lines

Bush has historically won all major debates he’s done.
in my view, Bush doesn’t need these debates..
bush doesn’t need the debates? maybe you are right
That’s what Bush supporters are doing about the debate.

More metacharacters: and
m,n means at least m but not more than n matches
m means exactly m matches
m, means at least m matches

More metacharacters: ( and ) revisited
In most implementations of regular expressions, the parentheses not only limit the scope of alternatives divided by a “|”, but also can be used to “remember” text matched by the subexpression enclosed
We refer to the matched text with \1, \2, etc.

Dates

Starting simple
d1 = date()
d1
[1] "Sun Jan 12 17:48:33 2014"
class(d1)

Date class
d2 = Sys.Date()
d2
[1] "2014-01-12"
class(d2)
[1] "Date"

Formatting dates
%d = day as number (0-31), %a = abbreviated weekday,%A = unabbreviated weekday, %m = month (00-12), %b = abbreviated month, %B = unabbrevidated month, %y = 2 digit year, %Y = four digit year

format(d2,"%a %b %d")
[1] "Sun Jan 12"

Creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z
[1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"
z[1] - z[2]
Time difference of -1 days
as.numeric(z[1]-z[2])
[1] -1

Converting to Julian
weekdays(d2)
[1] "Sunday"
months(d2)
[1] "January"
julian(d2)
[1] 16082
attr(,"origin")
[1] "1970-01-01"

Lubridate
library(lubridate); ymd("20140108")
[1] "2014-01-08 UTC"
mdy("08/04/2013")
[1] "2013-08-04 UTC"
dmy("03-04-2013")
[1] "2013-04-03 UTC"


Dealing with times
ymd_hms("2011-08-03 10:15:03")
[1] "2011-08-03 10:15:03 UTC"
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
[1] "2011-08-03 10:15:03 NZST"
?Sys.timezone

http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/

quiz4

q3
grep("*United",countryNames), 5
[1] "character"

q4
grep("June",mymerdat$Special.Notes[grepl("Fiscal year",mymerdat$Special.Notes)])

q5
library(lubridate)
> table(year(sampleTimes))

2007 2008 2009 2010 2011 2012 2013 2014 2015 
 251  253  252  252  252  250  252  252  112 
> table(year(sampleTimes),weekdays(sampleTimes))
      
       fredag mandag onsdag tirsdag torsdag
  2007     51     48     51      50      51
  2008     50     48     53      52      50
  2009     49     48     52      52      51
  2010     50     47     52      52      51
  2011     51     46     52      52      51
  2012     51     47     51      50      51
  2013     51     48     51      52      50
  2014     50     48     52      52      50
  2015     23     20     23      23      23

