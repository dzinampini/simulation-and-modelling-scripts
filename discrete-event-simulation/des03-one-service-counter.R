library(simmer)
library(tidyverse)

set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  seize("counter") %>%
  timeout(function() rnorm(1,10,2)) %>%
  release("counter") %>%
  log_("Finished")
# We will assume that serving time follows a Normal distribution with mean 10 and standard deviation 2.

shop <-
  simmer("shop") %>%
  add_resource("counter") %>%
  add_generator("Customer", customer, function() rexp(1, 1/5))

shop %>% run(until = 100)
shop %>% get_mon_arrivals()