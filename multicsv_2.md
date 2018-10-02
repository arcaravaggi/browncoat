Read multiple csv files and subset
================
Anthony Caravaggi
9 January 2018

To use this script as-is, download the scripts from the multicsv\_2\_files directory. The script assumes that the csv files are located in the working directory. If this is not the case, edit the code accordingly (e.g. dir(path = '....', pattern...)).

First, read the csv names.

``` r
csv_files <- dir(pattern='*.csv$', recursive = T)
csv_files
```

    ## [1] "t1.csv" "t2.csv" "t3.csv"

Then, create an empty list to store the dataframs and use a for loop to read the csv files into the list. Some people will no doubt shake their heads at the use of a for loop, but it does the job nicely. The `skip` command in read.csv tells the function to drop all rows up to a given point. Our data have a lot of noise in the first dozen or so rows, so we'll omit them.

``` r
my.data <- list()

for (i in 1:length(csv_files)){
  my.data[[i]] <- read.csv(csv_files[[i]], header = T, as.is = T)
}

head(my.data[[1]])
```

    ##        X      Y      Site                  Species No Day Month
    ## 1 236708 367526 Aghadulla            Martes martes  1   6     5
    ## 2 236708 367526 Aghadulla            martes martes  1   5     5
    ## 3 236708 367526 Aghadulla            martes martes  1   4     5
    ## 4 236708 367526 Aghadulla                     sika  1   7     5
    ## 5 236708 367526 Aghadulla            Vulpes vulpes  1   4     5
    ## 6 236708 367526 Aghadulla lepus timidus hibernicus  1   1     5
    ##   Activity.time Time.period Year
    ## 1         03:10 03:00-03:59 2015
    ## 2         04:03 04:00-04:59 2015
    ## 3         04:12 04:00-04:59 2015
    ## 4         05:58 05:00-05:59 2015
    ## 5         06:40 06:00-06:59 2015
    ## 6         16:58 16:00-16:59 2015

Before we extract specific columns to a new list, we want to make sure that all columns have the same names. That's easy to do, particularly as I'm using files with the same number and type of columns. That was lucky.

