
################################################
#
# RNA-seq analysis with limma, Glimma and edgeR
# YinCY
# 2018/8/29
# yinchunyou@zju.edu.cn
#
#################################################

library(limma)
library(Glimma)
library(edgeR)
library(dplyr)
################################################
#  Reading in count-data
################################################

serise <- read.table(file = 'GSE63310_series_matrix.txt', sep = '\t', 
                     skip = 29, header = FALSE, nrows = 2, stringsAsFactors = F)
class(serise)
cell_type <- serise[1, ]
cell_type <- unlist(cell_type)
cell_type <- cell_type[-1]
names(cell_type) <- NULL
cell_type <- cell_type[-c(3, 9)]
cell_type <- c('LP', 'ML', 'B', 'B', 'ML', 'LP', 'B', 'ML', 'LP')

filenames <- read.table(file = 'GSE63310_series_matrix.txt', sep = '\t', 
                        skip = 74, header = FALSE, nrows = 1, stringsAsFactors = F)
filenames <- unlist(filenames)
filenames <- filenames[-1]
filenames <- basename(filenames)
filenames <- filenames[-c(3,9)]


read.delim(file = paste('GSE63310_RAW/', filenames[1], sep = ''), nrow = 5)

x <- readDGE(files = filenames, columns = c(1, 3), path = 'GSE63310_RAW/')
class(x)
dim(x)
head(x$counts)

batch <- read.table(file = 'GSE63310_series_matrix.txt', sep = '\t', 
                        skip = 44, header = FALSE, nrows = 1, stringsAsFactors = F)
batch <- batch[-1]
batch <- unlist(batch)
batch <- batch[-c(3,9)]
names(batch) <- NULL
batch <- gsub(pattern = 'batch: ', replacement = '', x = batch)
batch
#################################################
#  Organising sample information
#################################################

samplenames <- filenames
samplenames <- gsub(pattern = '.txt.gz', replacement = '', x = samplenames)
colnames(x) <- samplenames


x$samples$group <- factor(cell_type)
x$samples$lane <- batch
x$samples


#######################################
# Organising gene annotations
#######################################

library(Mus.musculus)
geneid <- rownames(x)
head(geneid)

genes <- select(x = Mus.musculus, keys = geneid, columns = c('SYMBOL', 'TXCHROM'),
                keytype = 'ENTREZID')
head(genes)

genes <- genes[!duplicated(genes$ENTREZID),]

x$genes <- genes
x


########################################
#  Data pre-processing
#  transformations from the raw-scale
########################################

# For differential expression and related analyses, gene expression is rarely considered 
# at the level of raw counts since libraries sequenced at a greater depth will result in 
# higher counts.

# Rather, it is common practice to transform raw counts onto a scale that accounts for such 
# library size difference. Popular tranformations include counts per million (CPM),
# log2-counts per million (log-CPM), reads per kilobase of transcript per million (RPKM),
# and fragments per kilobase of transcript per million (FPKM).

cpm <- cpm(x)
lcpm <- cpm(x, log = TRUE)

############################################
# Removing genes that are lowly expressed
############################################

table(rowSums(x$counts == 0) == 9)

# genes must be expressed in at least one group (or in at least three samples across the 
# entire experiment) to be kept for downstream analysis.

# although any sensible value can be used as the expression cutoff, typically a CPM value 
# of 1 is used in our analyses as it separate expressed genes from unexpressed genes well
# for most datasets. 

# Here, a CPM value of 1 means that a gene is expressed if it has at least 20 counts in the 
# sample with lowest sequencing depth (20 million) or at least 76 counts in the sample with
# the greatest sequencing depth (76 million). If sequence reads are summarised by exons rather
# than genes and/or experiments have low sequencing depth, a lower CPM cutoff may be considered.

keep.exprs <- rowSums(cpm > 1) >= 3
x <- x[keep.exprs, , keep.lib.size = FALSE]
dim(x)

# Note that subsetting the entire DGEList-object removes both the counts as well as the associated
# gene information. Code to produce the figure is given below.

# plot filtered and unfiltered normalized data.

library(RColorBrewer)
col <- brewer.pal(nsamples, name = 'Paired')
nsamples <- ncol(x)
par(mfrow = c(1, 2))
plot(density(x$counts[, 1]), col = col[1], lwd = 2, ylim = c(0, 0.21), las = 1, main = 'A.raw data',
     xlab = 'counts')
