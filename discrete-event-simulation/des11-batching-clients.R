# Puuting clients in batches
# A system at the RGs offices or at the bank

library(simmer) 
library(tidyverse)

set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am, but the door is shut.") %>%
  batch(n = Inf, timeout = 30) %>%
  separate() %>%
  log_("The door is open!") %>%
  seize("counter") %>%
  timeout(function() {rexp(1, 1/2)}) %>%
  release("counter") %>%
  log_("Finished.")

shop <- simmer("shop")
shop %>%
  add_resource("door") %>%
  add_resource("counter") %>%
  add_generator("Customer",
                customer, function() rexp(1, 1/20)) 

shop %>% run(65)

