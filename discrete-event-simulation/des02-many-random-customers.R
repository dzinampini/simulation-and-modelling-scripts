library(simmer)
library(tidyverse)

set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  timeout(10) %>%
  log_("I must leave")

shop <-
  simmer("shop") %>%
  add_generator("Customer", customer, function() rexp(1, 1/5)) 
# note this time its not on at

shop %>% run(until = 30)
shop %>% get_mon_arrivals()



