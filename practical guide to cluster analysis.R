##########################################
# 
# Practical Guide to cluster analysis in R
# YinCY
# 2018/12/10
# yinchunyou@zju.edu.cn
#
##########################################

##################################
# Part I
# Basics
# Chapter 1 
# Data Preparation and R package
##################################

data('USArrests')
df <- USArrests

df <- na.omit(df) # remove entries that contains missing values.

df.scale <- scale(df)
head(df.scale, 3)



##################################
# Chapter 3
# Clustering Distance Measures
##################################


#-----------------------------
# Distance matrix computation
#-----------------------------
set.seed(123)
ss <- sample(x = 1:50, size = 15)
df <- USArrests[ss, ]
df.scale <- scale(df)

# Euclidean distance
?dist
dist.eucl <- dist(x = df.scale, method = 'euclidean')
round(as.matrix(dist.eucl)[1:5, 1:5], 2)


#-------------------------------
# Visualizing distance matrices
#-------------------------------
library(factoextra)
?fviz_dist
cols <- brewer.pal(n = 3, name = 'Set1')
fviz_dist(dist.obj = dist.eucl, order = TRUE, show_labels = TRUE, lab_size = 8)


###############################
# Chapter 4
# K-Means Clustering
###############################

#-----------------------------------
# Computing k-means clustering in R
#-----------------------------------

data('USArrests')
df <- scale(USArrests)
head(df)

# estimating the optimal number ofclusters
library(factoextra)
fviz_nbclust(x = df, FUNcluster = kmeans, method = 'wss') +
  geom_vline(xintercept = 4, linetype = 2)


set.seed(123)
km.res <- stats::kmeans(x = df, centers = 4, nstart = 25)

print(km.res)

km.res$centers
 
# compute the mean of each variables by clusters using the original data
aggregate(x = USArrests, by = list(cluster = km.res$cluster), FUN = mean)

dd <- cbind(USArrests, cluster = km.res$cluster)
dd


# Visualizing k-means clusters
?fviz_cluster

fviz_cluster(object = km.res, 
             data = df,
             palette = brewer.pal(n = 4, name = 'Set1'),
             ellipse.type = 'confidence',
             star.plot = TRUE,
             ggtheme = theme_minimal())


##############################
# Chapter 5
# K-Medoids
##############################

data("USArrests")
df <- scale(USArrests)
head(df)


# estimating the optimal number of clusters
?fviz_nbclust
fviz_nbclust(x = df, 
             FUNcluster = pam,
             method = 'silhouette') +
  theme_classic()

?pam
pam.res <- pam(x = df,
               k = 2,
               diss = F,
               metric = 'euclidean')
print(pam.res)
pam.res$cluster

dd <- cbind(USArrests, cluster = pam.res$clustering)
dd


# visualizing PAM clusters
?fviz_cluster
fviz_cluster(object = pam.res,
             data = df,
             palette = brewer.pal(n = 3, name = 'Set1')[1:2],
             ellipse.type = 't',
             repel = T,
             ggtheme = theme_classic())



########################################
# Chapter 6
# CLARA - Clustering Large Applications
########################################

set.seed(1234)
df <- rbind(cbind(rnorm(200, 0, 8), rnorm(200, 0, 8)),
            cbind(rnorm(300, 50, 8), rnorm(300, 50, 8)),
            cbind(rnorm(200, 25, 10), rnorm(200, 25, 10)))
colnames(df) <- c('x', 'y')
rownames(df) <- paste('S', 1:nrow(df), sep = '')
head(df)

# estimating the optimal number of clusters
fviz_nbclust(x = df,
             FUNcluster = clara,
             method = 'silhouette') +
  theme_classic()

# computing CLARA
?clara
clara.res <- clara(x = df, 
                   k = 3, 
                   metric = 'euclidean', 
                   samples = 50, 
                   pamLike = TRUE)
print(clara.res)

dd <- cbind(df, cluster = clara.res$clustering)
head(dd)
clara.res$medoids

# visualizing CLARA clusters
fviz_cluster(object = clara.res,
             data = df,
             palette = brewer.pal(n = 3, name = 'Set1'),
             geom = 'point',
             ellipse.type = 't',
             pointsize = 1,
             ggtheme = theme_classic())


