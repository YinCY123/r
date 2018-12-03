#############################################
#
# Learning edgeR package 
# YinCY
# 2018/09/27
# yinchunyou@zju.edu.cn
#
#############################################

library(edgeR)

############# edgeR workflow ################

# x <- read.delim("TableOfCounts.txt",row.names="Symbol")
# group <- factor(c(1,1,2,2))
# y <- DGEList(counts=x,group=group)
# y <- calcNormFactors(y)
# design <- model.matrix(~group)
# y <- estimateDisp(y,design)


# ## To perform quasi-likelihood F-tests:

# fit <- glmQLFit(y,design)
# qlf <- glmQLFTest(fit,coef=2)
# topTags(qlf)


# ##To perform likelihood ratio tests:

# fit <- glmFit(y,design)
# lrt <- glmLRT(fit,coef=2)
# topTags(lrt)

#############################################

# edgeR performs differential abundance analysis for pre-defined features.
# Although not strictly necessary, it usually desirable that these genomic
# features are non-overlapping. 

group <- factor(rep(c(1,2,3,4,5,6), each = 2))
x <- readDGE(files = paste('data/', filenames, sep = ''),
             columns = c(1,3),
             group = group,
             labels = srp045534$Comment..Sample_title.)
dim(x)
head(x$counts)
x$samples

keep <- rowSums(cpm(x)[, 1:6] > 2) >= 4 | rowSums(cpm(x)[, 7:12] > 2) >= 4
table(keep)

x <- x[keep, , keep.lib.size = FALSE]
dim(x)

head(x$counts)

library(org.Mm.eg.db)
keytypes(org.Mm.eg.db)
columns(org.Mm.eg.db)

genes <- select(x = org.Mm.eg.db,
                keys = rownames(x$counts),
                keytype = 'ENTREZID',
                columns = c('SYMBOL'))
head(genes)
x$genes <- genes

x <- x[!duplicated(x$genes$SYMBOL),]
x <- x[!duplicated(x$genes$ENTREZID),]
dim(x)

###################################
# Estimating dispersions (classic)
###################################

x <- estimateDisp(x) # estimate common dispersion and tagwise dispersion

x <- estimateCommonDisp(x) # estimate common dispersion

x <- estimateTagwiseDisp(x) # estimate tagwise dispersion

# note that common dispersion needs to be estimated before estimating
# tagwise dispersion if they are estimated separately.



#########################
# Testing for DE genes
#########################

# Once negative binomial models are fitted and dispersion estimates are obtained,
# we can proceed with testing procedures for detemining differential expression 
# using the exact test.

# the exact test is only applicable to experiments with a single factor.

et <- exactTest(object = x)
topTags(et)



#############################################
# estimating dispersions (glm functionality)
#############################################

# estimate common dispersion, trended dispersion and tagwise dispersions
x <- estimateDisp(y = x, design = model.matrix(~0 + group))

# estimate common dispersions
x <- estimateGLMCommonDisp(y = x, design = model.matrix( ~ 0 + group))

# estimate trend dispersions
x <- estimateGLMTrendedDisp(y = x, design = model.matrix( ~ 0 + group))

# estimate tagwise dispersions
x <- estimateGLMTagwiseDisp(y = x, design = model.matrix(~ 0 + group))

# note that we need to estimate either common dispersion or trended dispersion
# prior to the estimation of tagwise dispersion.


#######################
# Testing for DE genes
#######################

# For general experiments, once dispersion estimates are obtained and negative 
# binomail generalized linear models are fitted, we can proceed with testing 
# procedures for detemining differential expression using either quasi-likelihood
# (QL) F-test or likelihood ratio test.

# while the likelihood ratio test is more obvious choice for inferences with GLMs
# the QL F-test is preferred as it reflects the uncertainty in estimating the dispersion
# for each gene. It provides more robust and reliable error rate control when the number
# of replicates is small.