``` r
c.n <- c("x", "y", "location", "species", "count", "day", "month", "time", "time.period", "year")
my.data <- lapply(my.data, setNames, c.n)

head(my.data)
```

    ## [[1]]
    ##         x      y   location                  species count day month
    ## 1  236708 367526  Aghadulla            Martes martes     1   6     5
    ## 2  236708 367526  Aghadulla            martes martes     1   5     5
    ## 3  236708 367526  Aghadulla            martes martes     1   4     5
    ## 4  236708 367526  Aghadulla                     sika     1   7     5
    ## 5  236708 367526  Aghadulla            Vulpes vulpes     1   4     5
    ## 6  236708 367526  Aghadulla lepus timidus hibernicus     1   1     5
    ## 7  236708 367526  Aghadulla                     sika     1   5     5
    ## 8  236708 367526  Aghadulla            Martes martes     1   6     5
    ## 9  236708 367526  Aghadulla                     sika     1   6     5
    ## 10 236708 367526  Aghadulla            Vulpes vulpes     1   4     5
    ## 11 236708 367526  Aghadulla            martes martes     1   5     5
    ## 12 302000 323000  Aghmakane            martes martes     1  12     2
    ## 13 247775 345482  Alderwood            Martes martes     1  14     4
    ## 14 247775 345482 Alderwood            Martes martes      1  18     4
    ## 15 247775 345482 Alderwood          Sciurus vulgaris     1  21     4
    ## 16 247775 345482 Alderwood          Sciurus vulgaris     1  17     4
    ##        time time.period year
    ## 1     03:10 03:00-03:59 2015
    ## 2     04:03 04:00-04:59 2015
    ## 3     04:12 04:00-04:59 2015
    ## 4     05:58 05:00-05:59 2015
    ## 5     06:40 06:00-06:59 2015
    ## 6     16:58 16:00-16:59 2015
    ## 7     19:14 19:00-19:59 2015
    ## 8     19:50 19:00-19:59 2015
    ## 9     21:11 21:00-21:59 2015
    ## 10    21:30 21:00-21:59 2015
    ## 11    23:23 23:00-23:59 2015
    ## 12    01:29 01:00-01:59 2015
    ## 13 21:07:19 21:00-21:59 2015
    ## 14 03:42:56 03:00-03:59 2015
    ## 15 07:25:04 07:00-07:59 2015
    ## 16 08:31:49 08:00-08:59 2015
    ## 
    ## [[2]]
    ##         x      y        location              species count day month
    ## 1  260925 421886      Ballykelly  apodemus sylvaticus     1  25     2
    ## 2  260925 421886      Ballykelly  apodemus sylvaticus     1  28     2
    ## 3  260925 421886      Ballykelly  apodemus sylvaticus     1  27     2
    ## 4  260925 421886      Ballykelly  apodemus sylvaticus     1  28     2
    ## 5  260925 421886      Ballykelly        Vulpes vulpes     1  26     2
    ## 6  260925 421886      Ballykelly  apodemus sylvaticus     1  23     2
    ## 7  295252 436747      Ballylough            brown rat     1  15     5
    ## 8  295252 436747      Ballylough            brown rat     1  13     5
    ## 9  295252 436747      Ballylough            brown rat     1  17     5
    ## 10 295252 436747      Ballylough            brown rat     1   3     5
    ## 11 295252 436747      Ballylough  apodemus sylvaticus     1  30     4
    ## 12 285300 398300 Ballynahone Bog Sciurus carolinensis     1  20     1
    ## 13 317006 436990    Ballypatrick        martes martes     1  11     2
    ## 14 317006 436990    Ballypatrick        martes martes     1  11     2
    ##     time time.period year
    ## 1  01:10 01:00-01:59 2015
    ## 2  03:18 03:00-03:59 2015
    ## 3  04:16 04:00-04:59 2015
    ## 4  05:55 05:00-05:59 2015
    ## 5  19:09 19:00-19:59 2015
    ## 6  22:53 22:00-22:59 2015
    ## 7  00:16 00:00-00:59 2015
    ## 8  00:40 00:00-00:59 2015
    ## 9  01:21 01:00-01:59 2015
    ## 10 03:32 03:00-03:59 2015
    ## 11 22:49 22:00-22:59 2015
    ## 12 14:33 14:00-14:59 2015
    ## 13 00:34 00:00-00:59 2015
    ## 14 05:57 05:00-05:59 2015
    ## 
    ## [[3]]
    ##         x      y       location                  species count day month
    ## 1  217955 372773       Movarran         sciurus vulgaris     1   5     5
    ## 2  217955 372773       Movarran         sciurus vulgaris     1   3     5
    ## 3  217955 372773       Movarran         sciurus vulgaris     1   4     5
    ## 4  217955 372773       Movarran         sciurus vulgaris     1   4     5
    ## 5  305800 439300 Moyarget wood                 sika deer     1  27     2
    ## 6  305800 439300 Moyarget wood             Vulpes vulpes     1   4     3
    ## 7  305800 439300 Moyarget wood  lepus timidus hibernicus     1  27     2
    ## 8  305800 439300 Moyarget wood                 sika deer     3   1     3
    ## 9  305800 439300 Moyarget wood             Vulpes vulpes     1   2     3
    ## 10 305800 439300 Moyarget wood          sciurus vulgaris     1  20     2
    ## 11 305800 439300 Moyarget wood                 sika deer     3   5     3
    ## 12 305800 439300 Moyarget wood                 sika deer     3   6     3
    ## 13 305800 439300 Moyarget wood                 sika deer     1   5     3
    ## 14 305800 439300 Moyarget wood  lepus timidus hibernicus     1  21     2
    ## 15 305800 439300  Moycraig wood      apodemus sylvaticus     1  24     2
    ## 16 305800 439300  Moycraig wood            Vulpes vulpes     1  21     2
    ## 17 273963 399293    Moydamlaght lepus timidus hibernicus     1  24     3
    ## 18 293066 394581         Moyola     Sciurus carolinensis     1  16     4
    ## 19 252100 417100      Muff Glen     Sciurus carolinensis     1  19     3
    ## 20 252100 417100      Muff Glen     Sciurus carolinensis     1  18     3
    ## 21 219580 379681   Mullans Glen     Sciurus carolinensis     1  11     2
    ## 22 318888 442724   Murlough Bay                sika deer     2   5     2
    ##     time time.period year
    ## 1  07:08 07:00-07:59 2015
    ## 2  07:41 07:00-07:59 2015
    ## 3  12:09 12:00-12:59 2015
    ## 4  15:50 15:00-15:59 2015
    ## 5  01:30 01:00-01:59 2015
    ## 6  05:42 05:00-05:59 2015
    ## 7  07:56 07:00-07:59 2015
    ## 8  09:03 09:00-09:59 2015
    ## 9  09:51 09:00-09:59 2015
    ## 10 11:50 11:00-11:59 2015
    ## 11 12:40 12:00-12:59 2015
    ## 12 16:54 16:00-16:59 2015
    ## 13 17:20 17:00-17:59 2015
    ## 14 17:43 17:00-17:59 2015
    ## 15 04:03 04:00-04:59 2015
    ## 16 14:14 14:00-14:59 2015
    ## 17 07:08 07:00-07:59 2015
    ## 18 11:43 11:00-11:59 2015
    ## 19 13:49 13:00-13:59 2015
    ## 20 15:20 15:00-15:59 2015
    ## 21 08:37 08:00-08:59 2015
    ## 22 00:58 00:00-00:59 2015

