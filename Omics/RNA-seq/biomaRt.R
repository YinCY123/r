
#####################################
# 
# Learning biomaRt R package
# YinCY
# 2018/11/22
# yinchunyou@zju.edu.cn
#
#####################################

library(biomaRt)

##########################################
# Selecting a BioMart database and dataset
##########################################

# every analysis with biomaRt starts with selecting a  BioMart database to use.
# A first step is to check which BioMart web services are available. The function
# listMarts() will display all available BioMart web services.

listMarts()

# The useMart() function can now be used to connect to a specified BioMart database,
# this must be a valid name given by listMart().
?useMart
ensembl <- useMart(biomart = 'ensembl')
# ensembl <- useMart(biomart = 'ENSEMBL_MART_ENSEMBL') # this is euqal to the above.

# BioMart databases can contain several datasets, for Ensenmbl every species is a 
# different dataset. In a next step we look at which datasets are available in the 
# selected BioMart by using the function listDatasets()

listDatasets(ensembl)


# to select a dataset we can update the Mart object using the function useDataset()
?useDataset
ensembl <- useDataset(dataset = 'hsapiens_gene_ensembl', mart = ensembl, verbose = T)

# if the dataset one want to use is known in advance, we can select a BioMart database
# and dataset in one step:

ensembl <- useMart(biomart = 'ensembl', dataset = 'hsapiens_gene_ensembl')


################################
# How to build a biomaRt query
################################

?getBM
listFilters(ensembl)[1:5, ]

# Attributes define the values we are interested in to retrive. 
# For example we want to retrive the gene symbols or chromosomal coordinates. 
# the listAttributes() function dispalys all available attributes in the selected dataset.

attributes <- listAttributes(mart = ensembl)
attributes[1:5, ]
dim(attributes)


# The getBM() function is the main query function in biomaRt. It has four main arguments:

# 1-- attributes: is a vector of attributes that one wants to retrieve (the output od the query).
# 2-- filters : a vector of filters that one will use as input to the query.
# 3-- values : a vector of values for the filters. In case multiple filters are in use, the 
#              values argument requires a list of values where each position in the list 
#              correspondes to the position of the filters in the filters argument.
# 4-- mart : is an object of class Mart, which is created by the useMart() function.

# Note : for some frequently used queries to Ensembl, wrapper functions are available:
# getGene() and getSequence(). These functions call the getBM() function with hard coded
# filter and attribute names.

affyids <- c("202763_at","209310_s_at","207500_at")

getBM(attributes = c('affy_hg_u133_plus_2', 'entrezgene'),
      filters = 'affy_hg_u133_plus_2',
      values = affyids,
      mart = ensembl)

#################################################
# Searching for datasets, filters and attributes
#################################################

# The function listDatastes(), listAttributes() and listFilters() will return
# every available option for their respective types. 

# However, this can be unwieldy when the list of results is long, involving
# much scrolling to find the entry you are interested in.

# biomaRt also provides the functions searchDatasets(), searchAttributes() and
# searchFilters() which will try to find any entries matching a specific term or 
# pattern. For example, if we want to find the details of any datasets in our 
# ensembl mart that contain the term 'hsapiens' we could do the following:

searchDatasets(mart = ensembl, pattern = 'hsapiens')

# you can search in a similar fashion of find available attributes and filters that 
# you may be interested in.

searchAttributes(mart = ensembl, pattern = 'hgnc')

# For advanced use, note that the pattern argument takes a regular expression
# This means you can create more complex queries if required.

# for example, that we have the string ENST00000577249.1, which we known is an ensembl
# id of some kind, but we aren't sure what the appropriate filter term is.

searchFilters(mart = ensembl, pattern = 'ensembl.*id')


##################################
# Example of biomaRt queries
##################################

##################################################
# 1¡¢ Annotate a set of Affymetrix identifiers 
# with HUGO symbol and chromosomal locations of 
# corresponding genes
##################################################

affyids=c("202763_at","209310_s_at","207500_at")

