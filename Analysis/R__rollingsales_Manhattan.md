# LiveSessionAssignment06: Rolling Sales for Manhattan
Christopher Donlan, Rajni Goyal, and Justin Beer  
October 14, 2016  




```r
getwd()
```

```
## [1] "C:/Users/rgoyal/Desktop/MS-Data Science/Data Science/Live Session Assignments/Live Session Assignment-6"
```

```r
mh <- read.csv("rollingsales_manhattan.csv",skip=4,header=TRUE)

head(mh)
```

```
##   BOROUGH              NEIGHBORHOOD
## 1       1 ALPHABET CITY            
## 2       1 ALPHABET CITY            
## 3       1 ALPHABET CITY            
## 4       1 ALPHABET CITY            
## 5       1 ALPHABET CITY            
## 6       1 ALPHABET CITY            
##                        BUILDING.CLASS.CATEGORY TAX.CLASS.AT.PRESENT BLOCK
## 1 01  ONE FAMILY DWELLINGS                                        1   390
## 2 03  THREE FAMILY DWELLINGS                                      1   376
## 3 07  RENTALS - WALKUP APARTMENTS                                2B   373
## 4 07  RENTALS - WALKUP APARTMENTS                                2B   373
## 5 07  RENTALS - WALKUP APARTMENTS                                 2   377
## 6 07  RENTALS - WALKUP APARTMENTS                                 2   377
##   LOT EASE.MENT BUILDING.CLASS.AT.PRESENT
## 1  61        NA                        A4
## 2  24        NA                        C0
## 3  16        NA                        C1
## 4  17        NA                        C1
## 5   2        NA                        C7
## 6   2        NA                        C7
##                                     ADDRESS APARTMENT.NUMBER ZIP.CODE
## 1 189 EAST 7TH   STREET                                         10009
## 2 264 EAST 7TH STREET                                           10009
## 3 326 EAST 4TH   STREET                                         10009
## 4 328 EAST 4TH   STREET                                         10009
## 5 112 AVENUE C                                                  10009
## 6 112 AVENUE C                                                  10009
##   RESIDENTIAL.UNITS COMMERCIAL.UNITS TOTAL.UNITS LAND.SQUARE.FEET
## 1                 1                0           1              987
## 2                 3                0           3            2,059
## 3                10                0          10            2,204
## 4                10                0          10            2,204
## 5                22                3          25            4,510
## 6                22                3          25            4,510
##   GROSS.SQUARE.FEET YEAR.BUILT TAX.CLASS.AT.TIME.OF.SALE
## 1             2,183       1860                         1
## 2             3,696       1900                         1
## 3             8,625       1899                         2
## 4             8,625       1900                         2
## 5            19,830       1900                         2
## 6            19,830       1900                         2
##   BUILDING.CLASS.AT.TIME.OF.SALE SALE.PRICE  SALE.DATE
## 1                             A4       -     9/23/2015
## 2                             C0  3,775,000 10/22/2015
## 3                             C1 20,000,000 11/17/2015
## 4                             C1       -    11/17/2015
## 5                             C7 16,700,000  9/10/2015
## 6                             C7       -     9/10/2015
```

```r
summary(mh)
```

