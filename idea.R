library(devtools)
# let's try to model stochastic  non-markov process
library(dplyr)


# model of random walk with 

# TODO  
+ 1. Integration (shinyapps)
+ 2. How plot
+ 3. Random walk 1D simulation 
4. Random walk 1D with restriction simulation

shinyapps::setAccountInfo(name='goodok', token='48B41B0444C154D5DA4DB5551A4FABEA', secret='13soTVAfa8+m+9zougr1TYA4cSaUJsSqdavw0mcd')

setwd("/home/roma/p/coursera/devdataprod/random_walk_app")

library(shiny)
runApp()

library(shinyapps)
shinyapps::deployApp('/home/roma/p/coursera/devdataprod')


# Random walk 1D simulation 

sigma = 1;
mu = 0.01;
time_length = 1000;
n_experiments = 5;
train_regression_period_percentage = 0.7


sim_result <- data.frame(t=rep(1:time_length, n_experiments), y=0, experiment_id = as.factor(rep(1:n_experiments, each=time_length)))


for (experiment_id in 1:n_experiments) {
  
  current_value = 0; # start new random walk from zero level
  for (ind in 1:time_length)
  {      
    delta = rnorm(1,mu,sigma);
    current_value = current_value + delta;
    index = ind + (experiment_id-1)*time_length; # calculate position in the dataframe
    sim_result[index,]$y <- current_value
    sim_result[index,]$experiment_id <- experiment_id
  }
}





#prepare dataframe with coefficients in order to diplay in ggplot using common colors for geom_abline and geom_line 
coeff_df <- data.frame(experiment_id = unique(sim_result$experiment_id), intercept = 0, slope = 0, x = 0, xend = 0, y = 0, yend = 0);
models = list()
for (id in 1:n_experiments) {
  first_half <- dplyr::filter(tbl_df(sim_result), experiment_id == id, t <= time_length*train_regression_period_percentage )  
  lm_fit <- lm(y ~ t, first_half)  
  coeff_df[id,]$intercept = lm_fit$coefficients[1];
  coeff_df[id,]$slope = lm_fit$coefficients[2];  
  models[[id]] = lm_fit  
  
  x = 0; xend = time_length*train_regression_period_percentage;
  pred <- predict(lm_fit, data.frame(t = c(x,xend)))
  y = pred[1]
  yend = pred[2]
  
  coeff_df[id,]$x = x;
  coeff_df[id,]$xend = xend;
  coeff_df[id,]$y = y;
  coeff_df[id,]$yend = yend;
}

g <- ggplot(sim_result, aes(x=t, y=y, color = experiment_id)) + geom_line() #+ coord_cartesian(ylim = c(-50,50)) # plot time series
g <- g + geom_abline(data = coeff_df, aes(intercept = intercept, slope = slope, color= experiment_id), linetype = 2) # plot linear extrapolation fitted by using half of time series
g <- g + geom_segment(data = coeff_df, aes(x = x, xend = xend, y=y, yend = yend, color= experiment_id), linetype = 1, size = 1, arrow=arrow()) # linear regression
g <- g + geom_vline(xintercept = time_length*train_regression_period_percentage, color = "black", alpha = 1/2) # to show half time
g <- g + labs(title = "result of simmulation random walk process", x = "time", y = "distance from start")
g


# summary(lm_fit)
# 
# predict(lm_fit, 500)
# 
# 
# new <- data.frame(t = )
# 
# 
#  x <- list()
#  x[[1]] <- lm_fit
#  x[[2]] <- lm_fit
#  x 
# 
# i = 1
# x <- list()
# x[[i]] <- lm_fit
# x[[i+1]] <- lm_fit
# x 
# 
# 
# 
# g + geom_abline(intercept = lm_fit$coefficients[1], slope = lm_fit$coefficients[2], linetype = 2, aes(data = unique(sim_result$experiment_id), colour= experiment_id)) #+ scale_color_manual(values=c("red", "blue", "green", "black", "magenta"))
# 
# 
# 
# sim_result[sim_result$experiment_id == 5 & sim_result$t <= ,]
# 
# ?scale_colour_hue()
# 
# 
# # Random walk 1D simulation with restriction
# 
# 
# sigma = 1;
# mu = 0.0;
# time_length = 1000;
# n_experiments = 5;
# 
# 
# sim_result <- data.frame(t=rep(1:time_length, n_experiments), y=0, experiment_id = as.factor(rep(1:n_experiments, each=time_length)))
# 
# 
# for (experiment_id in 1:n_experiments) {
#   
#   current_value = 0; # start new random walk from zero level
#   for (ind in 1:time_length)
#   {      
#     delta = rnorm(1,mu,sigma) - current_value/100
#     current_value = current_value + delta;
#     index = ind + (experiment_id-1)*time_length; # calculate position in the dataframe
#     sim_result[index,]$y <- current_value
#     sim_result[index,]$experiment_id <- experiment_id
#   }
# }
# 
# 
# g <- ggplot(sim_result, aes(x=t, y=y, color = experiment_id)) + geom_line() + coord_cartesian(ylim = c(-100,100))
# g
# 
# 
# 
# 
# 
# # Random walk 1D simulation with restriction
# 
# 
# sigma = 1;
# mu = 0.0;
# time_length = 1000;
# n_experiments = 5;
# 
# 
# sim_result <- data.frame(t=rep(1:time_length, n_experiments), y=0, experiment_id = as.factor(rep(1:n_experiments, each=time_length)))
# 
# 
# for (experiment_id in 1:n_experiments) {
#   
#   current_value = 0; # start new random walk from zero level
#   for (ind in 1:time_length)
#   {      
#     delta = rnorm(1,mu,sigma) - current_value/100
#     current_value = current_value + delta;
#     index = ind + (experiment_id-1)*time_length; # calculate position in the dataframe
#     sim_result[index,]$y <- current_value
#     sim_result[index,]$experiment_id <- experiment_id
#   }
# }
# 
# 
# g <- ggplot(sim_result, aes(x=t, y=y, color = experiment_id)) + geom_line() + coord_cartesian(ylim = c(-100,100))
# g
# 
# 
# 
# 

## Slidify

install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv')
library(slidify)

setwd("/home/roma/p/coursera/devdataprod")
author("random_walk")

slidify("index.Rmd")
browseURL("index.html")

publish_github("random_walk", "roma-goodok")