getBM(attributes = c('affy_hg_u133_plus_2', 'hgnc_symbol', 'chromosome_name',
                     'start_position', 'end_position', 'band', 'strand', 'transcript_length'),
      filters = 'affy_hg_u133_plus_2',
      values = affyids,
      mart = ensembl)

##############################################################
# Annotate a set of entrezGene identifers with GO annotation
##############################################################

entrez <- c('673', '837')
goids <- getBM(attributes = c('entrezgene', 'go_id'),
               filters = 'entrezgene',
               values = entrez,
               mart = ensembl)
head(goids)


#########################################################################
# retrieve all HUGO gene symbols of gene that are located on chromosomes
# 17, 20, or Y and are associated with specific GO terms
#########################################################################

# to filter by more than one filters. the first element should be corresponds
# to the first filter and the second correspond to the second filter.

go <- c("GO:0051330","GO:0000080","GO:0000114","GO:0000082")
chrom <- c(17, 20, 'Y')
getBM(attributes = 'hgnc_symbol',
      filters = c('go', 'chromosome_name'),
      values = list(go, chrom),
      mart = ensembl)


#######################################################################
# Annotate set of identifiers with INTERPRO protein domain identifiers
#######################################################################

refseqids <- c("NM_005359","NM_000546")
ipro <- getBM(attributes = c('refseq_mrna', 'interpro', 'interpro_description'),
              filters = 'refseq_mrna',
              values = refseqids,
              mart = ensembl)
ipro


###################################################################
# select all affymetrix identifiers on the hgu133plus2 chip and 
# ensembl gene identifiers for genes located on chromosome 16
# between basepair 1100000 and 1250000
##################################################################

getBM(attributes = c('affy_hg_u133_plus_2','ensembl_gene_id'),
      filters = c('chromosome_name', 'start', 'end'),
      values = list(16, 1100000, 1250000),
      mart = ensembl)

################################################################
# Retrieve all entrezgene identifiers and HUGO gene symbols of 
# genes which have a "MAP kinase activity" GO term associated
################################################################

# The GO identifer for MAP kinase activity is GO:0004707.
getBM(attributes = c('entrezgene', 'hgnc_symbol'),
      filters = 'go',
      values = 'GO:0004707',
      mart = ensembl)

#########################################################
# Given a set of EntrezGene identifiers, retrieve 100bp
# upstream promoter sequences
#########################################################

# All sequence related queries to Ensembl are available through the 
# getSequence() wrapper function. getBM() can also be used directly to 
# retrieve sequences but this can get complicated so using getSequence 
# is recommended.

?getSequence

# the type argument in getSequence() can be thought of as the filter in 
# this query and uses the same input names given by listFilters().

entrez <- c('673', '7157', '837')
getSequence(id = entrez,
            type = 'entrezgene',
            seqType = 'coding_gene_flank',
            upstream = 100,
            mart = ensembl)

################################################################
# Retrieve all 5' UTR sequences of all genes that are located 
# on chromosome 3 between the positions 185514033 and 185535839
################################################################

utr5 <- getSequence(chromosome = 3,
                    start = 185514033,
                    end = 185535839,
                    type = 'entrezgene',
                    seqType = '5utr',
                    mart = ensembl)
utr5

###########################################################
# Retrive protein sequences for a given list of EntrezGene 
# identifiers
###########################################################

protein <- getSequence(id = c(100, 5728),
                       type = 'entrezgene',
                       seqType = 'peptide',
                       mart = ensembl)
protein
str(protein)

################################################################
# Retrieve known SNPs located on the human chromosome 8 between 
# position 148350 and 148612
################################################################

snpmart <- useMart(biomart = 'ENSEMBL_MART_SNP', dataset = 'hsapiens_snp')

getBM(attributes = c('refsnp_id', 'allele', 'chrom_start', 'chrom_strand'),
      filters = c('chr_name', 'start', 'end'),
      values = list(8, 148350, 148612),
      mart = snpmart)


############################################################
# Given the human gene TP53, retrive the human chromosomal
# location of this gene and also retrieve the chromosomal
# location and RefSeq id of its homolog in mouse
############################################################

