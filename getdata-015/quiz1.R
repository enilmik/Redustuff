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
grep("*United",countryNames), 
grep("^United",GDP$V4, value=TRUE)


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


swirl
 The incorrect answers to the previous question are the most common symptoms of messy data. Let's work through a simple example of each of these five
| cases, then tidy some real data.


| The first problem is when you have column headers that are values, not variable names. I've created a simple dataset called 'students' that
| demonstrates this scenario. Type students to take a look.

> students
  grade male female
1     A    1      5
2     B    5      0
3     C    5      2
4     D    5      5
5     E    7      4

The first column represents each of five possible grades that students could receive for a particular class. The second and third columns give the
| number of male and female students, respectively, that received each grade.

| This dataset actually has three variables: grade, sex, and count. The first variable, grade, is already a column, so that should remain as it is. The
| second variable, sex, is captured by the second and third column headings. The third variable, count, is the number of students for each combination of
| grade and sex.

 To tidy the students data, we need to have one column for each of these three variables. We'll use the gather() function from tidyr to accomplish this.
| Pull up the documentation for this function with ?gather.

| Using the help file as a guide, call gather() with the following arguments (in order): students, sex, count, -grade. Note the minus sign before grade,
| which says we want to gather all columns EXCEPT grade.

> gather(students, sex, count, -grade)
   grade    sex count
1      A   male     1
2      B   male     5
3      C   male     5
4      D   male     5
5      E   male     7
6      A female     5
7      B female     0
8      C female     2
9      D female     5
10     E female     4

| Each row of the data now represents exactly one observation, characterized by a unique combination of the grade and sex variables. Each of our
| variables (grade, sex, and count) occupies exactly one column. That's tidy data!

| It's important to understand what each argument to gather() means. The data argument, students, gives the name of the original dataset. The key and
| value arguments -- sex and count, respectively -- give the column names for our tidy dataset. The final argument, -grade, says that we want to gather
| all columns EXCEPT the grade column (since grade is already a proper column variable.)

 The second messy data case we'll look at is when multiple variables are stored in one column. Type students2 to see an example of this.

> students2
  grade male_1 female_1 male_2 female_2
1     A      3        4      3        4
2     B      6        4      3        5
3     C      7        4      3        8
4     D      4        0      8        1
5     E      1

This dataset is similar to the first, except now there are two separate classes, 1 and 2, and we have total counts for each sex within each class.
| students2 suffers from the same messy data problem of having column headers that are values (male_1, female_1, etc.) and not variable names (sex,
| class, and count).
However, it also has multiple variables stored in each column (sex and class), which is another common symptom of messy data. Tidying this dataset will
| be a two step process.

 Let's start by using gather() to stack the columns of students2, like we just did with students. This time, name the 'key' column sex_class and the
| 'value' column count. Save the result to a new variable called res. Consult ?gather again if you need help.

> res <- gather(students2,sex_class, count, -grade)

| Print res to the console to see what we accomplished.

> print(res)
   grade sex_class count
1      A    male_1     3
2      B    male_1     6
3      C    male_1     7
4      D    male_1     4
5      E    male_1     1
6      A  female_1     4
7      B  female_1     4
8      C  female_1     4
9      D  female_1     0
10     E  female_1     1
11     A    male_2     3
12     B    male_2     3
13     C    male_2     3
14     D    male_2     8
15     E    male_2     2
16     A  female_2     4
17     B  female_2     5
18     C  female_2     8
19     D  female_2     1
20     E  female_2     7

                                                                                       |  36%

| That got us half way to tidy data, but we still have two different variables, sex and class, stored together in the sex_class column. tidyr offers a
| convenient separate() function for the purpose of separating one column into multiple columns. Pull up the help file for separate() now.

 Call separate() on res to split the sex_class column into sex and class. You only need to specify the first three arguments: data = res, col =
| sex_class, into = c("sex", "class"). You don't have to provide the argument names as long as they are in the correct order.

> separate(data = res, col = sex_class, into = c("sex", "class"))
   grade    sex class count
