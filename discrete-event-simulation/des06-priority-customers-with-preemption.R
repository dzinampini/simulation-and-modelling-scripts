# This requires only a change to one line of the program, adding the argument, preemptive = TRUE

library(simmer)
#library(magrittr)
#library(dplyr)  
library(tidyverse)
set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  seize("counter") %>%
  timeout(function() rnorm(1,10,2)) %>%
  release("counter") %>%
  log_("Finished")

shop <-
  simmer("shop") %>%
  add_resource("counter", preemptive = TRUE) %>%
  add_generator("Customer", customer, function() rexp(1, 1/5)) %>%
  add_generator("Priority_Customer", customer, function() rexp(1, 1/15), priority = 1)

shop %>% run(until = 45)