# The getLDS() (Get Linked Dataset) function provides functionality to link 2 
# BioMart datasets which each other and construct a query over the two datasets.

# In Ensembl, linking two datasets translates to retrieving homology data across
# species.

# The usage of getLDS is very similar to getBM(). 

# The linked dataset is provided by a separate Mart object and one has to specify 
# filters and attributes for the linked dataset.

# Filters can eother be applied to both datasets or to one of the datasets.

# Use the listFilters and listAttributes functions on both Mart objects to 
# find the filters and attributes for each dataset.

# The attributes and filters of the linked dataset can be specified with the 
# attributesL and filtersL arguments.

human <- useMart(biomart = 'ensembl',
                 dataset = 'hsapiens_gene_ensembl')
mouse <- useMart(biomart = 'ensembl', 
                 dataset = 'mmusculus_gene_ensembl')

getLDS(attributes = c('hgnc_symbol', 'chromosome_name', 'start_position'),
       filters = 'hgnc_symbol',
       values = 'TP53',
       mart = human,
       attributesL = c('refseq_mrna', 'chromosome_name', 'start_position'),
       martL = mouse)

##############################################
# Using archived versions of Ensembl
#############################################

# biomaRt provides the fnction listEnsemblArchives() to view the available archives.
# This function takes no arguments and produces a table containing the names of the available 
# archived versions, the date they were first available, and URL where they can be accessed.

listEnsemblArchives()

listMarts(host = 'http://may2009.archive.ensembl.org')

ensembl54 <- useMart(host = 'http://may2009.archive.ensembl.org',
                     biomart = 'ENSEMBL_MART_ENSEMBL',
                     dataset = 'hsapiens_gene_ensembl')


###############################################
# Using a BioMart other than Ensembl
##############################################

listMarts(host = 'parasite.wormbase.org')

wormbase <- useMart(biomart = 'parasite_mart',
                    host = 'https://parasite.wormbase.org',
                    port = 443)

listDatasets(wormbase)

wormbase <- useDataset(mart = wormbase, dataset = 'wbps_gene')

head(listFilters(wormbase))
head(listAttributes(wormbase))

getBM(attributes = c('external_gene_id', 'wbps_transcript_id', 'transcript_biotype'),
      filters = 'gene_name',
      values = c('unc-26', 'his-33'),
      mart = wormbase)

listAttributes(wormbase)[1:20, 1, drop = F]

#############################################
# biomaRt helper functions
#############################################

# this section describes a set of biomaRt helper functions that can be used to 
# export FASTA format sequences, retrieve values for certain filters and exploring
# the available filters and attributes in a more systematic manner.

### exportFASTA

# The data frames obtained by the getSequence function can be exported to FASTA files using
# the exportFASTA()

### filterType()

# to make sure you got the type right you can use the function filterType() to investigate
# the type of the filter you want to use.

filterType(filter = 'with_affy_hg_u133_plus_2', mart = ensembl)

### filterOptions()

# some filters have a limited set of values that can be given to them. To known which values
# these are one can use the filterOptions() function to retrieve the predetermed values of the
# respective filter.

filterOptions(filter = 'biotype', mart = ensembl)

### Attribute pages

# For large BioMart databases, such as Ensembl, the number of attributes displayed by the 
# listAttributes() function can be very large. In BioMart databases, attributes are put 
# together in pages, such as sequences, features, homologs for Ensembl.

# An overview of the attributes pages present in the respective BioMart dataset can be 
# obtained with the attributePages() function.

pages <- attributePages(mart = ensembl)
str(pages)
class(pages)

head(listAttributes(mart = ensembl, page = 'structure'))


##############################
# Using select()
##############################

# select(), columns(), keytypes() and keys()

# you can use columns() to discover things that can be extracted from a Mart, and
# keytypes() to discover which things can be used as keys with select()

mart <- useMart(biomart = 'ensembl', dataset = 'hsapiens_gene_ensembl')
head(keytypes(mart))




