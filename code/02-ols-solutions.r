# ************************************************
### simon munzert
### ols and multiple regression - solutions
# ************************************************

source("packages.r")
source("functions.r")


# **************************

# ASSIGNMENT ---------------


## 1. The dataset "bwght" from the wooldridge package contains data on smoking behavior and infant birth weight.
# a) Use the data to estimate the unconditional effect of cigarette consumption on child birth weight! There are two variables in the dataset that measure cigarette consumption. How are the results affected by the choice of variables here? Why? What happens if you include both variables in one model? Why?
# b) The infant birth weight is measured in ounces. Create a new variable bwghtkg that measures birth weight in kilograms. How does this affect the model estimates?

data(bwght)
?bwght

lm(bwght ~ cigs + packs, data = bwght)
with(bwght, plot(cigs, packs))
summary(bwght$cigs / bwght$packs)

summary(lm(bwght ~ cigs, data = bwght))
summary(lm(bwght*.028 ~ cigs, data = bwght))


# 2. Consider the "hprice1" dataset from the wooldridge package.
  # a) Estimate the following model: price = beta_0 + beta_1*sqrft + beta_2*bdrms + u
  # b) What is the estimated increase in price for a house with one more bedroom, holding square footage constant? And what is the estimated price for a house with 100 square meters and 4 bedrooms?
  # c) What percentage of the variation in price is explained by square footage and number of bedrooms?
  # d) Identify both the most overvalued and undervalued house in the sample, according to this simple model! 

data(hprice1)
?hprice1

model_out <- lm(price ~ sqrft + bdrms, data = hprice1)
summary(model_out)
coef(model_out)["bdrms"]

coef(model_out)[1] + 
coef(model_out)[2]*100*10.7639 + 
coef(model_out)[3]*4

summary(model_out)$r.squared

hprice1$price_fitted <- predict(model_out)
hprice1$price_resid <- resid(model_out)
hprice1 <- arrange(hprice1, price_resid)
head(hprice1)
tail(hprice1)


# 3. Demonstrate how post-treatment bias can also produce a coefficient on the treatment that is much larger than the actual treatment effect, i.e. that this type of bias can let you overestimate the effect size! Do so by performing a simple simulation in R.

set.seed(42)
N <- 500
x <- rnorm(N, 0, 1)
ed <- rnorm(N, 0, .5)
d <- -x + ed  # negative relationship between d and x!
ey <- rnorm(N, 0, .5)
y <- x + d + ey

cor(cbind(y, x, d))
plot(x, y)

summary(lm(y ~ x)) # true effect of x on y: 0

# model with induced post-treatment bias
summary(lm(y ~ x + d)) # estimated effect with control for d: 1


# 4.  Use the data in wage1 from the wooldridge package.
# a) Use OLS to estimate the equation "log(wage) = beta0 + beta1*educ + beta2*exper + beta3*exper^2 + u" and report the results.
# b) Is exper^2 significant at the 1% level?
# c) Using the approximation %change(wage) = 100*(beta2 + 2*beta3*change(exper)), find the approximate return to the fifth year of experience. What is the approximate return to the twentieth year of experience?
# d) At what value of exper does additional experience actually lower predicted log(wage)? How many people have more experience in this sample?

data(wage1)
wage1$exper2 <- wage1$exper^2
model_out <- lm(log(wage) ~ educ + exper + exper2, data = wage1)
summary(model_out)

100*(coef(model_out)[3] + 2*coef(model_out)[4]*5)
100*(coef(model_out)[3] + 2*coef(model_out)[4]*20)
dat_new <- data.frame(wage = NA, educ = 10, exper = 5, exper2 = 25)
dat_new <- data.frame(wage = NA, educ = 10, exper = 20, exper2 = 400)
predict(model_out, newdata = dat_new)

curve(coef(model_out)[3]*x + coef(model_out)[4]*x^2, 0, 50)
# first derivative: 
# 0.04100887 - 2*0.0007136*x
# set to zero, solve for x:
# x = 0.04100887/(2*0.0007136)
abline(v = 0.04100887/(2*0.0007136))


# 5. R task: Familiarize yourself with the "broom" package, available on CRAN. The following vignette should prove useful:
browseURL("https://cran.r-project.org/web/packages/broom/vignettes/broom.html")
# Once you have a basic idea about what the package does, try do apply it to some of the models in this script - for instance, to plot actual vs. fitted values, extract model fit statistics, etc.