#####################################
# Part III
# Hierarchical Clustering
# Chapter 7
# Agglomerative Clustering
#####################################

data("USArrests")
df <- scale(USArrests)
head(df)

# similarity measures
res.dist <- stats::dist(x = df, method = 'euclidean')
# the function dist() computes the distance between the rows of a data matrix
# using the specified distance measure method.

as.matrix(res.dist)[1:6, 1:6]
res.hc <- hclust(d = res.dist, method = 'ward.D2')

library(RColorBrewer)
cols <- brewer.pal(n = 4, name = 'Set1')
?fviz_dend
fviz_dend(x = res.hc, cex = 0.5, 
          k = 4, k_colors = cols)

# The hight of the fusion, provided on the vertical axis, indicates the (dis)similarity/distance
# between two objects/clusters. 
# The higher the height of the fusion, the less similar the objects are. This height is known as 
# the cophenetic distance between the two objects.

#--------------------------
# verify the cluster tree
#--------------------------

# After linking the objects in a data set into a hierarchical cluster tree, you might want to 
# assess that the distances (i.e., heights) in the tree reflect the original distances 
# accurately.

# One way to measure how well the cluster tree generated by the hclust() function reflects 
# your data is to compute the correlation between the cophenetic distances and the original 
# distance data generated by the dist() function.

# The closer the value of the correlation coe?cient is to 1, the more accurately the clustering 
# solution reflects your data. Values above 0.75 are felt to be good. The "average" linkage 
# method appears to produce high values of this statistic. This may be one reason that it is so 
# popular.


# compute cophentic distance
?cophenetic
res.coph <- cophenetic(x = res.hc)

# Correlation between cophenetic distance and the original distance
cor(res.dist, res.coph)


res.hc2 <- hclust(d = res.dist, method = 'average')
fviz_dend(x = res.hc2, k = 4, cex = 0.5)
cor(res.dist, cophenetic(res.hc2))


#------------------------------------------
# Cut the dendrogram into different groups
#------------------------------------------

# One of the problems with hierarchical clustering is that, it does not tell us how many 
# clusters there are, or where to cut the dendrogram to form clusters.

# The R base function cutree() can be used to cut a tree, generated by the hclust() 
# function, into several groups either by specifying the desired number of groups or
# the cut height. It returns a vector containing the cluster number of each observation.

# cut tree into 4 groups
grp <- cutree(tree = res.hc, k = 4)
table(grp)

rownames(df)[grp == 1] # df order same as grp order

# the result of the cut can be visualized using fviz_dend()
?fviz_dend
fviz_dend(x = res.hc, k = 4, 
          cex = 0.5,
          k_colors = cols,
          color_labels_by_k = T,
          rect = T)

# Using the function fviz_cluster() [in factoextra], we can also visualize the result 
# in a scatter plot. Observations are represented by points in the plot, using principal
# components.

?fviz_cluster
fviz_cluster(object = list(data = df, cluster = grp),
             palette = cols,
             ellipse.type = 'convex',
             repel = T,
             show.clust.cent = F,
             ggtheme = theme_minimal())


#------------------------
# Cluster R package
#------------------------

# The R package cluster makes it easy to perform cluster analysis in R. It provides the 
# function agnes() and diana() for computing agglomerative and divisive clustering, 
# respectively. These functions perform all the necessary steps for you. You don't need 
# to execute the scale(), dist() and hclust() function separately.
library(cluster)
?agnes
res.agnes <- agnes(x = USArrests,
                   stand = T,
                   metric = 'euclidean', # distance
                   method = 'ward') # linkage
fviz_dend(x = res.agnes, k = 4, cex = 0.5)

?diana
res.diana <- cluster::diana(x = USArrests,
                            stand = T,
                            metric = 'euclidean') # metric for distance metrix
fviz_dend(x = res.diana,
          k = 4, cex = 0.5)


############################
# Chapter 8 
# Comparing Dendrogram
############################

df <- scale(USArrests)
set.seed(123)
ss <- sample(1:50, 10)
df <- df[ss, ]

library(dendextend)
res.dist <- dist(x = df, method = 'euclidean')

hc1 <- stats::hclust(d = res.dist, method = 'average')
hc2 <- stats::hclust(d = res.dist, method = 'ward.D2')

