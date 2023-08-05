library(simmer)
library(tidyverse)

set.seed(2021)
# initialising a pseudorandom number generator.
# These numbers are generated with an algorithm that requires a seed to initialize. 
# Being pseudorandom instead of pure random means that, if you know the seed and the generator, 
# you can predict (and reproduce) the output. 
# Setting a seed in R means to initialize a pseudorandom number generator. 

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  timeout(10) %>%
  log_("I must leave")

shop <-
  simmer("shop") %>%
  add_generator("Customer", customer, at(rexp(1, 1/5)))
# We will assume that the customer arrival time is generated from an Exponential distribution 
# with parameter 1/5 (that is mean = 5)

shop %>% run(until = 100)

