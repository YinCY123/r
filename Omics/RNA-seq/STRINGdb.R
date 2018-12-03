########################################
#
# Learning STRINGdb R package
# YinCY
# 2018/09/17
# yinchunyou@zju.edu.cn
#
########################################

library(STRINGdb)
# The STRING is a database of known and predicted protein-protein interactions. 
# The interactions include direct (pgysical) and indirect (functional) associations.

# The database contains information from numerous source, including experiment 
# repositories, computational prediction methods and public text collections. 
# Each interaction is associated with a combined confidence score that integrades 
# the various evidences.


# get the species table
?get_STRING_species
STRING_species <- get_STRING_species(version = '10', 
                                     species_name = NULL)
head(STRING_species)


# start instantiating the STRINGdb reference class.
# In the constructor of the class you can also define the STRING version
# to be used and a threshold for the combined scores of the interactions, 
# such that any interaction below that threshold is not loaded in the object.
# by default the score threshold is set to 400!

# Besides, if you specify a local directory to the parameter input-directory,
# all the database files will be downloaded into this directory and the package 
# can be used off-line. 

# Otheraise, the database files will be saved and cached in a temporary that
# will be cleaned automatically when the R session is closed.

?STRINGdb
string_db <- STRINGdb$new(version = '10',
                          species = 10090,
                          score_threshold = 0,
                          input_directory = paste(getwd(), '/STRINGdb data 10.0/mouse', sep = ''))

## The input_directory should be a full path. not the relative path compared to the working directory.

# for a better understanding of the package two other commands can be useful:
STRINGdb$methods() # to list all the methods available.

STRINGdb$help('get_graph') # to visualize their documentation.

data("diff_exp_example1")
head(diff_exp_example1)

# the function map adds an additional column with STRING identifers to the 
# dataframe that is passed as first parameter.

STRINGdb$help('map')
example1_mapped <- string_db$map(my_data_frame = diff_exp_example1, 
                                 my_data_frame_id_col_names = 'gene', 
                                 removeUnmappedRows = FALSE,
                                 quiet = FALSE)
head(example1_mapped, n = 50)
dim(example1_mapped)

unmapped_genes <- example1_mapped[which(is.na(example1_mapped$STRING_id)),]
dim(unmapped_genes)
head(unmapped_genes)

example1_mapped <- example1_mapped[!is.na(example1_mapped$STRING_id),]
dim(example1_mapped)
head(example1_mapped)

hits <- example1_mapped$STRING_id[1:200]
head(hits)
class(hits)

STRINGdb$help('plot_network')
string_db$plot_network(string_ids = hits,
                       required_score = 400,
                       add_link = FALSE)


#############################
### Payload mechanism
#############################

# This R library provides the ability to interact with the STRING payload mechanism.

# The payload appears as an additional colored 'halo' that starts from the border of
# the bubbles.

# This allows to color in green the genes that are down-regulated and in red the genes 
# that are up-regulated. 

## filter by p-value and add a color column. (green for down-regulated genes and red for 
## up-regulated genes)

STRINGdb$help('add_diff_exp_color')
example1_mapped_pval05 <- string_db$add_diff_exp_color(screen = subset(x = example1_mapped, pvalue < 0.05),
                                                       logFcColStr = 'logFC')
head(example1_mapped_pval05)


## post payload information to the STRING server
STRINGdb$help('post_payload')
payload_id <- string_db$post_payload(stringIds = example1_mapped_pval05$STRING_id,
                                     colors = example1_mapped_pval05$color)
head(payload_id)
class(payload_id)

## display a string network png with the 'halo'
STRINGdb$help('plot_network')
plot_with_payload <- string_db$plot_network(string_ids = hits,
                                            payload_id = payload_id,
                                            required_score = 400,
                                            add_link = FALSE,
                                            add_summary = TRUE)
                       

###############################
# Enrichment analysis
##############################

STRINGdb$methods()

# We provide a method to compute and visualize the enrichment in protein-protein 
# interactions along a sorted list of proteins.

# In the context of genome-wide screens, it can be useful to visualize the distribution
# of the enrichment in the resulting sorted list of genes.

# if the experiment was successful, and the top hits have protein-protein interactions, 
# you should see more enrichment at the begining of the list than at the end.

# Beside, you can slao use the enrichment graph to help you to define a threshold on the 
# number of proteins to consider (for example, if you see a strong enrichment up to position
# 600 on your list, this means that the signal is probaly sparesed cover the best 600 genes.)

## plot the enrichment for the best 1000 genes
STRINGdb$help('plot_ppi_enrichment')
string_db$plot_ppi_enrichment(string_ids = example1_mapped$STRING_id[1:1000],
                              title = 'PPI enrichment')

# We can also provide a method to compute the enrichment in Gene Ontology, KEGG pathway and 
# Interpro domains, similar to the 'enrichment' widget in our web-interface.

STRINGdb$help('get_enrichment')
enrichmentGO <- string_db$get_enrichment(string_ids = hits,
                                         category = 'Process',
                                         methodMT = 'fdr',
                                         iea = TRUE)
head(enrichmenGO)