# create two dendrograms
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)

# create a list to hold dendrograms
dend_list <- dendlist(dend1, dend2)

# Visual comparision of two dendrograms

# The quality of the alignment of the two trees can be measured using the function 
# entanglement(). Entanglement is a measure between 1 (full entanglement) and 0 (no 
# entanglement). A lower entanglement coe?cient corresponds to a good alignment.
?tanglegram
tanglegram(dend1, dend2)

?tanglegram
tanglegram(dend1 = dend1, dend2 = dend2, sort = T,
           highlight_distinct_edges = F, # turn-off dashed lines
           common_subtrees_color_lines = F, # turn-off line colors
           common_subtrees_color_branches = T, # color common branches
           main = paste('entanglement =', round(entanglement(dend_list), digits = 2)))


#---------------------------------------------------
# Correlation matrix between a list of dendrograms
#---------------------------------------------------

# Cophenetic correlation matrix
cor.dendlist(dend = dend_list, method = 'cophenetic')

# Baker correlation matrix
cor.dendlist(dend = dend_list, method = 'baker')

# correlation between two trees
cor_cophenetic(dend1 = dend1, dend2 = dend2)

# baker correlation
cor_bakers_gamma(dend1, dend2)


# Create multiple dendrograms by chaining
dend1 <- df %>% dist %>% hclust(method = 'complete') %>% as.dendrogram
dend2 <- df %>% dist %>% hclust(method = 'single') %>% as.dendrogram
dend3 <- df %>% dist %>% hclust(method = 'average') %>% as.dendrogram
dend4 <- df %>% dist %>% hclust(method = 'centroid') %>% as.dendrogram


# compute correlation matrix
dend_list <- dendlist('complete' = dend1, 'single' = dend2,
                      'average' = dend3, 'centroid' = dend4)

cors <- cor.dendlist(dend_list)
round(cors, digits = 2)

library(corrplot)
?corrplot
corrplot(corr = cors, method = 'pie', type = 'lower')



##################################
# Chapter 9
# Visualizing Dendrograms
##################################

data("USArrests")
dd <- dist(scale(USArrests), method = 'euclidean')
hc <- hclust(d = dd, method = 'ward.D2')

fviz_dend(x = hc, cex = 0.5,
          main = 'Dendrogram - ward.D2',
          xlab = 'Objects',
          ylab = 'Distance',
          sub = '',
          horiz = T)


# cut the tree
fviz_dend(x = hc, k = 4,
          cex = 0.5,
          k_colors = brewer.pal(n = 4, name = 'Set1'),
          color_labels_by_k = T,
          rect = T,
          rect_border = brewer.pal(n = 4, name = 'Set1'),
          rect_fill = T)

fviz_dend(x = hc, k = 4,
          cex = 0.5,
          k_colors = brewer.pal(n = 4, name = 'Set1'),
          color_labels_by_k = T,  # color labs by group
          ggtheme = theme_grey()) # using ggtheme


fviz_dend(x = hc, cex = 0.5, k = 4,
          k_colors = 'jco',
          rect = T,
          rect_border = 'jco',
          rect_fill = T,
          rect_lty = 2,
          horiz = T)


fviz_dend(x = hc, cex = 0.5, k = 4,
          k_colors = 'jco',
          type = 'phylogenic',
          repel = TRUE)


fviz_dend(x = hc, cex = 0.5, k = 4,
          k_colors = 'jco',
          type = 'phylogenic',
          phylo_layout = 'layout.gem')


#-----------------------------------------
# Case of dendrogram with large data sets
#-----------------------------------------

# If you compute hierarchical clustering on a large data set, you might want to zoom 
# in the dendrogram or to plot only a subset of the dendrogram.


# zooming in the dendrogram
fviz_dend(x = hc, xlim = c(1,18.5), ylim = c(-2,8))


# plotting a sub-tree of dendrograms

# create a plot of the whole dendrogram, and extract the dendrogram data
dend_plot <- fviz_dend(x = hc, k = 4,
                       cex = 0.5,
                       k_colors = 'jco')
dend_data <- attr(x = dend_plot, which = 'dendrogram') # extract dendrogram data