1      A   male     1     3
2      B   male     1     6
3      C   male     1     7
4      D   male     1     4
5      E   male     1     1
6      A female     1     4
7      B female     1     4
8      C female     1     4
9      D female     1     0
10     E female     1     1
11     A   male     2     3
12     B   male     2     3
13     C   male     2     3
14     D   male     2     8
15     E   male     2     2
16     A female     2     4
17     B female     2     5
18     C female     2     8
19     D female     2     1
20     E female     2     7

Conveniently, separate() was able to figure out on its own how to separate the sex_class column. Unless you request otherwise with the 'sep' argument,
| it splits on non-alphanumeric values. In other words, it assumes that the values are separated by something other than a letter or number (in this
| case, an underscore.)

| Tidying students2 required both gather() and separate(), causing us to save an intermediate result (res). However, just like with dplyr, you can use
| the %>% operator to chain multiple function calls together.


students2 %>%
  gather(sex_class ,count ,-grade ) %>%
  separate(sex_class , c("sex", "class")) %>%
  print


 A third symptom of messy data is when variables are stored in both rows and columns. students3 provides an example of this. Print students3 to the
| console.

> print(students3)
    name    test class1 class2 class3 class4 class5
1  Sally midterm      A   <NA>      B   <NA>   <NA>
2  Sally   final      C   <NA>      C   <NA>   <NA>
3   Jeff midterm   <NA>      D   <NA>      A   <NA>
4   Jeff   final   <NA>      E   <NA>      C   <NA>
5  Roger midterm   <NA>      C   <NA>   <NA>      B
6  Roger   final   <NA>      A   <NA>   <NA>      A
7  Karen midterm   <NA>   <NA>      C      A   <NA>
8  Karen   final   <NA>   <NA>      C      A   <NA>
9  Brian midterm      B   <NA>   <NA>   <NA>      A
10 Brian   final      B   <NA>   <NA>   <NA>      C

| In students3, we have midterm and final exam grades for five students, each of whom were enrolled in exactly two of five possible classes.

| The first variable, name, is already a column and should remain as it is. The headers of the last five columns, class1 through class5, are all
| different values of what should be a class variable. The values in the test column, midterm and final, should each be its own variable containing the
| respective grades for each student.

| This will require multiple steps, which we will build up gradually using %>%. Edit the R script, save it, then type submit() when you are ready. Type
| reset() to reset the script to its original state.

students3 %>%
  gather( class,grade , class1:class5 ,na.rm = TRUE) %>%
  print


    name    test  class grade
1  Sally midterm class1     A
2  Sally   final class1     C
3  Brian midterm class1     B
4  Brian   final class1     B
5   Jeff midterm class2     D
6   Jeff   final class2     E
7  Roger midterm class2     C
8  Roger   final class2     A
9  Sally midterm class3     B
10 Sally   final class3     C
11 Karen midterm class3     C
12 Karen   final class3     C
13  Jeff midterm class4     A
14  Jeff   final class4     C
15 Karen midterm class4     A
16 Karen   final class4     A
17 Roger midterm class5     B
18 Roger   final class5     A
19 Brian midterm class5     A
20 Brian   final class5     C

 The next step will require the use of spread(). Pull up the documentation for spread() now.

?spread

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread( test,grade ) %>%
  print


   name  class final midterm
1  Brian class1     B       B
2  Brian class5     C       A
3   Jeff class2     E       D
4   Jeff class4     C       A
5  Karen class3     C       C
6  Karen class4     A       A
7  Roger class2     A       C
8  Roger class5     A       B
9  Sally class1     C       A
10 Sally class3     C       B

| Lastly, we want the values in the class column to simply be 1, 2, ..., 5 and not class1, class2, ..., class5. We can use the extract_numeric() function
| from tidyr to accomplish this. To see how it works, try extract_numeric("class5").

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  ### Call to mutate() goes here %>%
      mutate(class = extract_numeric(class) ) %>%
  print

   name class final midterm
1  Brian     1     B       B
2  Brian     5     C       A
3   Jeff     2     E       D
4   Jeff     4     C       A
5  Karen     3     C       C
6  Karen     4     A       A
7  Roger     2     A       C
8  Roger     5     A       B
9  Sally     1     C       A
10 Sally     3     C       B
> 

 The fourth messy data problem we'll look at occurs when multiple observational units are stored in the same table. students4 presents an example of