# The QL dispersion estimation and hypothesis testing can be done by using the 
# functions glmQLFit() and glmQLFTest().

fit <- glmQLFit(y = x, design = model.matrix(~ 0 + group))

# The fit has three parameters. The first is the baseline level of group 1. The second
# and third are the 2vs1 and 3vs1 differences.

# to compare 2 vs 1
qlf.2vs1 <- glmQLFTest(glmfit = fit, coef = 2)
topTags(qlf.2vs1)

# to compare 3 vs 1
qlf.3vs1 <- glmQLFTest(glmfit = fit, coef = 3)
topTags(qlf.3vs1)

# to compare 3 vs 2
qlf.3vs2 <- glmQLFTest(glmfit = fit, contrast = c(0, -1, 1))
topTags(qlf.3vs2)
# The contrast argument in this case requests a statistical test of the null 
# hypothesis that coefficient3 -- coefficient2 is euqal to zero.

# to find genes different between any of the three groups
qlf <- glmQLFTest(glmfit = fit, coef = 2:3)
topTags(qlf)

# apply the likelihood ratio test to the above example and  compare 2 vs 1
fit <- glmFit(y = x, design = model.matrix(~ 0 + group))
lrt.2vs1 <- glmLRT(glmfit = fit, coef = 1)
topTags(lrt.2vs1)


########################################################
# Differential expression above a fold-change threshold
########################################################

fit <- glmQLFit(y = x, design = model.matrix(~ 0 + group))
tr <- glmTreat(glmfit = fit, coef = 2, lfc = 1)
topTags(tr)

# In the presence of a huge number of DE genes, a relatively large fold change
# threshold may be appropriate to narrow down the search to genes of interest.
# In the lack of DE genes, on the other hand, a small or even no fold-change
# threshold shall be used.

# the DE genes should be less than half of the total detected genes.

##########################################
# Gene ontology (GO) and pathway analysis
##########################################

qlf <- glmQLFTest(glmfit = fit, coef = 2)

go <- goana(de = qlf, species = "Mm")
topGO(go, sort = 'up')

keg <- kegga(de = qlf, species = 'Mm')
topKEGG(keg, sort = 'up')


#########################
# Gene set testing
#########################

# In addition to the GO and pathway analysis, edgeR offers different types of gene set
# tests for RNA-Seq data.

# 1-- roast() function performs ROAST gene set tests. It is a self-contained gene set
#    test. Given a gene set, it tests whether the majority of the genes in the set
#    are DE across the comparison of interest.

# 2-- mroast() function does ROAST tests for multiple sets, including adjustment for 
#     multiple testing.

# 3-- fry() function is a fast version of mroast(). It assumes all the genes in a set 
#     have equal variances. Since edgeR uses the z-score equivalents of NB random 
#     deviates for the gene set tests, the above assumption is always met. Hence, fry()
#     is recommended over roast() and mroast() in edgeR. It gives the same result as 
#     mroast() with an infinite number of rotations.

# 4-- camera() function performs a competitive gene set test accounting for inter-gene 
#     corrrelation. It tests whether a set of genes is highly ranked relative to other 
#     genes in terms of differential expression.

# 5-- romer() function performs a gene set enrichment analysis. It implements a GSEA 
#     approach based on rotation instead of permutation.


###########################
# Clustering, heatmaps etc
###########################

x <- calcNormFactors(object = x, method = 'TMM')
logcpm <- cpm(y = x, prior.count = 2, log = TRUE)
head(logcpm)
x$samples


###########################
# Alternative splicing
###########################

# Alternative splicing events are detected by testing for differential exon usage 
# for each gene, that is testing whether the log-fold-changes differ between exons for 
# the same gene.

# Both exon-level and gene-level tests can be performed simultaneously using the 
# diffSpliceDGE() function.
?diffSpliceDGE
?topSpliceDGE


#################################
# Specific experimental designs
#################################