# cut the dendrogram at height h = 10
?cut
dend_cut <- cut(x = dend_data, h = 10)

# visualize the truncated version containing two branches
fviz_dend(x = dend_cut$upper)

print(dend_plot)

# plot subtree 1
fviz_dend(x = dend_cut$lower[[1]], main = 'Subtree 1')

# plot subtree 2
fviz_dend(x = dend_cut$lower[[2]], main = 'Subtree 2')


fviz_dend(x = dend_cut$lower[[2]], type = 'circular')


#############################################
# Manipulating dendrograms using dendextend
#############################################

# The package dendextend provide functions for changing easily the appearance of
# a dendrogram and for comparing dendrograms.

data <- scale(USArrests)
dist.res <- dist(data)
hc <- hclust(d = dist.res, method = 'ward.D2')
dend <- as.dendrogram(hc)
plot(dend)

# chaining operate
library(dendextend)
dend <- USArrests %>% 
  scale() %>% 
  dist() %>% 
  hclust(method = 'ward.D2') %>% 
  fviz_dend(k = 4, 
            k_colors = 'jco',
            rect = T,
            rect_lty = 2,
            rect_fill = T,
            rect_border = 'jco')
print(dend)


#---------------------
# using set() function from dendextend package 
# to customize dendrograms
#---------------------

# example

# 1. create a customized dendrogram
mycols <- brewer.pal(n = 4, name = 'Set1')
dend <- as.dendrogram(hc) %>% 
  set(what = 'branches_lwd', value = 1) %>% 
  set(what = 'branches_k_color', value = mycols, k = 4) %>%  # color branches by group
  set(what = 'labels_colors', value = mycols, k = 4) %>%  # color labels by group
  set(what = 'labels_cex', value = 0.5)

# 2. create plot
fviz_dend(dend, horiz = T)



##################################
# Chapter 10
# Heatmap: Static and Interactive
##################################

# R base heatmap: stats::heatmap()
df <- scale(mtcars)
?stats::heatmap
heatmap(x = df, scale = 'column', hclustfun = hclust)

# using custom colors
?colorRampPalette
col <- colorRampPalette(colors = brewer.pal(n = 3, name = 'Set1'))(256)

heatmap(x = df, 
        scale = 'none',
        col = col,
        RowSideColors = rep(c('blue', 'pink'), each = 16),
        ColSideColors = c(rep('purple', 5), rep('orange', 6)))


# Enhanced heat maps: heatmap.2() [in gplot]

library(gplots)
?heatmap.2
gplots::heatmap.2(x = df, 
                  scale = 'none',
                  col = redgreen(n = 100),
                  trace = 'none',
                  density.info = 'density',
                  hclustfun = function(x) hclust(x, method = 'ward.D2'),
                  distfun = function(x) dist(x, method = 'euclidean'))
# the defualt linkage method is complete, using deferent linkage method ward.D2



# Pretty heat maps: pheatmap() [in pheatmap package]
library(pheatmap)
?pheatmap::pheatmap
annot_row <- data.frame(culster = rep(c('C1', 'C2', 'C3', 'C4'), each = c(8,7,12,5)))
pheatmap::pheatmap(mat = df, 
                   cutree_rows = 4,
                   scale = 'none',
                   clustering_method = 'ward.D2')


test = matrix(rnorm(200), 20, 10)
test[1:10, seq(1, 10, 2)] = test[1:10, seq(1, 10, 2)] + 3
test[11:20, seq(2, 10, 2)] = test[11:20, seq(2, 10, 2)] + 2
test[15:20, seq(2, 10, 2)] = test[15:20, seq(2, 10, 2)] + 4
colnames(test) = paste("Test", 1:10, sep = "")
rownames(test) = paste("Gene", 1:20, sep = "")


# so great number format in pheatmap!!!

pheatmap(test, display_numbers = T, 
         number_format = matrix(ifelse(test > 5 & test < 6, '%.1f', ''), nrow(test)))


pheatmap(mat = test,
         cluster_rows = T,
         legend_breaks = -1:4,
         legend_labels = c('0 ', '1e-4 ', '1e-3 ', '1e-2 ', '1e-1 ', '1 '))

pheatmap(mat = test,
         cellwidth = 30,
         cellheight = 24,
         main = 'Example heatmap')