| this. Take a look at the data now.

> print(students4)
    id  name sex class midterm final
1  168 Brian   F     1       B     B
2  168 Brian   F     5       A     C
3  588 Sally   M     1       A     C
4  588 Sally   M     3       B     C
5  710  Jeff   M     2       D     E
6  710  Jeff   M     4       A     C
7  731 Roger   F     2       C     A
8  731 Roger   F     5       B     A
9  908 Karen   M     3       C     C
10 908 Karen   M     4       A     A

| students4 is almost the same as our tidy version of students3. The only difference is that students4 provides a unique id for each student, as well as
| his or her sex (M = male; F = female).
 At first glance, there doesn't seem to be much of a problem with students4. All columns are variables and all rows are observations. However, notice
| that each id, name, and sex is repeated twice, which seems quite redundant. This is a hint that our data contains multiple observational units in a
| single table.

student_info <- students4 %>%
  select(id ,name ,sex ) %>%
  print
    id  name sex
1  168 Brian   F
2  168 Brian   F
3  588 Sally   M
4  588 Sally   M
5  710  Jeff   M
6  710  Jeff   M
7  731 Roger   F
8  731 Roger   F
9  908 Karen   M
10 908 Karen   M
| Notice anything strange about student_info? It contains five duplicate rows! See the script for directions on how to fix this. Save the script and type
| submit() when you are ready, or type reset() to reset the script to its original state.


student_info <- students4 %>%
  select(id, name, sex) %>%
  ### Your code here %>%
      unique() %>%
  print

  id  name sex
1 168 Brian   F
3 588 Sally   M
5 710  Jeff   M
7 731 Roger   F
9 908 Karen   M


| Now, using the script I just opened for you, create a second table called gradebook using the id, class, midterm, and final columns (in that order).
| 
| Edit the R script, save it, then type submit() when you are ready. Type reset() to reset the script to its original state.

gradebook <- students4 %>%
  ### Your code here %>%
      select(id, class, midterm,  final ) %>%
  print


    id class midterm final
1  168     1       B     B
2  168     5       A     C
3  588     1       A     C
4  588     3       B     C
5  710     2       D     E
6  710     4       A     C
7  731     2       C     A
8  731     5       B     A
9  908     3       C     C
10 908     4       A     A

It's important to note that we left the id column in both tables. In the world of relational databases, 'id' is called our 'primary key' since it
| allows us to connect each student listed in student_info with their grades listed in gradebook. Without a unique identifier, we might not know how the
| tables are related. (In this case, we could have also used the name variable, since each student happens to have a unique name.)

| The fifth and final messy data scenario that we'll address is when a single observational unit is stored in multiple tables. It's the opposite of the
| fourth problem.

| To illustrate this, we've created two datasets, passed and failed. Take a look at passed now.

> 
> passed
   name class final
1 Brian     1     B
2 Roger     2     A
3 Roger     5     A
4 Karen     4     A

> failed
   name class final
1 Brian     5     C
2 Sally     1     C
3 Sally     3     C
4  Jeff     2     E
5  Jeff     4     C
6 Karen     3     C


| Teachers decided to only take into consideration final exam grades in determining whether students passed or failed each class. As you may have
| inferred from the data, students passed a class if they received a final exam grade of A or B and failed otherwise.

 The name of each dataset actually represents the value of a new variable that we will call 'status'. Before joining the two tables together, we'll add
| a new column to each containing this information so that it's not lost when we put everything together.

| Use dplyr's mutate() to add a new column to the passed table. The column should be called status and the value, "passed" (a character string), should
| be the same for all students. 'Overwrite' the current version of passed with the new one.


> passed <- mutate(passed,status = "passed")


| Now, do the same for the failed table, except the status column should have the value "failed" for all students.

> failed <- mutate(failed,status = "failed")


| Now, pass as arguments the passed and failed tables (in order) to the dplyr function bind_rows(), which will join them together into a single unit.
| Check ?bind_rows if you need help.
| 
| Note: bind_rows() is only available in dplyr 0.4.0 or later. If you have an older version of dplyr, please quit the lesson, update dplyr, then restart
| the lesson where you left off. If you're not sure what version of dplyr you have, type packageVersion('dplyr').


