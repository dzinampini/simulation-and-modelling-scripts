# Balking occurs when a customer refuses to join a queue if it is too long. 
# Suppose that if there is one customer queuing in our shop then customers do not join the queue and leave. 
# So we set queue_size option of add_resource and by adding some options of the seize function. 

library(simmer) 
library(tidyverse)
set.seed(2021)

customer <-
  trajectory("Customer's path") %>%
  log_("Here I am") %>%
  seize("counter", continue = FALSE, reject = 
          trajectory("Balked customer") %>% log_("Balking") ) %>%
  timeout(function() rnorm(1,10,2)) %>%
  release("counter") %>%
  log_("Finished")

shop <-
  simmer("shop") %>%
  add_resource("counter", queue_size = 1) %>%
  add_generator("Customer", customer,
                function() rexp(1, 1/5))

set.seed(2021)
shop %>% run(until = 100) # change here to see effect of not having Balked customers
