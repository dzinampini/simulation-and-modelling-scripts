library(simmer.plot)

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

shop <-
  simmer("shop") %>%
  add_resource("counter",1) %>%
  add_generator("Customer", customer, function() rexp(1, 1/5))

# add number of counters on the counter resource 

shop %>% run(until = 30)
# shop %>% get_mon_arrivals()

resources<-get_mon_resources(shop)
plot(resources, metric = "resources utilization")

plot(resources, metric = "usage",steps=T)