et <- exactTest(object = x, pair = c(1,2))
topTags(et)


x2 <- x
x2$samples$group <- relevel(x = x$samples$group, ref = 6)
x2$samples$group

# When pair is not specified, the default is to compare the first two group levels

#####################
# GLM approach
#####################

design <- model.matrix(object = ~ 0 + group, data = x$samples)
design

# One can compare any of the treatment groups using the contrast argument of the 
# glmQLFTest or glmLRT function.

fit <- glmQLFit(y = x, design)
qlf <- glmQLFTest(glmfit = fit, contrast = c(0, 0, 1, 0, 0, -1))
topTags(qlf)

# The contrast vector can be contructed using makeContrasts() function 

BvsL <- makeContrasts(g3.g6 = group3-group6,
                        g1.g4 = group1-group4,
                        g2.g5 = group2-group5,
                        levels = design)

BvsL

qlf <- glmQLFTest(glmfit = fit, contrast = BvsL[, 'g1.g4'])
topTags(qlf)

# the result it equals to the above

# Any compare can be made 

my.contrast <- makeContrasts((group2+group3) - (group5+group6),
                             levels = design)
qlf <- glmQLFTest(glmfit = fit, contrast = my.contrast)
topTags(qlf)



#########################################
# An ANOVA-like test for any differences
#########################################

qlf <- glmQLFTest(glmfit = fit, coef = 2:3)
topTags(qlf)

# Technically, this procedure tests whether either of the contrasts B-A
# or C-A are non-zero. Since at least one of these must br non-zero when 
# differences exist, the test will detect any differences. 
# To do this effect, the coef argument should specify all the coefficents
# except the intercept.


########################################################
# Experiments with all combinations of multiple factors
########################################################

targets <- data.frame(row.names = paste(rep('Sample', times = 12), 1:12, sep = ''),
                      Treat = rep(c('Placebo', 'Drug'), each = 6),
                      Time = rep(rep(c('0h', '1h', '2h'),each = 2), time = 2))

Group <- factor(paste(targets$Treat, targets$Time, sep = '.'))

targets <- cbind(targets, Group=Group)

design <- model.matrix(~0+Group)
colnames(design) <- levels(Group)
design

fit <- glmQLFit(y = x, design = design)

my.Contrast <- makeContrasts(
  Drug.1vs0 = Drug.1h - Drug.0h,
  Drug.2vs0 = Drug.2h - Drug.0h,
  Placebo.1vs0 = Placebo.1h - Placebo.0h,
  Placebo.2vs0 = Placebo.2h - Placebo.0h,
  DrugvsPlacebo.0h = Drug.0h - Placebo.0h,
  DrugvsPlacebo.1h = (Drug.1h - Drug.0h) - (Placebo.1h - Placebo.0h),
  DrugvsPlacebo.2h = (Drug.2h - Drug.0h) - (Placebo.2h - Placebo.0h),
  levels = design
)

# find genes responding to the drug at 1 hour.
qlf <- glmQLFTest(glmfit = fit, contrast = my.Contrast[, 'Drug.1vs0'])
topTags(qlf)

# find genes responding to the drug at 2 hour.
qlf <- glmQLFTest(glmfit = fit,
                  contrast = my.Contrast[, 'Drug.2vs0'])
topTags(qlf)


# to find genes with baseline differences between the drug and the placebo at 0h
qlf <- glmQLFTest(glmfit = fit, contrast = my.Contrast[, 'DrugvsPlacebo.0h'])
topTags(qlf)

# To find genes that have responded differently to the drug and the placebo at 2h
qlf <- glmQLFTest(glmfit = fit, contrast = my.Contrast[, 'DrugvsPlacebo.2h'])
topTags(qlf)

colnames(fit)
# find genes differencetly expressed at Drug 2h and 0h
qlf <- glmQLFTest(glmfit = fit, contrast = c(-1, 0, 1, 0, 0, 0))
topTags(qlf)

