# Reneging means abandoning 
# so we are saying customer abandons queue because they are impatient
# compare to baulking in which they leave when they feel queue is too long 
# make use of renege_in function - considering leaving queue
# and renege_abort - throught about leaving but did not leave in the end 

library(simmer) 
library(tidyverse)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  renege_in(function() rnorm(1,5,1),
            out = trajectory("Reneging customer") %>%
              log_("I am off")) %>%
  seize("counter") %>%
  renege_abort() %>%
  timeout(function() rnorm(1,10,2)) %>%
  release("counter") %>%
  log_("Finished")

shop <-
  simmer("shop") %>%
  add_resource("counter") %>%
  add_generator("Customer", customer, function() rexp(1, 1/5))

run(shop, until = 100)
