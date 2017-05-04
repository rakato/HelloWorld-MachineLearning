install.packages("faraway")
data(pima, package="faraway")

yn <- factor(pima$test) #change "yes" "no" to factor for prediction
fit <- glm(yn ~ diastolic + bmi, family=binomial, data=pima)#family=binomial for logistic
summary(fit)
confint(fit) # 95% CI for the coefficients

m <- glm(yn ~ bmi, family=binomial, data=pima)

pred <- data.frame(bmi=50.0)
predict(m, type="response", data=pred)