```
##     BOROUGH                     NEIGHBORHOOD  
##  Min.   :1   MIDTOWN WEST             : 4718  
##  1st Qu.:1   UPPER EAST SIDE (59-79)  : 2037  
##  Median :1   UPPER EAST SIDE (79-96)  : 1671  
##  Mean   :1   UPPER WEST SIDE (59-79)  : 1575  
##  3rd Qu.:1   MIDTOWN EAST             : 1399  
##  Max.   :1   UPPER WEST SIDE (79-96)  : 1034  
##              (Other)                  :10369  
##                                  BUILDING.CLASS.CATEGORY
##  13  CONDOS - ELEVATOR APARTMENTS            :7807      
##  10  COOPS - ELEVATOR APARTMENTS             :6144      
##  45  CONDO HOTELS                            :2504      
##  26  OTHER HOTELS                            :1457      
##  17  CONDO COOPS                             :1006      
##  07  RENTALS - WALKUP APARTMENTS             : 783      
##  (Other)                                     :3102      
##  TAX.CLASS.AT.PRESENT     BLOCK           LOT         EASE.MENT     
##  2      :16117        Min.   :   5   Min.   :   1.0   Mode:logical  
##  4      : 5124        1st Qu.: 861   1st Qu.:  37.0   NA's:22803    
##  2C     :  583        Median :1044   Median :1010.0                 
##  1      :  339        Mean   :1105   Mean   : 787.1                 
##  2B     :  276        3rd Qu.:1410   3rd Qu.:1302.0                 
##  2A     :  186        Max.   :2250   Max.   :9139.0                 
##  (Other):  178                                                      
##  BUILDING.CLASS.AT.PRESENT
##  R4     :7697             
##  D4     :5914             
##  RH     :2504             
##  H3     :1440             
##  R9     :1006             
##  C6     : 762             
##  (Other):3480             
##                                       ADDRESS          APARTMENT.NUMBER
##  1335 AVENUE OF THE AMERIC                : 1777               :11549  
##  102 WEST 57TH STREET                     : 1325   HU2         : 1236  
##  1335 AVENUE OF THE AMER                  :  443   TIMES       :  987  
##  200 EAST 94TH   STREET                   :  249   5A          :   87  
##  50 RIVERSIDE BOULEVARD                   :  173   3A          :   86  
##  301 WEST 53RD   STREET                   :  145   4A          :   78  
##  (Other)                                  :18691   (Other)     : 8780  
##     ZIP.CODE     RESIDENTIAL.UNITS  COMMERCIAL.UNITS    TOTAL.UNITS      
##  Min.   :    0   Min.   :   0.000   Min.   :  0.0000   Min.   :   0.000  
##  1st Qu.:10016   1st Qu.:   0.000   1st Qu.:  0.0000   1st Qu.:   0.000  
##  Median :10019   Median :   0.000   Median :  0.0000   Median :   1.000  
##  Mean   : 9968   Mean   :   2.417   Mean   :  0.4015   Mean   :   2.953  
##  3rd Qu.:10027   3rd Qu.:   1.000   3rd Qu.:  0.0000   3rd Qu.:   1.000  
##  Max.   :10463   Max.   :8759.000   Max.   :313.0000   Max.   :8805.000  
##                                                                          
##  LAND.SQUARE.FEET GROSS.SQUARE.FEET   YEAR.BUILT  
##   -     :19335     -     :19425     Min.   :   0  
##  7,532  : 1424    112,850: 1423     1st Qu.:1920  
##  2,500  :   34    3,600  :   13     Median :1960  
##  2,510  :   31    9,695  :   10     Mean   :1770  
##  1,665  :   25    4,000  :    9     3rd Qu.:1985  
##  2,008  :   25    7,500  :    8     Max.   :2016  
##  (Other): 1929    (Other): 1915                   
##  TAX.CLASS.AT.TIME.OF.SALE BUILDING.CLASS.AT.TIME.OF.SALE
##  Min.   :1.000             R4     :7807                  
##  1st Qu.:2.000             D4     :5914                  
##  Median :2.000             RH     :2504                  
##  Mean   :2.438             H3     :1441                  
##  3rd Qu.:2.000             R9     :1006                  
##  Max.   :4.000             C6     : 762                  
##                            (Other):3369                  
##      SALE.PRICE         SALE.DATE    
##   -       : 4519   10/28/2015:  354  
##  45,000   :  182   11/23/2015:  348  
##  10       :   95   12/21/2015:  319  
##  1,100,000:   90   7/14/2016 :  286  
##  850,000  :   88   1/13/2016 :  267  
##  650,000  :   78   6/30/2016 :  255  
##  (Other)  :17751   (Other)   :20974
```

```r
str(mh)
```

