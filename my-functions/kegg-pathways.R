KEGG_Pathways <- function(database, organism){
    require(KEGGREST)
    require(magrittr)
    path_name <- keggList(database = database, organism = organism)
    genes_with_pathway <- keggLink(target = database, source = organism)
    path_factor <- genes_with_pathway %>% as.factor()
    names(path_factor) <- NULL
    path_list <- split(genes_with_pathway, path_factor)
    path_list <- lapply(path_list, names) %>% lapply(gsub, pattern = paste(organism, ":", sep = ""), replacement = "")
    names(path_list) <- path_name[names(path_list)]
    return(path_list)
}