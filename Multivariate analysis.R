

# -------- Principal Components Analysis
# The purpose of principal component analysis is to find the best
# low-dementional representation of the variation in a multivariate
# data set.
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
wine <- read.table(file = url, sep = ",")

standardisedconcentration <- as.data.frame(scale(wine[2:14]))
wine_pca <- prcomp(x = standardisedconcentration)

pcaSummary <- summary(wine_pca)

wine_pca$sdev
sum((wine_pca$sdev)^2)

# ---------- deciding how many pricipal components to retain
# using scree plot
screeplot(wine_pca, type = "lines")
# the most obvious change in slope in the screee plot occurs 
# at component 4, which is the 'elbow' of the scree plot.

# using Kaiser's criterion
(wine_pca$sdev)^2
# we should only retain principal components for which
# the variance is above 1 (when principal component analysis 
# was applied to standardised data).

# A thrid way to decide how many principal components to
# retain is to decide to keep the number of components 
# required to explain at least some minimum amount of the 
# total variance.

# For example, if it is important to explain at least 80% 
# of the variance, we would retain the first five principal
# components.


# --------- loading for the Principal Components
wine_pca$rotation[,1]
# This means that the first component is a linear combination 
# of the variables: -0.144*Z2 + 0.245*Z3 + 0.002*Z4 + 0.239*Z5
# -0.142*Z6 -0.395*Z7 - 0.423*Z8 + 0.299*Z9 - 0.313*Z10 + 0.089*Z11
# -0.29Z12 - 0.376*Z13 - 0.287*Z14

sum((wine_pca$rotation[, 1])^2)
# Note that the square of the loadings sum to 1


# similarly, we can obtain the loadings for the second principal
# component 
wine_pca$rotation[,2]
# this means that the second principal component is a linear 
# combination of the variables: 0.484*Z2 + 0.225*Z3 + 0.316*Z4 
# - 0.011*Z5 + 0.300*Z6 + 0.065*Z7 - 0.003*Z8 + 0.029*Z9 + 
# 0.039*Z10 + 0.530*Z11 - 0.279*Z12 - 0.164*Z13 + 0.365*Z14


# ---------- Scatterplots of the Principal components
plot(x = wine_pca$x[, 1], y = wine_pca$x[, 2], 
     pch = wine$V1, col = wine$V1, 
     xlab = paste('PC1:', pcaSummary$importance[2, 1]*100, '%'),
     ylab = paste('PC2:', pcaSummary$importance[2,2]*100, "%"))
legend('bottomleft', legend = levels(as.factor(wine$V1)), 
       pch = unique(wine$V1), col = unique(wine$V1),
       ncol = 1)
abline(h = 0, v = 0, lty = 2, col = 'black')


plot(x = wine_pca$x[, 1], y = wine_pca$x[,2],
     pch = wine$V1, col = wine$V1, xlab = 'PC1',
     ylab = 'PC2', main = 'Principal Components Analysis')
abline(v = 0, h = 0, type = 'l')


# ---------- Linear Discriminant Analysis
# The purpose of principal component analysis is to find 
# the best low-dimensional representation of the variation
# in a multivariate data set.


# 输入的数据相对于PCA来说可以标准化（每个样本的观察值减去
# 均值除以标准差）也可以不用标准化

library(MASS)
wine_lda <- lda(wine$V1 ~ wine$V2 + wine$V3 + wine$V4 + wine$V5 + 
                wine$V6 + wine$V7 + wine$V8 + wine$V9 + wine$V10 +
                wine$V11 + wine$V12 + wine$V13 + wine$V14  )
wine_lda


# ---------- separation achieved by the Discriminant Functions
wine_lda_values <- predict(wine_lda, wine)
wine_lda_values$x
(wine_lda$svd)^2

# ----------- A stacked Histogram of the LDA Values
ldahist(data = wine_lda_values$x[,1], g = wine$V1)


# ----------- Scatterplots of the Discriminant Functions
plot(x = wine_lda_values$x[,1], y = wine_lda_values$x[,2],
     pch = wine$V1, col = wine$V1, xlab = 'PC1:68.75%', 
     ylab = 'PC2:31.25%', 
     main = "Linear Discriminant Analysis")
