Health_Data_Analysis
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
interest (examples: *state, socio-economic class, race, etc…*).

## Process

### Data Cleaning

In order to make use of the data some cleaning of the data had to be
done. The full code for the data cleaning can be found in
[here](../Scripts/data_cleaning.R). In summary the steps were:

- Removed unused columns from the data set.
- Filter the data set down to the question of interest (adult obesity).
- Filter the data set down to the dimensions of interest (Income class
  and state).
- Clean out any data points where the observation was missing or
  location was a US territory rather than a state.
- Created an numerical variable which corresponds to ordinal income
  level.

### Exploritory Data Analysis