abline(v = 0, lty = 3)
for(i in 2:nsamples){
  den = density(lcpm[, i])
  lines(den$x, den$y, col = col[i], lwd = 3)
}
legend('topright', legend = samplenames, text.col = col, bty = 'n')


lcpm <- cpm(x, log = TRUE)
plot(density(cpm[, 1]), col = col, lwd = 2, ylim = c(0, 0.21), las = 1,
     main = 'B. Filtered data', xlab = 'Log_cpm')
abline(v = 0, lty = 3)
for(i in 2:nsamples){
  den = density(lcpm[, i])
  lines(den$x, den$y, col = col[i], lwd = 2)
}
legend('topright', legend = samplenames, text.col = col, bty = 'n')


##############################################
# Normalising gene expression distributions
##############################################

# During the sample preparation or sequencing process, external factors that are not of 
# biological interest can affect the expression of individual samples.

# It is assumed that all samples should bave a similar range and distribution of expression
# values.

# normalization is required to ensure that the expression distributions of each samples are
# similar across the entire experiment.
display.brewer.all()
cols <- brewer.pal(n = ncol(cpm), name = 'Set3')
plot(density(lcpm[,1]), main = samplenames[1], col = cols[1], ylim = c(0,0.25))
for(i in 2:ncol(cpm)){
  den <- density(x = lcpm[, i])
  lines(den, main = samplenames[i], col = cols[i])
}

boxplot(x = lcpm)
abline(h = median(lcpm), lty = 2, lwd = 1, col = 'red')


# Nonetheless, normalisation by the method of trimmed mean of M-values(TMM) is performed
# using the calcNormFactores function in edgeR. The normalisation factors calculated here are
# used as a scaling factor for the library size. When working with DGEList-object, these
# normalisation factors are automatically stored in x$sample$norm.factors. 

x <- calcNormFactors(object = x, method = 'TMM')
x$samples$norm.factors

par(mar = c(9, 4, 2,2))
barplot(height = x$samples$norm.factors, ylim = c(0, 1.4),
        names.arg = samplenames, las = 2, cex.names = 0.7)
abline(h = mean(x$samples$norm.factors, lty = 2))

x2 <- x
x2$samples$norm.factors <- 1
x2$counts[, 1] <- ceiling(x2$counts[, 1]*0.05)
x2$counts[,2] <- x2$counts[,2] *5


par(mfrow = c(1,2))
lcpm <- cpm(x2, log = TRUE)
boxplot(x = x2$counts, las = 2, col = col, 
        main = 'A.example: unnormalised data', ylab = 'Log-cpm')

x2 <-calcNormFactors(object = x2)
lcpm <- cpm(x2, log = TRUE)
boxplot(x = lcpm, las = 2, main = 'B.example£ºNormalised data', ylab = 'L',col = col)

#######################################
#  Unsupervised clustering of sample
#######################################

lcpm <- cpm(x, log = TRUE)
par(mfrow = c(1,2))
group <- as.factor(cell_type)
cols <- brewer.pal(n = nlevels(group), name = 'Set1')
levels(group)
names(cols) <- levels(group)
plotMDS(x = lcpm, labels = group, col = cols[group], main = 'group factor')


names(cols) <- unique(x$samples$lane)
plotMDS(x = lcpm, labels = x$samples$lane, col = cols[x$samples$lane], main = 'lanes factor')

lanes <- unlist(x$samples$lane)
lanes <- trimWhiteSpace(lanes)
x$samples$lane <- lanes

lane <- batch
glMDSPlot(x = lcpm, labels = paste(group, lane, sep = "_"),
          groups = x$samples[, c(2, 5)], launch = TRUE)


###########################################
#  Differentials expression analysis
#  Creating a design matrix and contrasts
###########################################

design <- model.matrix(object = ~ 0 + group + lane)
colnames(design) <- gsub('group', '', colnames(design))

# For a given experiment, there are usually several equivalent ways to set up an 
# appropriate design matrix. For example, ~ + group + lane removes the intercept
# from the first factor, group, but an intercept remains in the second factor lane.

# Alternatively, ~group + lane could be used to keep the intercepts in both group
# and lane. Understanding how to intercept the coefficients estimated in a given 
# model is key here. We choose the first model for our analysis, as setting up model
# contrasts is more straight forward in the absence of an intercept for group.

# Contrasts for pairwise comparisons between cell populations are set up in limma 
# using the makeContrasts function.

cont_matrix <- makeContrasts(
  BvsLP <- B - LP,
  BvsML <- B - ML,
  LPvsML <- LP - ML,
  levels = colnames(design)
)
cont_matrix






