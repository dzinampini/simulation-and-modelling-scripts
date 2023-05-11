# function for our spinner gam
play.game <- function(){
  results <- sample(c(1,1,-1,2), 10, replace=T)
  return(sum(results) < 0)
}

runs <- 100000
mc.prob <- sum(replicate(runs,play.game()))/runs
