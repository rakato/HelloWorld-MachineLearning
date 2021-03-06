
set.seed(123)
library(mlbench)
library(caret)
library(corrplot)
library(fastAdaboost)#for running Adaboost from Caret package

data(PimaIndiansDiabetes)

str(PimaIndiansDiabetes)
summary(PimaIndiansDiabetes)

# correlation matrix
corrmatrix <- cor(PimaIndiansDiabetes[,1:8])
# summarize correlation matrix
corrplot(corrmatrix)

#Control the computational nuances of the train function
control <- trainControl(method="repeatedcv", number=10, repeats=3)
#method=The resampling method
#number=Either the number of folds or number of resampling iterations
#repeats= For repeated k-fold cross-validation only: the number of complete sets of folds to compute


# train the model
#The default method for optimizing tuning parameters in train is to use a grid search
model <- train(diabetes~., data=PimaIndiansDiabetes, method="lvq", preProcess="scale", trControl=control)

#ROC Curve for variable importance
importance <- varImp(model, scale=FALSE)
importance


control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
results <- rfe(PimaIndiansDiabetes[,1:8], PimaIndiansDiabetes[,9], sizes=c(1:8), rfeControl=control)

results
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))


#run a number of algos on Pima Indians  dataset
#CART, LDA, SVM, kNN, Random Forest

#Control the computational nuances of the train function
control <- trainControl(method="repeatedcv", number=10, repeats=3)

set.seed(123)
# CART
#The default method for optimizing tuning parameters in train is to use a grid search
fit.cart <- train(diabetes~., data=PimaIndiansDiabetes, method="rpart", trControl=control)
# LDA
fit.lda <- train(diabetes~., data=PimaIndiansDiabetes, method="lda", trControl=control)
# SVM
fit.svm <- train(diabetes~., data=PimaIndiansDiabetes, method="svmRadial", trControl=control)
# kNN
fit.knn <- train(diabetes~., data=PimaIndiansDiabetes, method="knn", trControl=control)
# Random Forest
fit.rf <- train(diabetes~., data=PimaIndiansDiabetes, method="rf", trControl=control)
#Adaboost
fit.ada <- train(diabetes~., data=PimaIndiansDiabetes, method="adaboost", trControl=control)

#Stochastic Gradient Boosting
fit.gbm<- train(diabetes~., PimaIndiansDiabetes, method="gbm", trControl=control)

# collect resamples
results <- resamples(list(CART=fit.cart, LDA=fit.lda, SVM=fit.svm, KNN=fit.knn, RF=fit.rf, ADA=fit.ada))

#compare accuracy and kappa
summary(results)

#plot results
scales <- list(x=list(relation="free"), y=list(relation="free"))
#boxplots
bwplot(results, scales=scales)



#gbm with Sonar datset
library(gbm)
data("Sonar")
dataset<- Sonar
x<- dataset[,1:60] #using these variables
y<- dataset[,61] #solving for this variable

set.seed(123)
control<- trainControl(method="repeatedcv", number=10, repeats=3)
fit.gbmsonar<- train(Class~., Sonar, method="gbm", metric="Accuracy")

#plot accuracy vs boosting iterations and tree depth
plot(fit.gbmsonar, type=c("g","o"))



















