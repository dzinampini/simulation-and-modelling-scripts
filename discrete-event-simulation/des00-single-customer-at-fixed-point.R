# install simmer using console 
# install.packages("simmer")
# install.packages("tidyverse")

library(simmer)
library(tidyverse)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  timeout(30) %>% 
  log_("Thank you for serving me!")
# customer - variable which describes the evolution of the customer in the shop
# trajectory - The evolution (lifespan) of the customer
# log_ - produces text which is shown as specific points during the simulation 
# timeout - specifies how long the customer will spend in the shop
# customer will take 10 minutes to get served meaning at 15 minutes they will be out

# %>%, is a pipe operator, a feature of the magrittr package for R. 
# It takes the output of one function and passes it into another function as an argument.

# now this is the behaviour of the shop itself 
shop <-
  simmer("shop") %>%
  add_generator("Customer", customer, at(20)) 
# shop - variable which describes behaviour of the shop
# first create a simmer object called shop 
# specify via the function add_generator that a customer arrives after 5 minutes.
# customer arrives with their behaviour shown/described above using customer variable
# this customer will arrive at 5 minutes after shop opening 

shop%>%run(until = 100)

# shop %>% get_mon_arrivals()
# this line will help have. a better overview of whats happening



