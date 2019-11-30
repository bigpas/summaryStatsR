# summaryStatsR [![Build Status](https://travis-ci.org/bigpas/summaryStatsR.svg?branch=master)](https://travis-ci.org/bigpas/summaryStatsR)

A `R` package to compute summary statistics (`min, mean, median, sd, sem, max, N`).

It is designed to work with the 3 major `data frame` flavours

+ `data.frame`
+ `data.table`
+ `tibble`

## Examples

### Summarise A Single Variable

```r
> summary_stats(data=iris, 'Petal.Length')
  min_PETAL.LENGTH avg_PETAL.LENGTH median_PETAL.LENGTH sd_PETAL.LENGTH sem_PETAL.LENGTH max_PETAL.LENGTH   N
1                1             3.76                4.35            1.77             0.14              6.9 150
```

### Grouping by One Variable

```r
> grouped_summary_stats(data=iris, group = 'Species', target_var = 'Petal.Length')
# A tibble: 3 x 8
  Species   min_PETAL.LENGTH avg_PETAL.LENGTH median_PETAL.LENG~ sd_PETAL.LENGTH sem_PETAL.LENGTH max_PETAL.LENGTH     N
  <chr>                <dbl>            <dbl>              <dbl>           <dbl>            <dbl>            <dbl> <dbl>
1 setosa                 1               1.46               1.5             0.17             0.02              1.9    50
2 versicol~              3               4.26               4.35            0.47             0.07              5.1    50
3 virginica              4.5             5.55               5.55            0.55             0.08              6.9    50
```

### Grouping by Two Variables

```r
> grouped2_summary_stats(data=mtcars, group1 =  "gear", group2 = "cyl", target_var = 'mpg')
# A tibble: 8 x 9
   gear   cyl min_MPG avg_MPG median_MPG  sd_MPG sem_MPG max_MPG     N
  <dbl> <dbl>   <dbl>   <dbl>      <dbl>   <dbl>   <dbl>   <dbl> <dbl>
1     3     4    21.5    21.5       21.5 NaN       NA       21.5     1
2     3     6    18.1    19.8       19.8   2.33     1.65    21.4     2
3     3     8    10.4    15.0       15.2   2.77     0.8     19.2    12
4     4     4    21.4    26.9       25.8   4.81     1.7     33.9     8
5     4     6    17.8    19.8       20.1   1.55     0.78    21       4
6     5     4    26      28.2       28.2   3.11     2.2     30.4     2
7     5     6    19.7    19.7       19.7 NaN       NA       19.7     1
8     5     8    15      15.4       15.4   0.570    0.4     15.8     2
```

## TODO

[-] Add a function to group by an arbitrary number of variables
