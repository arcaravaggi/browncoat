Scrape and clean Six Nations data
================
Anthony Caravaggi
2018-10-01

This was a simple exercise in scraping and cleaning a table from a website.

Load required libraries

``` r
library(XML)
library(RCurl)
```

    ## Loading required package: bitops

``` r
library(rlist)
library(stringr)
```

Import website. Here I'm extracting data from Pick and Go: <http://www.lassen.co.nz/pickandgo.php>

``` r
url.00 <- getURL("http://www.lassen.co.nz/pickandgo.php?fyear=%22,2000:2017,%22&tyear=%22,2000:2017,%22&hema=NH&tourn=6N#hrh",.opts = list(ssl.verifypeer = FALSE) )
```

Read all tables from the site and preserve the largest (which.max)

``` r
tables <- readHTMLTable(url.00)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
sn.00 <- tables[[which.max(n.rows)]]
```

Check the head and tail for unwated data and remove if present

``` r
head(sn.00)
```

    ##               Date Tourn Rnd     Match Score Tries Pnts
    ## 1 Sat, 05 Feb 2000    6N   1 ENG v IRE 50-18   6:2  2-0
    ## 2 Sat, 05 Feb 2000    6N   1 WAL v FRA  3-36   0:3  0-2
    ## 3 Sat, 05 Feb 2000    6N   1 ITA v SCO 34-20   1:2  2-0
    ## 4 Sat, 19 Feb 2000    6N   2 IRE v SCO 44-22   5:3  2-0
    ## 5 Sat, 19 Feb 2000    6N   2 WAL v ITA 47-16   4:1  2-0
    ## 6 Sat, 19 Feb 2000    6N   2 FRA v ENG  9-15   0:0  0-2
    ##                         Venue Adv
    ## 1          Twickenham, London   H
    ## 2 Millennium Stadium, Cardiff   H
    ## 3       Stadio Flaminio, Rome   H
    ## 4        Lansdowne Rd, Dublin   H
    ## 5 Millennium Stadium, Cardiff   H
    ## 6      Stade de France, Paris   H

``` r
tail(sn.00)
```

    ##                  Date        Tourn       Rnd     Match   Score
    ## 283  Sat, 17 Mar 2018           6N         5 ITA v SCO   27-29
    ## 284  Sat, 17 Mar 2018           6N         5 ENG v IRE   15-24
    ## 285  Sat, 17 Mar 2018           6N         5 WAL v FRA   14-13
    ## 286                   Totals Â Â Â 6885-5565   648:538 409-245
    ## 287 Differences Â Â Â         1320       110       164    <NA>
    ## 288    Averages Â Â Â        24-20       2:2       1-1    <NA>
    ##                     Tries Pnts                       Venue  Adv
    ## 283                   3:4  1-5       Stadio Flaminio, Rome    H
    ## 284                   3:3  0-4          Twickenham, London    H
    ## 285                   1:1  4-1 Millennium Stadium, Cardiff    H
    ## 286 Â© www.pickandgo.info <NA>                        <NA> <NA>
    ## 287                  <NA> <NA>                        <NA> <NA>
    ## 288                  <NA> <NA>                        <NA> <NA>

``` r
sn.00 <- sn.00[-c(271:273),]
```

Split columns which contain combined data (e.g. teams: Wal v Fra) by character

``` r
m <- str_split_fixed(sn.00$Match, " v ", 2)
s <- str_split_fixed(sn.00$Score, "-", 2)
t <- str_split_fixed(sn.00$Tries, ":", 2)
p <- str_split_fixed(sn.00$Pnts, "-", 2)
```

Extract the year the competition took place

``` r
y <- str_sub(sn.00$Date, start= -4)
```

Recombine all into new dataframe and rename columns

``` r
SixNations <- data.frame(y, sn.00$Rnd, m[,1], m[,2], s[,1], s[,2], t[,1],  t[,2], p[,1], p[,2], sn.00$Venue)
names(SixNations) <- c("year", "round", "home", "away", "score_h", "score_a", "tries_h", "tries_a",
                       "points_h", "points_a", "venue")
head(SixNations)
```

    ##   year round home away score_h score_a tries_h tries_a points_h points_a
    ## 1 2000     1  ENG  IRE      50      18       6       2        2        0
    ## 2 2000     1  WAL  FRA       3      36       0       3        0        2
    ## 3 2000     1  ITA  SCO      34      20       1       2        2        0
    ## 4 2000     2  IRE  SCO      44      22       5       3        2        0
    ## 5 2000     2  WAL  ITA      47      16       4       1        2        0
    ## 6 2000     2  FRA  ENG       9      15       0       0        0        2
    ##                         venue
    ## 1          Twickenham, London
    ## 2 Millennium Stadium, Cardiff
    ## 3       Stadio Flaminio, Rome
    ## 4        Lansdowne Rd, Dublin
    ## 5 Millennium Stadium, Cardiff
    ## 6      Stade de France, Paris

The final dataframe can be found at: <https://github.com/arcaravaggi/browncoat/blob/master/six_nations_data/six_nations_00-17.csv>
