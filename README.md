# browncoat
A personal repo containing functions, notes, that sort of thing. A miscellany, if you will.  

### Demonstrations   

[Generate Random Sampling Points by Minimum Distance](https://github.com/arcaravaggi/browncoat/blob/master/Rpoints.md)   
The generation of random points separated by a minimum distance threshold. Includes polygon creation and displaying polygons and points on extracted Google maps.   

[Kernel Density Estimation (KDE)](https://github.com/arcaravaggi/browncoat/blob/master/KDE.md)  
Demonstrating how to construct a KDE map, apply thresholds and convert to a raster object.

[Multi-csv import and organisation](https://github.com/arcaravaggi/browncoat/blob/master/multicsv_2.md)  
Import multiple csv files from a directory and extract relevant information. This simple demo was written to answer a question frequently asked by students.  

[Web scraping](https://github.com/arcaravaggi/browncoat/blob/master/six_nations.md)  
Scrape tables from a website, split columns and extract relevant data. This example uses data from the [Pick and Go](http://www.lassen.co.nz/pickandgo.php) website and rugby Six Nations data between 2000-2017.  

### Uploaded scripts

[bufferFrags.R](https://github.com/arcaravaggi/browncoat/blob/master/bufferFrags.R)  
Calculate habitat fragmentation indices/stats for particular coordinates. From and by [Greg Guerin](http://vegetationsciencetools.blogspot.ie/2015/07/function-for-calculating-habitat.html).  

[cInt.R](https://github.com/arcaravaggi/browncoat/blob/master/cInt.R)     
Calculation of Confidence Intervals with varying critical values, given mean and standard deviation.     

[minmax.R](https://github.com/arcaravaggi/browncoat/blob/master/minmax.R)    
Calculate minimum and maximum variance based on n bootstrapping iterations, with thresholding.     

[multicsv.R](https://github.com/arcaravaggi/browncoat/blob/master/multicsv.R)  
Import files from multiple sub(+)directories, with basic cleaning.  

[multiplot.R](https://github.com/arcaravaggi/browncoat/blob/master/multiplot.R)   
Multiple plot function, from [R Cookbook](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/).  

[package.R](https://github.com/arcaravaggi/browncoat/blob/master/package.R)  
Simplified loading and installing of packages, from [rbloggers](https://www.r-bloggers.com/function-to-simplify-loading-and-installing-packages/).  

[rem_resample.R](https://github.com/arcaravaggi/browncoat/blob/master/rem_resample.R)  
Resample camera trap zone of detection metrics (r & theta) and calculate 95% confidence intervals.  

[secretsanta.R](https://github.com/arcaravaggi/browncoat/blob/master/secretsanta.R)    
Run a Secret Santa exchange from within R. Includes mail merge and send.   

[suntimes.R](https://github.com/arcaravaggi/browncoat/blob/master/suntimes.R)  
Calculate sunrise and sunset for a given location at a given time of year.   

[theme_ac1.R](https://github.com/arcaravaggi/browncoat/blob/master/theme_ac1.R)  
Custom ggplot theme for publication-quality figures.    

### Gists  

For all Gists, [click here](https://gist.github.com/arcaravaggi)  

[arrange_cols.R](https://gist.github.com/arcaravaggi/38d9739380a08464e990427ba5222356)  
(Re-)arrange columns of a dataframe.

[autonoRm.R](https://gist.github.com/arcaravaggi/72b63b6552941f33f7b3955e0600e2fd)  
Generate a set of autocorrelated random normal variates.  

[binRC.R](https://gist.github.com/arcaravaggi/3d1aa1932f138d0ea679c103551a81a8)  
Reduce multiple columns to single binary vector.   

[coefplot.R](https://gist.github.com/arcaravaggi/298d257e53473b1e3beaaba449ec50ec)  
Plot regression coefficients, from [r-statistics](https://www.r-statistics.com/wp-content/uploads/2010/07/coefplot.r.txt"), by [Achim Zeileis](http://statmath.wu.ac.at/~zeileis/).  

[confNet.R](https://gist.github.com/arcaravaggi/7026b017a3909df2da3b09d67cdb8e59)  
Function to create network data objects.   

[cor.test.R](https://gist.github.com/arcaravaggi/004979408be4116505a49bd1d4c6e298)
Function for pairwise correlations across a data frame

[df_col_split.R](https://gist.github.com/arcaravaggi/05a1b15fa67a74ba9f0b0614f9a8281c)  
Split column into multiple based on spaces, extra characters, etc.  

[explodeR.R](https://gist.github.com/arcaravaggi/8e03ccd634de026a184bbb042f37fc71)   
Copy row duplicating data *Xi* times. By StackOverflow user, [CPak.](https://stackoverflow.com/a/50930471/9962100)    

[euDist.R](https://gist.github.com/arcaravaggi/b990ff3b9545a453761af5f2195b151c)    
Calculate Euclidean distance between groups of ecological point data.

[extractCoords.R](https://gist.github.com/arcaravaggi/cc7a0995279d2a05780b733bed74554c)   
Extract coordinates from SpatialPolygon object.    

[facetR2.R](https://gist.github.com/arcaravaggi/b2c9bf65d4df24b5f030c8062695bbd8)    
Label ggplot facet plots with facet group name and R^2. From [Stack Overflow](https://stackoverflow.com/questions/17022553/adding-r2-on-graph-with-facets).    

[ipak.R](https://gist.github.com/arcaravaggi/029354c3e46d94b999419a3c72215005)   
Function to load a list of packages and install package if absent.   

[maxDup_NAs.R](https://gist.github.com/arcaravaggi/2acdf426c13af3aea7c5f25951585fbf)  
Split data by focal column and remove duplicates from a span to columns, keeping the one with the most data.  Adapted from [akrun](https://stackoverflow.com/questions/33047084/r-remove-duplicated-value-conditionally-between-row-keeping-the-one-with-less-n).  

[modOverlap.R](https://gist.github.com/arcaravaggi/0b829257f41c3554cbbff8b1017ba6b1)  
Metrics for quantifying the similarity among ecological niche models, from [modtools](https://modtools.wordpress.com/2015/10/30/modoverlap/).

[multicsv_lst.R](https://gist.github.com/arcaravaggi/1abb4e19a20263b85cd7e488acd94ceb)  
Read multiple csv files from one directory.  

[multidf_to_csv.R](https://gist.github.com/arcaravaggi/eb7c1ab87a2dfd75aebfdf19757aeb63)  
Export all active dataframes to named csv files.  

[power_analysis.R](https://gist.github.com/arcaravaggi/81e318c807a1cb259bc5cb6bda227fd4)   
Simple power aalysis in R.   

[presabsRas.R](https://gist.github.com/arcaravaggi/bd59fa55dfcaf855c1f43fdab5655e28)  
Create raster of species presence/absence. Created by [Amy Whitehead](https://amywhiteheadresearch.wordpress.com/2016/01/25/extracting-raster-data-using-a-shapefile/#more-918).

[simpleCap.R](https://gist.github.com/arcaravaggi/e8c2a720dea43ab5d3f24e0fe5da0476)   
Capitalise the first letter of every word in a string, by [stackoverflow user Andrie](https://stackoverflow.com/questions/6364783/capitalize-the-first-letter-of-both-words-in-a-two-word-string).  

[spLine.ld.R](https://gist.github.com/arcaravaggi/2b24abfb39b8ec4dd80b52f3e69280e4)   
Intersects SpatialLine and SpatialPolygon objects and produces total line length and density per polygon ID.   

[tnorm.R](https://gist.github.com/arcaravaggi/bafe1982851078f9bc5b9f64d4568585)    
Function for the truncation of a generated normal distribution (adapted *rnorm*).     

[tweetstorm.R](https://gist.github.com/arcaravaggi/bd4b99a5f006c999e9290fbd73637ec8)  
Create a series of related tweets from one text string, from [emotiononthebrain](https://sites.tufts.edu/emotiononthebrain/2017/08/12/time-for-a-tweetstorm/).   

[update_migrate.R](https://gist.github.com/arcaravaggi/20acc42e3e245cc268a95269de024b2d)  
Update to the latest version of R and migrate/update packages to new installation, from within the console.   

[veQ.R](https://gist.github.com/arcaravaggi/299cb55475455a6036324b6562f79ea7)  
Generate dispersion (including plot) and summary metrics for a given vector.   