```
## 'data.frame':	22803 obs. of  21 variables:
##  $ BOROUGH                       : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ NEIGHBORHOOD                  : Factor w/ 39 levels "ALPHABET CITY            ",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ BUILDING.CLASS.CATEGORY       : Factor w/ 41 levels "01  ONE FAMILY DWELLINGS                    ",..: 1 3 5 5 5 5 5 5 5 5 ...
##  $ TAX.CLASS.AT.PRESENT          : Factor w/ 9 levels "  ","1","1A",..: 2 2 7 7 5 5 5 5 5 5 ...
##  $ BLOCK                         : int  390 376 373 373 377 377 385 387 387 387 ...
##  $ LOT                           : int  61 24 16 17 2 2 2 119 119 119 ...
##  $ EASE.MENT                     : logi  NA NA NA NA NA NA ...
##  $ BUILDING.CLASS.AT.PRESENT     : Factor w/ 122 levels "  ","A1","A4",..: 3 11 12 12 18 18 18 18 18 18 ...
##  $ ADDRESS                       : Factor w/ 11614 levels "1-2 RIVER TERRACE                        ",..: 3134 5488 6904 6922 732 732 3894 10437 10437 10433 ...
##  $ APARTMENT.NUMBER              : Factor w/ 2686 levels "            ",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ ZIP.CODE                      : int  10009 10009 10009 10009 10009 10009 10009 10009 10009 10009 ...
##  $ RESIDENTIAL.UNITS             : int  1 3 10 10 22 22 12 22 22 22 ...
##  $ COMMERCIAL.UNITS              : int  0 0 0 0 3 3 4 2 2 2 ...
##  $ TOTAL.UNITS                   : int  1 3 10 10 25 25 16 24 24 24 ...
##  $ LAND.SQUARE.FEET              : Factor w/ 1027 levels " -   ","1,003",..: 1026 402 437 437 783 783 751 669 669 669 ...
##  $ GROSS.SQUARE.FEET             : Factor w/ 1457 levels " -   ","1,000",..: 357 674 1332 1332 343 343 65 179 179 179 ...
##  $ YEAR.BUILT                    : int  1860 1900 1899 1900 1900 1900 1900 1920 1920 1920 ...
##  $ TAX.CLASS.AT.TIME.OF.SALE     : int  1 1 2 2 2 2 2 2 2 2 ...
##  $ BUILDING.CLASS.AT.TIME.OF.SALE: Factor w/ 121 levels "A1","A4","A5",..: 2 10 11 11 17 17 17 17 17 17 ...
##  $ SALE.PRICE                    : Factor w/ 6787 levels " -   ","1","1,000",..: 1 3095 2464 1 1665 1 1 1215 1 1 ...
##  $ SALE.DATE                     : Factor w/ 350 levels "1/1/2016","1/10/2016",..: 336 45 70 70 322 322 152 122 122 122 ...
```

```r
## clean/format the data with regular expressions
## More on these later. For now, know that the
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# We create a new variable that is a "clean' version of sale.price.
# And sale.price.n is numeric, not a factor.
mh$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", mh$SALE.PRICE))
count(is.na(mh$SALE.PRICE.N))
```

```
##       x  freq
## 1 FALSE 18284
## 2  TRUE  4519
```

```r
names(mh) <- tolower(names(mh)) # make all variable names lower case
## Get rid of leading digits
mh$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", mh$gross.square.feet))
head(mh$gross.sqft)
```

```
## [1]  2183  3696  8625  8625 19830 19830
```

```r
mh$land.sqft <- as.numeric(gsub("[^[:digit:]]","", mh$land.square.feet))
head(mh$land.sqft)
```

```
## [1]  987 2059 2204 2204 4510 4510
```

```r
mh$year.built <- as.numeric(as.character(mh$year.built))
head(mh$year.built)
```

```
## [1] 1860 1900 1899 1900 1900 1900
```

```r
## do a bit of exploration to make sure there's not anything
## weird going on with sale prices
attach(mh)
detach(mh)
## keep only the actual sales
mh.sale <- mh[mh$sale.price.n!=0,]
mh.homes <- mh.sale[which(grepl("FAMILY",mh.sale$building.class.category)),]
```


## Purpose

This document outlines our loading, cleaning, and exploratory analysis of the data for Manhattan rolling home sales.  

## Loading and Cleaning the Data

In order to load the data we used the read.csv function after we placed the csv file in our working directory. After loading the data we moved onto cleaning up the data. We had to set the sales price as a numeric, change the names to lower case, remove incorrect leading digits, and keep only the actual sales. Also to note, since the sales numbers are very large, they're on the scale E+000.
  
## Exploratory Data Analysis

Let us now move onto our findings for the exploratory data analysis. We only analyzed the 1, 2, and 3 family homes. First, we will plot these homes as a log10 chart of the Gross Square Footage versus the Sales Price. From this we can see that we have several outliers but that there is also a minor trend showing the possibility of the sales price increasing as the gross square footage increases.

![](R__rollingsales_Manhattan_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

In order to investigate this further, we will now remove the outliers we saw in the log10 plot. After removing the outliers we visualized the data with a natural log plot. Below we can see that there is a clearer trend of increasing sales price as the gross square footage increases as compared to the log10 plot.

![](R__rollingsales_Manhattan_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

Now that we have removed the outliers lets look at a simple plot of the gross square footage versus the sales price:

![](R__rollingsales_Manhattan_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

While the above plot shows our trend lets move onto adding a line of best fit, box plots, and standard deviation bands to best visualize this data:

![](R__rollingsales_Manhattan_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

With the above chart we can clearly visualize the trend that we are seeing. It is very clear that there is a positive correlation between the gross square footage of a 1, 2, or 3 family home and the sales price.