pheatmap(mat = test,
         cellwidth = 15,
         cellheight = 12,
         fontsize = 8,
         filename = 'test.pdf')


# Interactive heat maps: d3heatmap()
library(d3heatmap)
?d3heatmap
d3heatmap(x = scale(mtcars), colors = redgreen(n = 30),
          k_row = 4, 
          k_col = 2)



#################################
# Part IV
# Cluster validation
# Chapter 11
# Assessing Clustering Tendency
#################################

# before applying any clustering method on your data, it's important to evaluate whether
# the data sets contains meaningful clusters or not. If yes, then how many clusters are 
# there. This process is defined as the assessing of clustering tendency or the feasibility
# of the clustering analysis.

# A big issue, in cluster analysis, is that clustering methods will return clusters even
# if the data does not contain any clusters. In other words, if you blindly apply a clustering
# method on a data set, it will divide the data into clusters because that is what it supposed
# to do.

library(factoextra) # for data visualization
library(clustertend) # for statistical assessment clustering tendency

head(iris, 3)
df <- iris[,-5]
random_df <- apply(X = df,
                   MARGIN = 2,
                   FUN = function(x){runif(length(x), min(x), max(x))})
random_df <- as.matrix(random_df)

df <- scale(df)
random_df <- scale(random_df)

# plot faithful data set
?fviz_pca_ind
fviz_pca_ind(X = prcomp(df),
             title = 'PCA - irirs data',
             habillage = iris$Species,
             palette = 'jco',
             legend = 'bottom',
             addEllipses = T)


# plot the random df
fviz_pca_ind(X = prcomp(random_df),
             title = 'PCA - Random data',
             geom = 'point',
             ggtheme = theme_classic(),
             legend = 'bottom')


km.res1 <- kmeans(x = df, centers = 3)
fviz_cluster(list(data = df, cluster = km.res1$cluster),
             ellipse.type = 'norm',
             geom = 'point',
             stand = F,
             palette = 'jco',
             ggtheme = theme_classic())


km.res2 <- kmeans(x = random_df, centers = 3)
fviz_cluster(object = list(data = random_df, cluster = km.res2$cluster),
             ellipse.type = 'norm',
             geom = 'point',
             stand = F,
             palette = 'jco',
             ggtheme = theme_classic())

fviz_dend(x = hclust(d = dist(random_df, method = 'manhattan')), 
          k = 3,
          k_colors = 'jco',
          as.ggplot = T,
          show_labels = F)


library(clustertend)
set.seed(123)
hopkins(data = df, n = nrow(df) - 1)

set.seed(123)
hopkins(random_df, n = nrow(random_df) - 1)


fviz_dist(dist.obj = dist(df), show_labels = F) + 
  labs(title = 'Iris data')


fviz_dist(dist.obj = dist(random_df), show_labels = F) +
  labs(title = 'Random data')


#############################################
# Chapter 12
# Determining the Optimal Number of Clusters
#############################################

library(factoextra)
library(NbClust)

df <- scale(USArrests)
head(df)

?fviz_nbclust
# elbow method
fviz_nbclust(x = df,
             FUNcluster = kmeans,
             method = 'wss') +
  geom_vline(xintercept = 4, linetype = 2) +
  labs(subtitle = 'Elbow method')

# Silhouette method
fviz_nbclust(x = df,
             FUNcluster = kmeans,
             method = 'silhouette') +
  labs(subtitle = 'Silhouette method')

# gap statistic
set.seed(123)
fviz_nbclust(x = df, 
             FUNcluster = kmeans,
             nstart = 25,
             method = 'gap_stat',
             nboot = 500) +
  labs(subtitle = 'Gap statistic method')


# NbClust() function: 30 indices for choosing
library(NbClust)
?NbClust
nb <- NbClust(data = df, 
              distance = 'euclidean',
              min.nc = 2,
              max.nc = 10, method = 'kmeans')

library(factoextra)
fviz_nbclust(x = nb)


########################################
# Chapter 13
# Cluster validation Statistics
########################################

# Silhouette coefficient
# The silhouette analysis measures how well an observation is clustered and it estimates
# the average distance between clusters.

# The silhouette plot displays a measure of how close each point in one cluster is to 
# points in the neighboring clusters.

