#Load data
Data<- read.csv(file = 'C:/Kwesi stuff/USM/PHD/2nd Semester/Dr. Zhang COS703/Assignments/Assignment 3/Book1.csv')
View(Data)
NewData=Data[,2:11]
View(NewData)
x=NewData[,1:9]
xl=NewData

#Normalize Newdata to [0,1] range
normalizedNewData = (x-min(x))/(max(x)-min(x))
tryy= (xl-min(xl))/(max(xl)-min(xl))

#adding class to normalizeddata
RealD=cbind(normalizedNewData, class=Data$class)

#Find hopskins statistic of normalized newdata with no class
library(clustertend)
Hopstati=hopkins(tryy, 682, byrow = F, header = F)
Hopstatis=hopkins(normalizedNewData, 682)
Hopstats=hopkins(normalizedNewData, 682, byrow = F, header = F)

#correct hops stats=0.273
Hopstatist=hopkins(RealD, nrow(RealD)-1)

#Finding Kmeans
set.seed(10)
KmD=kmeans(RealD,2)
library(cluster)
attributes(KmD)
KmD$size
KmD$cluster

#shows which cluster a patient belongs to(1 or 2/Benign or Malignant) or add cluster to normalized data
cmdata=cbind(RealD,cluster=KmD$cluster)

#graph to show which patient belongs to a certain cluster
clusplot(RealD,KmD$cluster,main="2D representation of clusters",color=TRUE,shade=TRUE,labels=2,lines=0)

#ehanced clustering to get nice plots
res.km <- eclust(RealD, "kmeans", k=2)
fviz_cluster(KmD,RealD, ellipse = TRUE)

#good visual
fviz_cluster(KmD,RealD,geom = "point", ellipse.type = "norm")

#Finding Kmedoids
Kmedoids <- pam(RealD, 2)
attributes(Kmedoids)
Kmedoids$size
print(Kmedoids)

#To get medoids
Kmedoids$medoids

#To add clustering to normalized data
NewMediods <- cbind(RealD, cluster = Kmedoids$cluster)

#To plot Kmedoids
fviz_cluster(Kmedoids,RealD,geom = "point", ellipse.type = "norm",palette = "jco", ggtheme = theme_minimal())

#external evaluation method to assess clustering quality for kmeans
library("fpc")

#change class label to 1 and 2 because cluster is based on 1 and 2
As=Data
As$class=factor(As$class,levels=c(2,4),labels=c(1,2))
write.csv(As,file="Data2.csv",row.names=FALSE)

#change new labels to numeric because cluster.start use numeric
T=as.numeric(As$class)

#Now calculate clustering of kmeans quality
#(Evm=cluster.stats(dist(normalizedNewData),T,KmD$cluster))
#(Evm$corrected.rand)
#(Evm$vi)
#for precision alpha=0 0.9254409
BCubed_metric(RealD$class,KmD$cluster,0)
#for recall alpha=1 0.9240627
BCubed_metric(RealD$class,KmD$cluster,1)

#Now calculate clustering of kmedoids quality
#for precision alpha=0 0.9254409
BCubed_metric(RealD$class,Kmedoids$clustering,0)
#for recall alpha=1 0.9240627
BCubed_metric(RealD$class`,Kmedoids$clustering,1)

#calculate silhouette coeffiecient for Kmeans
library(cluster)
sil=silhouette(KmD$cluster,dist(RealD))
fviz_silhouette(sil)

#calculate silhouette coeffiecient for Kmedoids