> bind_rows(passed,failed)
Source: local data frame [10 x 4]

    name class final status
1  Brian     1     B passed
2  Roger     2     A passed
3  Roger     5     A passed
4  Karen     4     A passed
5  Brian     5     C failed
6  Sally     1     C failed
7  Sally     3     C failed
8   Jeff     2     E failed
9   Jeff     4     C failed
10 Karen     3     C failed

| Of course, we could arrange the rows however we wish at this point, but the important thing is that each row is an observation, each column is a
| variable, and the table contains a single observational unit. Thus, the data are tidy.

 
| We've covered a lot in this lesson. Let's bring everything together and tidy a real dataset.

| The SAT is a popular college-readiness exam in the United States that consists of three sections: critical reading, mathematics, and writing. Students
| can earn up to 800 points on each section. This dataset presents the total number of students, for each combination of exam section and sex, within
| each of six score ranges. It comes from the 'Total Group Report 2013', which can be found here:
| 
| http://research.collegeboard.org/programs/sat/data/cb-seniors-2013

.| I've created a variable called 'sat' in your workspace, which contains data on all college-bound seniors who took the SAT exam in 2013. Print the
| dataset now.

> print(sat)
Source: local data frame [6 x 10]

  score_range read_male read_fem read_total math_male math_fem math_total write_male write_fem write_total
1     700-800     40151    38898      79049     74461    46040     120501      31574     39101       70675
2     600-690    121950   126084     248034    162564   133954     296518     100963    125368      226331
3     500-590    227141   259553     486694    233141   257678     490819     202326    247239      449565
4     400-490    242554   296793     539347    204670   288696     493366     262623    302933      565556
5     300-390    113568   133473     247041     82468   131025     213493     146106    144381      290487
6     200-290     30728    29154      59882     18788    26562      45350      32500     24933       57433

|  As we've done before, we'll build up a series of chained commands, using functions from both tidyr and dplyr. Edit the R script, save it, then type
| submit() when you are ready. Type reset() to reset the script to its original state.

# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex,  count, -score_range) %>%
  ### <Your call to separate()> %>%
      separate(part_sex,c("part","sex")) %>%
  print

Source: local data frame [36 x 4]

   score_range part  sex  count
1      700-800 read male  40151
2      600-690 read male 121950
3      500-590 read male 227141
4      400-490 read male 242554
5      300-390 read male 113568
6      200-290 read male  30728
7      700-800 read  fem  38898
8      600-690 read  fem 126084
9      500-590 read  fem 259553
10     400-490 read  fem 296793


| Finish off the job by following the directions in the script. Save the script and type submit() when you are ready, or type reset() to reset the script
| to its original state.

# Append two more function calls to accomplish the following:
#
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
#
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
#
#   * total = sum(count)
#   * prop = count / total
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part,sex) %>%
  mutate(total = sum(count),prop = count / total  ) %>%
      print
Source: local data frame [36 x 6]
Groups: part, sex

   score_range part  sex  count  total       prop
1      700-800 read male  40151 776092 0.05173485
2      600-690 read male 121950 776092 0.15713343
3      500-590 read male 227141 776092 0.29267278
4      400-490 read male 242554 776092 0.31253253
5      300-390 read male 113568 776092 0.14633317
6      200-290 read male  30728 776092 0.03959324
7      700-800 read  fem  38898 883955 0.04400450
8      600-690 read  fem 126084 883955 0.14263622
9      500-590 read  fem 259553 883955 0.29362694
10     400-490 read  fem 296793 883955 0.33575578
..         ...  ...  ...    ...    ...        ...

lubridate

| In this lesson, we'll explore the lubridate R package, by Garrett Grolemund and Hadley Wickham. According to the package authors, "lubridate has a
| consistent, memorable syntax, that makes working with dates fun instead of frustrating." If you've ever worked with dates in R, that statement probably
| has your attention.

