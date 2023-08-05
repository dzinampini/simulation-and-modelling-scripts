# here we add a door as a resource 
# a customer can be held getting in at the door 

library(simmer) 
library(tidyverse)

set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_(function()
    if (get_capacity(shop, "door") == 0)
      "Here I am but the door is shut."
    else "Here I am and the door is open."
  ) %>%
  seize("door") %>%
  log_("I can go in!") %>%
  release("door") %>%
  seize("counter") %>%
  timeout(function() {rexp(1, 10)}) %>%
  release("counter")

door_schedule <- schedule(c(1,7,9,13), c(Inf,0,Inf,0), period = 13)

shop <-
  simmer("shop") %>%
  add_resource("door", capacity = door_schedule) %>%
  add_resource("counter") %>%
  add_generator("Customer", customer, function() rexp(1, 1))

shop %>% run(100)