enrichmentKEGG <- string_db$get_enrichment(string_ids = hits,
                                           category = 'KEGG',
                                           methodMT = 'fdr',
                                           iea = TRUE)
head(enrichmentKEGG)


# If you have performed your experiment on a predefined set of proteins, it is
# important to run the enrichment statistics (otheraise you would get a wrong p-value!)

# Hence, before to luanch the methods explained above, you should set the background:
backgroundV <- example1_mapped$STRING_id[1:2000] # as an example, we use the first 2000 genes
class(backgroundV)
head(backgroundV)

STRINGdb$help('set_background')
string_db$set_background(background_vector = backgroundV) 
# set the background genes

# you can also set the background when you instantiate the STRINGdb object:
string_db <- STRINGdb$new(score_threshold = 0, 
                          backgroundV = backgroundV,
                          species = 10090)

# to compare the enrichment of two or more lists of genes using heatmap to visualization

STRINGdb$help('enrichment_heatmap')
eh <- string_db$enrichment_heatmap(genesVectors = list(hits[1:100], hits[101:200]),
                                   vectorNames = list('list1', 'list2'),
                                   title = 'My Lists')


##########################
# Cluster analysis
##########################

# The iGraph package provides serveral clustering/community algorithms:'fastgreedy',
# 'walktrap', 'spinglass', 'edge.betweenness'. 

## get clusters
STRINGdb$help('get_clusters')
# returns a list of clusters of interacting proteins.
clusterList <- string_db$get_clusters(string_ids = example1_mapped$STRING_id[1:600],
                                      algorithm = 'fastgreedy')

class(clusterList)
length(clusterList)
head(clusterList[1])

## plot the first 4 clusters
STRINGdb$help('plot_network')
par(mfrow = c(2,2))
for(i in seq(1:4)){
  string_db$plot_network(string_ids = clusterList[[i]],
                         add_link = FALSE)
}


#################################
# Additional protein information
#################################

# you can get a table that contains all the proteins that are present in the STRING database.
# The protein table also include the name, the size and a short description of the proteins.

string_proteins <- string_db$get_proteins()
class(string_proteins)
head(string_proteins)

# the following section show how to query STRING with R on some specific proteins.
STRINGdb$help('mp')
# maps the gene identifers of the input vector to STRING identifers. Return a vector with STRING
# identifers of the maped proteins.
tp53 <- string_db$mp('tp53')
tp53

atm <- string_db$mp(protein_aliases = 'atm')
atm

# get the proteins that interact with your proteins.
STRINGdb$help('get_neighbors')
string_db$get_neighbors(string_ids = c(tp53,atm))


STRINGdb$help('get_interactions')
string_db$get_interactions(string_ids = c(tp53, atm))

# Using the get_pubmed_interactions method we can retrieve the pubmed identifiers of the
# articles that contain the name of both the proteins.
STRINGdb$help('get_pubmed_interaction')
string_db$get_pubmed_interaction(STRING_id_a = tp53, 
                                 STRING_id_b = atm)


# STRING also provides a way to get homologous proteins: in our database we store an 
# ALL-AGAINS-ALL blast alignment of all our 5 million proteins.

# The method 'get_homologs_besthits' can be used to get the best hits of your proteins 
# in all the >1000 STRING species (with the 'symbets' parameter you can limit the search 
# to the reciprocal_best_hits. This increase the confidence to get orthologs and not 
# paralogous proteins).

## get the reciprocal best hits of the following protein in all the STRING species.
STRINGdb$help('get_homologs_besthits')
best_hits_homologs <- string_db$get_homologs_besthits(string_ids = c(tp53, atm),
                                                      symbets = TRUE)
head(best_hits_homologs[order(best_hits_homologs$best_hit_bitscore, decreasing = TRUE),])                               


STRINGdb$help('get_homologs')
homologs <- string_db$get_homologs(string_ids = c(tp53,atm),
                                   target_species_id = 9606,
                                   bitscore_threshold = 60)

o <- order(homologs$bitscore, decreasing = TRUE)
head(homologs[o,])

#############################################
# Benchmarking protein-protein interactions
#############################################

# When a new methodology/algorithm to infer protein-protein interactions is developed,
# the outcome should be carfully benchmarked against a gold standard. hence, we suggest to 
# benchmark against the KEGG pathway database (or other high uqality pathway databases). 

data("interactions_example")
head(interactions_example)

STRINGdb$help('benchmark_ppi')
interaction_benchmark <- string_db$benchmark_ppi(interactions_dataframe = interactions_example,
                                                 pathwayType = 'KEGG',
                                                 max_homology_bitscore = 60,
                                                 precision_window = 400,
                                                 exclude_pathways = 'blacklist')


plot(interaction_benchmark$precision,
     ylim = c(0,1),
     type = 'l',
     xlim = c(0, 700),
     xlab = 'interactions',
     ylab = 'precision')

# we also provide a function to list the pathways to which the various TP interactions 
# belong

STRINGdb$help('benchmark_ppi_pathway_view')
interactions_pathway_view <- string_db$benchmark_ppi_pathway_view(benchmark_ppi_data_frame = interaction_benchmark,
                                                                  precision_threshold = 0)

head(interactions_pathway_view)