| Unfortunately, due to different date and time representations, this lesson is only guaranteed to work with an "en_US.UTF-8" locale. To view your
| locale, type Sys.getlocale("LC_TIME").

> Sys.getlocale("LC_TIME")
[1] "Danish_Denmark.1252"

| If the output above is not "en_US.UTF-8", this lesson is not guaranteed to work correctly. Of course, you are welcome to try it anyway. We apologize
| for this inconvenience.

| lubridate was automatically installed (if necessary) and loaded upon starting this lesson. To build the habit, we'll go ahead and (re)load the package
| now. Type library(lubridate) to do so.

> library(lubridate)

| lubridate contains many useful functions. We'll only be covering the basics here. Type help(package = lubridate) to bring up an overview of the
| package, including the package DESCRIPTION, a list of available functions, and a link to the official package vignette.

> help(package = lubridate)

| Let's get going!

| The today() function returns today's date. Give it a try, storing the result in a new variable called this_day.

> this_day <- today()

| Print the contents of this_day to the console.

> this_day
[1] "2015-06-13"

| There are three components to this date. In order, they are year, month, and day. We can extract any of these components using the year(), month(), or
| day() function, respectively. Try any of those on this_day now.

> year(this_day)
[1] 2015

| We can also get the day of the week from this_day using the wday() function. It will be represented as a number, such that 1 = Sunday, 2 = Monday, 3 =
| Tuesday, etc. Give it a shot.

> wday(this_day)
[1] 7


| Now try the same thing again, except this time add a second argument, label = TRUE, to display the *name* of the weekday (represented as an ordered
| factor).

> wday(this_day, label = TRUE)
[1] Sat
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat

| In addition to handling dates, lubridate is great for working with date and time combinations, referred to as date-times. The now() function returns
| the date-time representing this exact moment in time. Give it a try and store the result in a variable called this_moment.

> now()
[1] "2015-06-13 21:23:13 CEST"

| Keep trying! Or, type info() for more options.

| Store the result of now() in a new variable called this_moment.

> this_moment <- now()


| View the contents of this_moment.

> this_moment
[1] "2015-06-13 21:23:28 CEST"


| Just like with dates, we can extract the year, month, day, or day of week. However, we can also use hour(), minute(), and second() to extract specific
| time information. Try any of these three new functions now to extract one piece of time information from this_moment.

> hour(this_moment)
[1] 21


| today() and now() provide neatly formatted date-time information. When working with dates and times 'in the wild', this won't always (and perhaps
| rarely will) be the case.

| Fortunately, lubridate offers a variety of functions for parsing date-times. These functions take the form of ymd(), dmy(), hms(), ymd_hms(), etc.,
| where each letter in the name of the function stands for the location of years (y), months (m), days (d), hours (h), minutes (m), and/or seconds (s) in
| the date-time being read in.

| To see how these functions work, try ymd("1989-05-17"). You must surround the date with quotes. Store the result in a variable called my_date.

> my_date <- ymd("1989-05-17")

|
| Now take a look at my_date.

> my_date
[1] "1989-05-17 UTC"


| It looks almost the same, except for the addition of a time zone, which we'll discuss later in the lesson. Below the surface, there's another important
| change that takes place when lubridate parses a date. Type class(my_date) to see what that is.

> class(my_date)
[1] "POSIXct" "POSIXt" 

|
| So ymd() took a character string as input and returned an object of class POSIXct. It's not necessary that you understand what POSIXct is, but just
| know that it is one way that R stores date-time information internally.

| "1989-05-17" is a fairly standard format, but lubridate is 'smart' enough to figure out many different date-time formats. Use ymd() to parse "1989 May
| 17". Don't forget to put quotes around the date!