library(factoextra) # for data visualization.
library(fpc) # for computing clustering validation statistics.
library(NbClust) # for determining the optimal number of clusters in the data set.

df <- iris[,-5]
df <- scale(df)

# k-means clustering
km.res <- eclust(x = df,
                 FUNcluster = 'kmeans',
                 k = 3, 
                 nstart = 25,
                 graph = F)

fviz_cluster(object = km.res,
             geom = 'point',
             ellipse.type = 'norm',
             palette = 'jco',
             ggtheme = theme_minimal())

# Hierarchical clustering
hc.res <- eclust(x = df,
                 FUNcluster = 'hclust',
                 k = 4,
                 hc_metric = 'euclidean',
                 hc_method = 'ward.D2',
                 graph = F)
fviz_dend(x = hc.res,
          show_labels = F,
          palette = 'jco',
          as.ggplot = T)


#----------------------
# Cluster validation
#----------------------

# Silhouette plot

fviz_silhouette(sil.obj = km.res,
                palette = 'jco',
                ggtheme = theme_classic())

silinfo <- km.res$silinfo
names(silinfo)
class(silinfo)
head(silinfo$widths)
silinfo$clus.avg.widths

# the size of each clusters
km.res$size

km.res$silinfo$widths[1:3,1:3]

#--------------------------------------------------------------
# Computing Dunn index and other cluster validation statistics
#--------------------------------------------------------------

library(fpc)

# Statistics for k-means clustering
km.stats <- cluster.stats(
  d = dist(df),
  km.res$cluster
)

# Dunn index
km.stats$dunn

#---------------------------------
# external clustering validation
#---------------------------------

table(iris$Species, km.res$cluster)

# It's possible too quantify the agrement between Species and k-means clusters using 
# either the corrected Rand index and Meila's VI provided as follow:

# Compute cluster stats

species <- as.numeric(iris$Species)
clust_stats <- cluster.stats(d = dist(df), clustering = species,
                             alt.clustering = km.res$cluster)

clust_stats$corrected.rand
clust_stats$vi

# The corrected Rand index provides a measure for assessing the similarity between
# two partitions, adjusted for chance. It range is -1 (no agreement) to 1
# (prefect agreement). Agreement between the specie types and the cluster solution
# is 0.62 using Rand index and 0.748 using Meila's VI.


# agreement between species and pam clusters
pam.res <- eclust(x = df, FUNcluster = 'pam', k = 3, graph = F)
table(iris$Species, pam.res$clustering)

cluster.stats(d = dist(scale(iris[,-5])), clustering = species,
              alt.clustering = pam.res$clustering)$vi

cluster.stats(d = dist(scale(iris[,-5])), clustering = species,
              alt.clustering = pam.res$clustering)$corrected.rand

# external clustering validation, can be used to select suitable clustering
# algorithm for a given data set.


##########################################
# Chapter 14
# Choosing the Best Clustering Algorithms
##########################################

library(clValid)

df <- iris[, -5]
clmethods <- c('hierarchical', 'kmeans', 'pam')
intern <- clValid(df, nClust = 2:6,
                     clMethods = clmethods,
                     validation = 'internal')
summary(intern)

# It can be seen that hierarchical cluster with two clusters performs the best
# in each case. Regardless of the clustering algrithm, the optimal number of 
# clusters seems to be two using the three measures.

# Stability measures
clmethods <- c('hierarchical', 'kmeans', 'pam')
stab <- clValid(obj = df, nClust = 2:6, clMethods = clmethods,
                validation = 'stability')
optimalScores(stab)


#################################################
# Chapter 15
# Computing P-value for Hierarchical Clustering
#################################################

library(pvclust)
data(lung)
set.seed(123)
ss <- sample(x = 1:73, size = 30)
df <- lung[, ss]
res.pv <- pvclust(data = df, 
                  method.dist = 'cor',
                  method.hclust = 'average',
                  nboot = 500)

# default plot
plot(res.pv, hang = -1, cex = 0.5)
?pvrect
pvrect(res.pv)

# extract the object from the significant clusters
pvpick(res.pv)