abline(v = 0, h = 0, lwd = 0.5, col = 'black',
       lty = 2)


################################################################
#
#   第二遍学习
#
################################################################

# ------- reading multivariate analysis data into R
# This data contains 13 different chemicals concentrations in winne
# grown in the same region in Italy that are derived from different
# cultivars.

# the row represent pre sample, columns represent different chemical's
# concentration.(V1 represent different cultivars)

url <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data'
wine <- read.table(file = url, sep = ",")
head(wine)

library(car)
scatterplotMatrix(x = wine[2:6])

plot(x = wine$V4, y = wine$V5, pch = wine$V1,
     col = wine$V1, xlab = "V4", ylab = 'V5', main = "V5 ~ V4")
legend('topleft', legend = c("cultivar_1", "cultivar_2", 'cultivar_3'),
       pch = unique(wine$V1), col = unique(wine$V1))

cor(wine$V2, wine$V3)
minerva::mine(x = wine$V4, y = wine$V5)

# --------- PCA 
# The purpose of principal component analysis is to find
# the best low-dimentional of the variation in a multivariate 
# data set.
wine_standard <- as.data.frame(scale(wine[2:14]))
str(wine_standard)
wine_pca <- prcomp(wine_standard)
summary(wine_pca)
sum((wine_pca$sdev)^2)

# Deciding to retain how many Principal Components
screeplot(x = wine_pca, type = 'lines') 
(wine_pca$sdev)^2 >= 1 # 保留大于等于1的PC

# -------- loading pca plot
plot(x = wine_pca$x[,1], y = wine_pca$x[,2],
     pch = wine$V1, col = wine$V1,ylim = c(-4,4),
     xlab = 'PC1:36.2%', ylab = 'PC2:19.2%',
     main = 'Principal Components Analysis')
legend('topleft', legend = c('cultivar1', 'cultivar2', 'cultivar3'),
       pch = unique(wine$V1), col = unique(wine$V1), ncol = 3,
       cex = 0.7)
abline(v = 0, h = 0, lty = 2)


# ------------ analysis rna-seq data 0524
rna <- read.csv(file = '/home/yincy/Documents/R/RNA-seq/data/0524/nuron.csv',
                row.names = 1, header = T, stringsAsFactors = T)
rna <- t(rna)
rna_standard <- scale(rna)
rna_standard
rna_pca <- prcomp(x = rna_standard)
summary(rna_pca)
plot(x = rna_pca$x[,1], y = rna_pca$x[,2],
     xlab = 'PC1:40.7%', ylab = 'PC2:34.7%', pch = 16, col = "red")
text(x = rna_pca$x[,1], y = rna_pca$x[,2] + 0.12,
     labels = rownames(rna), cex = 0.9, xpd = TRUE)
abline(v = 0, h = 0)

#-----------------------------------------------------------

# -------- Linear Discriminant Analysis
# The purpose of principal component analysis is to find the 
# best low-demensional representation of the variation in a 
# multivariate data set.


# the purpose of linear discriminant analysis (LDA) is to find 
# the liear combinations of the original variables that gives
# the best possible separation between the groups in our data set.

library(MASS)
wine_lda <- lda(wine$V1 ~ wine$V2 + wine$V3 + wine$V4 + wine$V5
                + wine$V6 + wine$V7 + wine$V8 + wine$V9 + wine$V10
                + wine$V11 + wine$V12 + wine$V13 + wine$V14)
wine_lda$scaling
wine_lda
wine_lda_values <- predict(object = wine_lda, wine[2:14])

plot(x = wine_lda_values$x[,1], y = wine_lda_values$x[,2],
     xlab = 'PC1:68.8%', ylab = 'PC2:31.2%',
     pch = wine$V1, col = wine$V1,
     main = 'Linear Discriminate Analysis')
abline(v = 0, h = 0, lty = 2)
legend('top', legend = c('cultivar1', 'cultivar2', 'cultivar3'),
       pch = unique(wine$V1), col = unique(wine$V1),ncol = 3)









