Read multiple csv files and subset
================
Anthony Caravaggi
9 January 2018

```{r echo = OFF}
setwd("files/")
```

The script, below, assumes that the csv files are located in the working directory. If this is not the case, edit the code accordingly (e.g. dir(path = '....', pattern...)).

First, read the csv names.

```{r}
csv_files <- dir(pattern='*.csv$', recursive = T)
csv_files
```

Then, create an empty list to store the dataframs and use a for loop to read the csv files into the list. Some people will no doubt shake their heads at the use of a for loop, but it does the job nicely. The `skip` command in read.csv tells the function to drop all rows up to a given point. Our data have a lot of noise in the first dozen or so rows, so we'll omit them. 

```{r}
my.data <- list()

for (i in 1:length(csv_files)){
  my.data[[i]] <- read.csv(csv_files[[i]], header = F, skip=15, as.is = T)
}

head(mydata[[1]])
```

Before we extract specific columns to a new list, we want to make sure that all columns have the same names. That's easy to do, particularly as I'm using files with the same number and type of columns. That was lucky. 

```{r}
c.n <- c("Col_1", "Col_2", "Col_3", "Col_4", "Col_5", "Col_6", "Col_7", "Col_8", "Col_9", "Col_10")
my.data <- lapply(my.data, setNames, c.n)

head(my.data)
```

Now we'll extract our chosen columns to a new list, cast it as a dataframe and subset according to a given value. Here we're looking for all records which contain the location 'Aghadulla'.

```{r}
sub.dat <- lapply(my.data, "[", c("Col_1", "Col_3", "Col_4", "Col_7"))
dat <- do.call(rbind.data.frame, sub.dat)
new.dat <- subset(dat, Col_1 = "Aghadulla")
```