# parallel computation 
library(parallel)
?makeCluster
cl <- makeCluster(spec = 2, type = 'FORK')
res.pv <- parPvclust(cl, data = df, nboot = 1000)
?stopCluster


########################################
# Part V
# Advanced Clustering
# Chapter 16
# Hierarchical K-Means Clustering
########################################

# Algorithm
# 1-- Compute hierarchical clustering and cut the tree into k-clusters.
# 2-- Compute the center of each cluster
# 3-- Compute k-means by using the set of cluster centers as the initial cluster centers.

data("USArrests")
df <- USArrests
head(df)
df <- scale(df)

library(factoextra)
res.hk <- hkmeans(x = df, k = 4)
names(res.hk)

fviz_dend(x = res.hk, 
          cex = 0.6,
          palette = 'jco',
          rect = T,
          rect_border = 'jco',
          rect_fill = T)


# visualize the hkmeans final clusters
fviz_cluster(object = res.hk,
             data = df,
             palette = 'jco',
             repel = T,
             ggtheme = theme_classic())


#######################################
# Chapter 17
# Fuzzy Clustering
#######################################

library(cluster)
df <- scale(USArrests)
res.fanny <- cluster::fanny(x = df, k = 2)

# The different components can be extracted

# 1 membership coefficients
head(res.fanny$membership, 6)

# 2 Dunn's partition coefficient
res.fanny$coeff

# 3 observation groups
head(res.fanny$clustering)

library(factoextra)
?fviz_cluster
fviz_cluster(object = res.fanny,
             ellipse.type = 'norm',
             repel = T,
             palette = 'jco',
             ggtheme = theme_minimal(),
             legend = 'right')

# evaluate the goodness of clustering results.
fviz_silhouette(res.fanny,
                palette = 'jco',
                ggtheme = theme_minimal())


#####################################
# Chapter 18
# Model-Based Clustering
#####################################

# Load data
library(MASS)
data("geyser")

library(ggpubr)
?ggscatter
ggscatter(data = geyser,
          x = 'duration',
          y = 'waiting') + 
  geom_density2d() # add 2D density


library(mclust)
data("diabetes")
head(diabetes)

library(mclust)
df <- scale(diabetes[, -1])
mc <- Mclust(data = df) # model based clustering
summary(mc)

mc$modelName # optimal selected model
mc$G # optimal number of cluster
head(mc$z) # probality to belong to a given cluster

library(factoextra)

# BIC values uesed for choosing the number of clusters
fviz_mclust(object = mc,
            what = 'BIC',
            palette = 'jco')

# Classification: plot showing the clustering
fviz_mclust(object = mc,
            what = 'classification',
            geom = 'point',
            pointsize = 1.5, 
            palette = 'jco')

# Classification uncertainty
fviz_mclust(object = mc,
            what = 'uncertainty',
            palette = 'jco')
# large symbols indicate the more uncertain observation


###################################
# Chapter 19
# DBSCAN: Density-Based Clustering
###################################

# DBSCAN (Density-Based Spatial Clustering and Application with Noise),
# is a density-based clustering algrithm, which can be used to identify
# clusters of any shape in a data set containing noise and outliers.

library(factoextra)
data("multishapes")
df <- multishapes[, 1:2]
head(df)
head(multishapes)

set.seed(123)
km.res <- kmeans(x = df,
                 centers = 5, 
                 nstart = 25)

fviz_cluster(object = km.res,
             data = df,
             geom = 'point',
             ellipse = F,
             show.clust.cent = F,
             palette = 'jco',
             ggtheme = theme_classic())
# we can see that kmeans inaccurately identify the 5 clusters


data('multishapes')
df <- multishapes[, 1:2]

library(fpc)
set.seed(123)
# compute DBSCAN using fpc package
?dbscan
db <- fpc::dbscan(data = df,
                  eps = 0.15, 
                  MinPts = 5)
# plot DBSCAN results
library(factoextra)
fviz_cluster(object = db,
             data = df,
             stand = F,
             ellipse = F,
             show.clust.cent = F,
             geom = 'point',
             palette = 'jco',
             ggtheme = theme_classic())

#----------------------------------------------
# method for determining the optimal eps value
#----------------------------------------------

library(dbscan)
dbscan::kNNdistplot(df, k = 5)
abline(h = 0.15, lty = 2)



























