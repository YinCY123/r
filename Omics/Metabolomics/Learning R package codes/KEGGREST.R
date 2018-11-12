
#########################################################
#
#   Learning KEGGREST R package
#   YinCY
#   2018/08/26
#   yinchunyou@zju.edu.cn
#
#########################################################

library(KEGGREST)
# The KEGG REST API is built on some simple operations:
# info, list, find, get, conv and link. The corresponding 
# R functions in KEGGREST are: keggInfo(), keggList(),
# keggGet(), keggConv() and keggLink().

###########################################
# Exploring KEGG Resources with keggList()
###########################################

# KEGG exposes a number of databases. To get an idea of
# what is available, run listDatabases()
?listDatabases
listDatabases()


# You can use these databases in futher queries. Note that 
# in many cases you can also use a three-letter KEGG organism
# code or "T number" (genome identifier) in the same place you
# would use one of these database names.


# You can obtain the list of organisms available in KEGG with 
# the keggList() function:
?keggList
org <- keggList(database = 'organism')
dim(org)
head(org)
# returns the list of KEGG organism with taxonomic classification

# From KEGGREST's point of view, you have asked KEGG to show
# you the number of every entry in the "organism" database.
# Therefore, the complete list of entities that can be queried 
# with KEGGREST cna be obtained as follows:
queryAble <- c(listDatabases(), org[,1], org[,2])
head(queryAble)

AllhumanKEGGPathways <- keggList(database = 'pathway', organism = 'hsa')
length(AllhumanKEGGPathways)
head(AllhumanKEGGPathways)
# returns the list of the entire human pathways.

AllHumanGenes <- keggList(database = 'hsa')
## AllHumanGenes <- keggList(database = 'To1oo1') ## same as above
length(AllHumanGenes)
head(AllHumanGenes)
# returns the entire list of human genes.

keggList(database = c('hsa:10458', 'ece:Z5100'))
# returns the list of a human gene and an E.coli gene

keggList(database = c('cpd:C01290', 'gl:G00092'))
## keggList(database = c('C01290+G00092')) ## same as above
# returns the list of a compound entry and a glycan entry


########################################
# Get specific enteries with keggGet()
########################################

# Once you have s list of specific KEGG identifiers, use keggGet()
# to get more information about them. Here we look up a human gene
# and an E.coli O157 gene.
?keggGet
query <- keggGet(dbentries = c('hsa:10458', 'ece:z5100'))
# Behind the scense, KEGGREST downloaded and parsed a KEGG flat file
length(query)
names(query[[1]])
query[[1]]$ENTRY
query[[1]]$DBLINKS


# keggGet() can also return amino acid sequences as AAstringSet objects
# (from the Biostrings package):
keggGet(dbentries = c('hsa:10458', "ece:Z5100"), option = 'aaseq')


library(png)
pathwayname <- names(AllhumanKEGGPathways)
pathwayname <- gsub(pattern = 'path:', x = pathwayname, replacement = '')

# download all human pathway image
dir.create(path = paste(getwd(), '/human pathways', sep = ""))
setwd(paste(getwd(), '/human pathways', sep = ''))
for(i in pathwayname){
    writePNG(image = keggGet(dbentries = i, option = 'image'), 
           target = paste(i, '.png', sep = ""))
}
setwd('F:/Ñ§Ï°±Ê¼Ç/R/Metabolomics')


## Note keggGet() can only return 10 results sets at once (this limitation 
# is on the server side). If you supply more than 10 inputs to keggGet(),
# KEGGREST will warn that only the first 10results will be returned.


#########################################
# Search by keywords with keggFind()
#########################################

# You can search for two separate keywords('shiga' and 'toxin' in this case):
head(keggFind(database = 'genes', query = c('shiga', 'toxin')))

# query the two words together
head(keggFind(database = 'genes', query = 'shiga toxin'))

# search by chemical formula (have the same chemical formula compounds)
head(keggFind(database = 'compound', query = 'C7H10O5', option = 'formula'))

# search for a chemical formula containing 'O5' and 'C7'
head(keggFind(database = 'compound', query = 'O5C7', option = 'formula'))

# search for compounds with exact mass
head(keggFind(database = 'compound', query = 60.06, option = 'exact_mass'))

# find the pathway of compounds how's molecular weight is 60.06
mol_60 <-keggLink(target = 'pathway', source = c('C01845', 'C05979'))
pathway_60 <- gsub(pattern = 'path:', replacement = '', x = mol_60)
writePNG(image = keggGet(dbentries = pathway_60, option = 'image'), 
         target = paste(pathway_60, '.png', sep = ''))

# search compounds in a range of weight
head(keggFind(database = 'compound', query = 300:310, option = 'mol_weight'))


########################################
# Convert identifiers with keggConv()
########################################

# Convert between KEGG identifies and outside identifies.
?keggConv
keggConv(target = 'ncbi-proteinid', source = c('hsa:10458', 'ece:Z5100'))

# convert ncbi gene id to kegg e.coli gene id
head(keggConv(target = 'eco', source = 'ncbi-geneid'))

# convert kegg e.coli gene id to ncbi gene id
head(keggConv(target = 'ncbi-geneid', source = 'eco'))

# convert kegg human gene id to ncbi gene id
hsageneid <- keggConv(target = 'ncbi-geneid', source = 'hsa')
head(hsageneid)


##########################################
# Link across databases with keggLink()
##########################################

# Find related entires by using database cross-reference.

# Most of the KEGGSOAP functions whose names started with 'get', for example
# get.pathways.by.genes(), can be replaced with the keggLink() function. Here
# we query all pathways for huamn.
?keggLink
head(keggLink(target = 'pathway', source = 'hsa'))


# You can also specify one or more genes (from multiple species)
keggLink(target = 'pathway', source = c('hsa:10458', 'ece:Z5100'))

# keggLink() can be used to do pathway enrichment analysis.






