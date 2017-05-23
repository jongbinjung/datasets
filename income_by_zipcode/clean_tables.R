#!/usr/bin/env Rscript
# Created: 2017-05-22
# Author: jongbin

library(tidyverse)


mean_income_raw <- read_csv("ACS_15_5YR_S1902.csv", col_types = cols_only(
  "GEO.id2" = col_character(),
  "HC01_EST_VC20" = col_integer(),  # Total; Total population
  "HC01_EST_VC22" = col_double(),  # Population; Estimate; PER CAPITA INCOME - White
  "HC01_EST_VC23" = col_double(),  # Population; Estimate; PER CAPITA INCOME - Black or African American
  "HC01_EST_VC24" = col_double(),  # Population; Estimate; PER CAPITA INCOME - American Indian and Alaska Native
  "HC01_EST_VC25" = col_double(),  # Population; Estimate; PER CAPITA INCOME - Asian
  "HC01_EST_VC26" = col_double(),  # Population; Estimate; PER CAPITA INCOME - Native Hawaiian and Other Pacific Islander
  "HC01_EST_VC27" = col_double(),  # Population; Estimate; PER CAPITA INCOME - Some other race
  "HC01_EST_VC28" = col_double(),  # Population; Estimate; PER CAPITA INCOME - Two or more races
  "HC02_EST_VC22" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - White
  "HC02_EST_VC23" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - Black or African American
  "HC02_EST_VC24" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - American Indian and Alaska Native
  "HC02_EST_VC25" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - Asian
  "HC02_EST_VC26" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - Native Hawaiian and Other Pacific Islander
  "HC02_EST_VC27" = col_integer(),  # Mean income (dollars); Estimate; PER CAPITA INCOME - Some other race
  "HC02_EST_VC28" = col_integer()	  # Mean income (dollars); Estimate; PER CAPITA INCOME - Two or more races
  )) %>%
  rename(
    zipcode = GEO.id2,
    population = HC01_EST_VC20,
    white_pop = HC01_EST_VC22,
    black_pop = HC01_EST_VC23,
    native_pop = HC01_EST_VC24,
    asian_pop = HC01_EST_VC25,
    pacific_pop = HC01_EST_VC26,
    other_single_pop = HC01_EST_VC27,
    two_pop = HC01_EST_VC28,
    white = HC02_EST_VC22,
    black = HC02_EST_VC23,
    native = HC02_EST_VC24,
    asian = HC02_EST_VC25,
    pacific = HC02_EST_VC26,
    other_single = HC02_EST_VC27,
    two = HC02_EST_VC28
  ) %>%
  mutate(
    white_pop = population * white_pop / 100,
    black_pop = population * black_pop / 100,
    native_pop = population * native_pop / 100,
    asian_pop = population * asian_pop / 100,
    pacific_pop = population * pacific_pop / 100,
    other_single_pop = population * other_single_pop / 100,
    two_pop = population * two_pop / 100
  ) %>%
  write_rds("income_by_zip.rds", compress = "gz")
