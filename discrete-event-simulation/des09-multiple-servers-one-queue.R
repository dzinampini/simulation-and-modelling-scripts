# Multiple counters - single queue

library(simmer) 
library(tidyverse)

set.seed(2021)
customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  select(c("counter1", "counter2"), policy = "shortest-queue") %>%
  seize_selected() %>%
  timeout(function() rnorm(1,10,2)) %>%
  release_selected() %>%
  log_("Finished")

shop <-
  simmer("shop") %>%
  add_resource("counter1", 1) %>%
  add_resource("counter2", 1) %>%
  add_generator("Customer", customer, function() rexp(1, 1/5))

run(shop, until = 45)


