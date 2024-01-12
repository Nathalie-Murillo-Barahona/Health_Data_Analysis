Effect of Income Level on Adult Obesity Rates
================
Nathalie
2023-07-21

## Introduction

In recent decades, the escalating prevalence of obesity in the United
States has emerged as a critical public health concern, necessitating an
exploration into the factors which drive the condition. This analysis
delves into the relationship between household income levels and obesity
rates across different states in the U.S. By scrutinizing the
intersection of socio-economic disparities and health outcomes. Through
a comprehensive exploration of available data, the aim is to discern
patterns which are key to understanding how the condition presents
itself across income classes.

## Data

The data for this analysis is sourced from the [CDC’s Nutrition,
Physical
Activity](https://data.cdc.gov/Nutrition-Physical-Activity-and-Obesity/Nutrition-Physical-Activity-and-Obesity-Behavioral/hn4x-zwk7).
The dimensions of the CDC’s data is 88,600 rows and 33 columns. The data
set consists of measures/questions of interest (example: *Percent of
adult population with obesity*) aggregated across various dimensions of
interest (examples: *year, state, socio-economic class, race, etc…*).

## Process

### Data Cleaning

In order to make use of the data some cleaning of the data had to be
done. The full code for the data cleaning can be found in
[here](./Scripts/data_cleaning.R). In summary the steps were:

- Removed unused columns from the data set.
- Filter the data set down to the question of interest (adult obesity).
- Filter the data set down to the dimensions of interest (Income class,
  state and year).
- Clean out any data points where the observation was missing or
  location was a US territory rather than a state.
- Created an numerical variable which corresponds to ordinal income
  level.

### Exploritory Data Analysis

Below is a table of the summary statistics for each state aggregated by
income level.

| Income Level        | Min Obesity Rate | Max Obesity Rate | Avg Obesity Rate | Median Obesity Rate |
|:--------------------|-----------------:|-----------------:|-----------------:|--------------------:|
| Less than \$15,000  |             13.3 |             40.7 |            29.45 |               29.60 |
| \$15,000 - \$24,999 |             23.8 |             45.1 |            32.68 |               32.80 |
| \$25,000 - \$34,999 |             19.8 |             44.3 |            34.59 |               34.80 |
| \$35,000 - \$49,999 |             27.7 |             45.8 |            36.04 |               35.95 |
| \$50,000 - \$74,999 |             27.5 |             46.8 |            37.08 |               37.10 |
| \$75,000 or greater |             27.2 |             45.2 |            38.13 |               38.25 |

Obesity rates by income level aggerated over state and year.

As can be seen in the summary table, on average obesity rates among
adults tends to increase with income level when obesity rates from
different states and years are aggregated by income level.

This trend can also be observed in the box plot visual below. This
visual is useful for looking at the distribution of the observations
from different states and years across income levels
![](README_files/figure-gfm/income%20obesity%20box%20plot-1.png)<!-- -->
As can be seen in the box plot as income level rises the distribution of
obesity rates also rises. However, this effect seems to diminish as
income increases.

### Hypothesis

Null Hypothesis: The effect of income on increasing obesity remains
constant as income level rises.

Hypothesis: The effect of income on increasing obesity weakens as income
level rises.

To test this hypothesis we can analyze the marginal changes in odds
ratio when income level increases by one level.

This can be accomplished by recursively fitting a logistic regression
model with percent of adults who are obese as the response variable and
income level as the independent variable. Income level is encoded as a
binary variable for each level indicating if an observation belongs to
that income level. Each time the model is fit we increase the reference
level of the income by one (starting with the base level of less than
\$15,000 annual household income) and extract the model coefficient
related to the income level one greater than the reference level. This
model coefficient is then used to the calculate the marginal odds ratio
of increasing income by one level. High and low bounds for the 95
percent confidence interval for coefficient are also extracted in order
to determine statistical significance of the marginal change in odds
ratio. Below is a plot showing the results of this process. 95 percent
confidence interval is shown using the error bars around the point
estimates. ![](README_files/figure-gfm/marginal%20change-1.png)<!-- -->

The plot shows the marginal odds ratio steadily decreasing as income
level increases. The odds ratios drop for every increasing level of
income except odds ratio appears to increase when looking at the
increase from going 50K to 75K to the 75K+ income level. However, it
should be noted that the confidence interval from the previous level
overlaps indicating that the change in odds ratio is not statistically
significant. All other changes in the odds ratios with increasing income
show a significant decrease effect of income. This should not be
interpreted as that increasing income level causes likelihood of obesity
to decrease. Rather, that the power of income to increase obesity drops
as income rise.

### Conclutions and Areas for Further Analysis

Based on the logistic regression modeling done and comparison of the
marginal odds ratio at various income levels we can reject the null
hypothesis that the effect of income level remains constant on obesity.
Some possible explanations of this weakening effect could be that as
adult’s income level increase they have more disposable income to spend
on healthier food, or personal health and fitness. A limitation of the
data available is that is all income level beyond 75k per year are
lumped together. A limitation of this analysis is that the effect of the
survey year was not modeled and therefore unknown and maybe a
confounding variable in this analysis. An area where further analysis
could be done is in normalizing income for the cost of living within
states and refiting the logistic regression models to see if the effect
of income level still weakens.
