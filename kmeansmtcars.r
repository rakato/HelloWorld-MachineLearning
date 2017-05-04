

#import mtcars dataset
data("mtcars")

#kmeans with "n" clusters
fit <- kmeans(mtcars, 3) # pick number of clusters, eg "3"

#apply the function "mean" to the dataframe
aggregate(mtcars, by=list(fit$cluster),FUN=mean)

#make dataframe
mtdf <- data.frame(mtcars, fit$cluster)

#plot clusters
plot(mtdf$fit.cluster )

#Distance Matrix and Dendrogram
d <- dist(mtdf, method = "euclidean") # distance matrix using euclidean
fit <- hclust(d, method="ward") 
plot(fit) # display dendogram
groups <- cutree(fit, k=3) 
# red borders around the "n" clusters 
rect.hclust(fit, k=3, border="red")