Now we'll extract our chosen columns to a new list, cast it as a dataframe and subset according to a given value. Here we're looking for all records which contain the location 'Moyarget wood'.

``` r
sub.dat <- lapply(my.data, "[", c("location", "species", "month", "time", "x", "y"))
head(sub.dat)
```

    ## [[1]]
    ##      location                  species month     time      x      y
    ## 1   Aghadulla            Martes martes     5    03:10 236708 367526
    ## 2   Aghadulla            martes martes     5    04:03 236708 367526
    ## 3   Aghadulla            martes martes     5    04:12 236708 367526
    ## 4   Aghadulla                     sika     5    05:58 236708 367526
    ## 5   Aghadulla            Vulpes vulpes     5    06:40 236708 367526
    ## 6   Aghadulla lepus timidus hibernicus     5    16:58 236708 367526
    ## 7   Aghadulla                     sika     5    19:14 236708 367526
    ## 8   Aghadulla            Martes martes     5    19:50 236708 367526
    ## 9   Aghadulla                     sika     5    21:11 236708 367526
    ## 10  Aghadulla            Vulpes vulpes     5    21:30 236708 367526
    ## 11  Aghadulla            martes martes     5    23:23 236708 367526
    ## 12  Aghmakane            martes martes     2    01:29 302000 323000
    ## 13  Alderwood            Martes martes     4 21:07:19 247775 345482
    ## 14 Alderwood            Martes martes      4 03:42:56 247775 345482
    ## 15 Alderwood          Sciurus vulgaris     4 07:25:04 247775 345482
    ## 16 Alderwood          Sciurus vulgaris     4 08:31:49 247775 345482
    ## 
    ## [[2]]
    ##           location              species month  time      x      y
    ## 1       Ballykelly  apodemus sylvaticus     2 01:10 260925 421886
    ## 2       Ballykelly  apodemus sylvaticus     2 03:18 260925 421886
    ## 3       Ballykelly  apodemus sylvaticus     2 04:16 260925 421886
    ## 4       Ballykelly  apodemus sylvaticus     2 05:55 260925 421886
    ## 5       Ballykelly        Vulpes vulpes     2 19:09 260925 421886
    ## 6       Ballykelly  apodemus sylvaticus     2 22:53 260925 421886
    ## 7       Ballylough            brown rat     5 00:16 295252 436747
    ## 8       Ballylough            brown rat     5 00:40 295252 436747
    ## 9       Ballylough            brown rat     5 01:21 295252 436747
    ## 10      Ballylough            brown rat     5 03:32 295252 436747
    ## 11      Ballylough  apodemus sylvaticus     4 22:49 295252 436747
    ## 12 Ballynahone Bog Sciurus carolinensis     1 14:33 285300 398300
    ## 13    Ballypatrick        martes martes     2 00:34 317006 436990
    ## 14    Ballypatrick        martes martes     2 05:57 317006 436990
    ## 
    ## [[3]]
    ##          location                  species month  time      x      y
    ## 1        Movarran         sciurus vulgaris     5 07:08 217955 372773
    ## 2        Movarran         sciurus vulgaris     5 07:41 217955 372773
    ## 3        Movarran         sciurus vulgaris     5 12:09 217955 372773
    ## 4        Movarran         sciurus vulgaris     5 15:50 217955 372773
    ## 5  Moyarget wood                 sika deer     2 01:30 305800 439300
    ## 6  Moyarget wood             Vulpes vulpes     3 05:42 305800 439300
    ## 7  Moyarget wood  lepus timidus hibernicus     2 07:56 305800 439300
    ## 8  Moyarget wood                 sika deer     3 09:03 305800 439300
    ## 9  Moyarget wood             Vulpes vulpes     3 09:51 305800 439300
    ## 10 Moyarget wood          sciurus vulgaris     2 11:50 305800 439300
    ## 11 Moyarget wood                 sika deer     3 12:40 305800 439300
    ## 12 Moyarget wood                 sika deer     3 16:54 305800 439300
    ## 13 Moyarget wood                 sika deer     3 17:20 305800 439300
    ## 14 Moyarget wood  lepus timidus hibernicus     2 17:43 305800 439300
    ## 15  Moycraig wood      apodemus sylvaticus     2 04:03 305800 439300
    ## 16  Moycraig wood            Vulpes vulpes     2 14:14 305800 439300
    ## 17    Moydamlaght lepus timidus hibernicus     3 07:08 273963 399293
    ## 18         Moyola     Sciurus carolinensis     4 11:43 293066 394581
    ## 19      Muff Glen     Sciurus carolinensis     3 13:49 252100 417100
    ## 20      Muff Glen     Sciurus carolinensis     3 15:20 252100 417100
    ## 21   Mullans Glen     Sciurus carolinensis     2 08:37 219580 379681
    ## 22   Murlough Bay                sika deer     2 00:58 318888 442724

``` r
dat <- do.call(rbind.data.frame, sub.dat)
head(dat)
```

    ##    location                  species month  time      x      y
    ## 1 Aghadulla            Martes martes     5 03:10 236708 367526
    ## 2 Aghadulla            martes martes     5 04:03 236708 367526
    ## 3 Aghadulla            martes martes     5 04:12 236708 367526
    ## 4 Aghadulla                     sika     5 05:58 236708 367526
    ## 5 Aghadulla            Vulpes vulpes     5 06:40 236708 367526
    ## 6 Aghadulla lepus timidus hibernicus     5 16:58 236708 367526

``` r
new.dat <- subset(dat, location == "Ballykelly")
head(new.dat)
```

    ##      location             species month  time      x      y
    ## 17 Ballykelly apodemus sylvaticus     2 01:10 260925 421886
    ## 18 Ballykelly apodemus sylvaticus     2 03:18 260925 421886
    ## 19 Ballykelly apodemus sylvaticus     2 04:16 260925 421886
    ## 20 Ballykelly apodemus sylvaticus     2 05:55 260925 421886
    ## 21 Ballykelly       Vulpes vulpes     2 19:09 260925 421886
    ## 22 Ballykelly apodemus sylvaticus     2 22:53 260925 421886