# genes differently expressed in DrugvsPlacebo.2h
qlf <- glmQLFTest(glmfit = fit, contrast = c(-1,0,1,1,0,-1)) # ÅªÇå³þÕý¸ººÅ
topTags(qlf)


##############################
# Nested interaction formulas
##############################

targets$Treat <- relevel(targets$Treat, ref = 'Placebo')
targets$Treat

design <- model.matrix(~Treat + Treat:Time, data = targets)
fit <- glmQLFit(y = x, design = design)
# The meaning of this formula is to consider all the levels of time for each 
# treatment drug separately.

# The second term is a nested interaction, the interaction of time within Treat.
# the coefficient names are:
colnames(fit)

# Now most of the above contrasts are directly available as coefficients
qlf <- glmQLFTest(glmfit = fit, coef = 2) # baseline drug vs placebo comparison

qlf <- glmQLFTest(glmfit = fit, coef = 4) # the drug effect at 1 hour

qlf <- glmQLFTest(glmfit = fit, coef = 6) # the drug effect at 2 hour
topTags(qlf)

qlf <- glmQLFTest(glmfit = fit, coef = 5)
topTags(qlf)

qlf <- glmQLFTest(glmfit = fit, contrast = c(0,0,0,0,-1,1)) # the DrugvsPlacebo.2h contrast
topTags(qlf)


# The nested interaction model makes it easy to find genes that respond to the treatment
# at any time, in a single test. 

qlf <- glmQLFTest(glmfit = fit, coef = c(4,6))
topTags(qlf)
# find genes that respond to the treatment at either 1 hour or 2 hour versus the 
# 0 hour baseline. 
# This is analogous to an ANOVA F-test for a normal linear model.

design <- model.matrix(~Treat*Time, data = targets)
design
# which is equal to 
design <- model.matrix(~Treat + Time + Treat:Time, data = targets)
design

colnames(design)

qlf <- glmQLFTest(glmfit = fit, coef = 2)
topTags(qlf)


####################################
# Additive models and blocking 
####################################

Subject <- factor(rep(c(rep(c(1,2,3), each = 2)),time = 2))
Subject

targets$Subject <- Subject
targets

Treat <- factor(rep(c('C', 'T'), each = 6), levels = c('C', 'T'))
Treat

design <- model.matrix(~ Subject + Treat)
design

x <- estimateDisp(y = x, design = design)
plotMD(object = x, column = 7)
abline(h = 0, col = 'red', lwd = 2, lty = 2)


fit <- glmQLFit(y = x, design = design)
qlf <- glmQLFTest(glmfit = fit)
topTags(qlf)

# This test detects genes that are differently expressed in response to the active treatment
# compared to the control, adjusting for baseline differences between the patients. 
# This test can be viewed as a generalization of a paired t-test.

litter <- factor(rep(c(1,2,3), each = 3))
Treatment <- factor(c('A', 'B', 'C', 'B', 'C', 'A', 'C', 'B', 'A'))

design <- model.matrix(~litter + Treatment)
design
dim(design)

qlf <- glmQLFTest(glmfit = fit, coef = 4)
topTags(qlf)
# detect genes that are differentially expressed in Treatment B vs treatment A

qlf <- glmQLFTest(glmfit = fit, coef = 4)
topTags(qlf)

Disease = factor(rep(c('Healthy', 'Disease1', 'Disease2'), each = 6), 
                 levels = c('Healthy', 'Disease1', 'Disease2'))

Patient = gl(n = 3, k = 2, length = 18)

Treatment = factor(rep(c('None', 'Hormone'), times = 9), 
                   levels = c('None', 'Hormone'))
# the reference should put in the first level!!!

targets <- data.frame(Disease, Patient, Treatment)
targets

design <- model.matrix(~ Disease + Disease:Patient + Disease:Treatment)
colnames(design)