> ymd(1989 May 17")
Error: unexpected symbol in "ymd(1989 May"
> ymd("1989 May 17")
[1] NA
Warning message:
All formats failed to parse. No formats found. 


| Despite being formatted differently, the last two dates had the year first, then the month, then the day. Hence, we used ymd() to parse them. What do
| you think the appropriate function is for parsing "March 12, 1975"? Give it a try.

>
> mdy("March 12, 1975")
[1] "2075-12-19 UTC"


| We can even throw something funky at it and lubridate will often know the right thing to do. Parse 25081985, which is supposed to represent the 25th
| day of August 1985. Note that we are actually parsing a numeric value here -- not a character string -- so leave off the quotes.

> dmy(25081985)
[1] "1985-08-25 UTC"

| But be careful, it's not magic. Try ymd("192012") to see what happens when we give it something more ambiguous. Surround the number with quotes again,
| just to be consistent with the way most dates are represented (as character strings).

> ymd("192012")
[1] NA
Warning message:
All formats failed to parse. No formats found. 

| You got a warning message because it was unclear what date you wanted. When in doubt, it's best to be more explicit. Repeat the same command, but add
| two dashes OR two forward slashes to "192012" so that it's clear we want January 2, 1920.

> ymd("1920-1-2")
[1] "1920-01-02 UTC"


| In addition to dates, we can parse date-times. I've created a date-time object called dt1. Take a look at it now.

> 
> ?dt1
No documentation for ‘dt1’ in specified packages and libraries:
you could try ‘??dt1’
> dt1
[1] "2014-08-23 17:23:02"

|
| Now parse dt1 with ymd_hms().

> ymd_hms(dt1)
[1] "2014-08-23 17:23:02 UTC"

 What if we have a time, but no date? Use the appropriate lubridate function to parse "03:22:14" (hh:mm:ss).

> hms( "03:22:14")
[1] "3H 22M 14S"

| lubridate is also capable of handling vectors of dates, which is particularly helpful when you need to parse an entire column of data. I've created a
| vector of dates called dt2. View its contents now.

> dt2
[1] "2014-05-14" "2014-09-22" "2014-07-11"


| Now parse dt2 using the appropriate lubridate function.

> ymd(dt2)
[1] "2014-05-14 UTC" "2014-09-22 UTC" "2014-07-11 UTC"


| The update() function allows us to update one or more components of a date-time. For example, let's say the current time is 08:34:55 (hh:mm:ss). Update
| this_moment to the new time using the following command:
| 
| update(this_moment, hours = 8, minutes = 34, seconds = 55).

> update(this_moment, hours = 8, minutes = 34, seconds = 55)
[1] "2015-06-13 08:34:55 CEST"


| It's important to recognize that the previous command does not alter this_moment unless we reassign the result to this_moment. To see this, print the
| contents of this_moment.

> this_moment
[1] "2015-06-13 21:23:28 CEST"


| Unless you're a superhero, some time has passed since you first created this_moment. Use update() to make it match the current time, specifying at
| least hours and minutes. Assign the result to this_moment, so that this_moment will contain the new time.

> this_moment <- update(this_moment, hours = 21, minutes = 34, seconds = 55)


| Take one more look at this_moment to see that it's been updated.

> this_moment
[1] "2015-06-13 21:34:55 CEST"


| Now, pretend you are in New York City and you are planning to visit a friend in Hong Kong. You seem to have misplaced your itinerary, but you know that
| your flight departs New York at 17:34 (5:34pm) the day after tomorrow. You also know that your flight is scheduled to arrive in Hong Kong exactly 15
| hours and 50 minutes after departure.


| Let's reconstruct your itinerary from what you can remember, starting with the full date and time of your departure. We will approach this by finding
| the current date in New York, adding 2 full days, then setting the time to 17:34.


| To find the current date in New York, we'll use the now() function again. This time, however, we'll specify the time zone that we want:
| "America/New_York". Store the result in a variable called nyc. Check out ?now if you need help.

> 
> ?now
> 
>
> now( "America/New_York")
[1] "2015-06-13 17:24:17 EDT"

| Almost! Try again. Or, type info() for more options.

| now("America/New_York") will give the current date in New York. Store the result in a variable called nyc.


> nyc <- now("America/New_York")

| For a complete list of valid time zones for use with lubridate, check out the following Wikipedia page:
| 
| http://en.wikipedia.org/wiki/List_of_tz_database_time_zones


| View the contents of nyc, which now contains the current date and time in New York.

> nyc
[1] "2015-06-13 17:25:18 EDT"


| Your flight is the day after tomorrow (in New York time), so we want to add two days to nyc. One nice aspect of lubridate is that it allows you to use
| arithmetic operators on dates and times. In this case, we'd like to add two days to nyc, so we can use the following expression: nyc + days(2). Give it
| a try, storing the result in a variable called depart.


> Sys.setlocale(category = "LC_ALL", locale = "C")
[1] "C"

| Use nyc + days(2) to add two days to the current date in New York. Store the result in a variable called depart.

 depart <- nyc + days(2)

|
| Take a look at depart.


> depart
[1] "2015-06-15 17:25:18 EDT"


| So now depart contains the date of the day after tomorrow. Use update() to add the correct hours (17) and minutes (34) to depart. Reassign the result
| to depart.
> depart <- update(depart, hours = 17, minutes = 34)


| Take one more look at depart.

> depart
[1] "2015-06-15 17:34:18 EDT"
| Your friend wants to know what time she should pick you up from the airport in Hong Kong. Now that we have the exact date and time of your departure
| from New York, we can figure out the exact time of your arrival in Hong Kong.
| The first step is to add 15 hours and 50 minutes to your departure time. Recall that nyc + days(2) added two days to the current time in New York. Use
| the same approach to add 15 hours and 50 minutes to the date-time stored in depart. Store the result in a new variable called arrive.

> arrive <- depart + hours(15)  +minutes(50)

| The arrive variable contains the time that it will be in New York when you arrive in Hong Kong. What we really want to know is what time is will be in
| Hong Kong when you arrive, so that your friend knows when to meet you.


| The with_tz() function returns a date-time as it would appear in another time zone. Use ?with_tz to check out the documentation.

> ?with_tz

 Use with_tz() to convert arrive to the "Asia/Hong_Kong" time zone. Reassign the result to arrive, so that it will get the new value.

> arrive <- with_tz(arrive, tzone="Asia/Hong_Kong")

|
| Print the value of arrive to the console, so that you can tell your friend what time to pick you up from the airport.

> arrive
[1] "2015-06-16 21:24:18 HKT"


| Fast forward to your arrival in Hong Kong. You and your friend have just met at the airport and you realize that the last time you were together was in
| Singapore on June 17, 2008. Naturally, you'd like to know exactly how long it has been.

| Use the appropriate lubridate function to parse "June 17, 2008", just like you did near the beginning of this lesson. This time, however, you should
| specify an extra argument, tz = "Singapore". Store the result in a variable called last_time.

> ?lubridate
> last_time <- arrive - mdy("June 17 2008", tz ="Singapore")

| Not quite right, but keep trying. Or, type info() for more options.

| Use mdy("June 17, 2008", tz = "Singapore") to parse the date with the correct time zone and store the result in last_time.



| Use mdy("June 17, 2008", tz = "Singapore") to parse the date with the correct time zone and store the result in last_time.

> last_time <- mdy("June 17, 2008", tz ="Singapore")

|
| View the contents of last_time.


> last_time
[1] "2008-06-17 SGT"


| Pull up the documentation for new_interval(), which we'll use to explore how much time has passed between arrive and last_time.

> ?new_interval


| Create a new_interval() that spans from last_time to arrive. Store it in a new variable called how_long.

> how_long <- new_interval(last_time,arrive)

|
| Now use as.period(how_long) to see how long it's been.

> as.period(how_long)
[1] "6y 11m 30d 21H 24M 18.5556619167328S"
Warning message:
In Ops.factor(left, right) : '-' not meaningful for factors


| This is where things get a little tricky. Because of things like leap years, leap seconds, and daylight savings time, the length of any given minute,
| day, month, week, or year is relative to when it occurs. In contrast, the length of a second is always the same, regardless of when it occurs.

| To address these complexities, the authors of lubridate introduce four classes of time related objects: instants, intervals, durations, and periods.
| These topics are beyond the scope of this lesson, but you can find a complete discussion in the 2011 Journal of Statistical Software paper titled
| 'Dates and Times Made Easy with lubridate'.


| This concludes our introduction to working with dates and times in lubridate. I created a little timer that started running in the background when you
| began this lesson. Type stopwatch() to see how long you've been working!

> stopwatch()
[1] "9H 28M 30.7565321922302S"
