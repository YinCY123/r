# a helper function to identify the root principal points  
get_earliest_principal_node <- function(cds, time_bin = '130-170'){
    cell_ids = which(colData(cds)[, "embryo.time.bin"] == time_bin)
    
    closest_vertex <- cds@principal_graph_aux[["UMAP"]]$pr_graph_cell_proj_closest_vertex
    closest_vertex <- as.matrix(closest_vertex[colnames(cds), ]) # reorder the cell matrix by colnames(cds)
    root_pr_nodes <- igraph::V(principal_graph(cds)[["UMAP"]])$name[as.numeric(names(which.max(table(closest_vertex[cell_ids, ]))))]
    
    root_pr_nodes
}