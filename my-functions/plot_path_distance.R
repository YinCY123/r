# this function is used to plot path and edges with certain distance 
plot_path_distance <- function(net, node_name, degree, node_color, edge_color){
    require(igraph)
    # find all path to a node
    all_path_to_node <- all_simple_paths(graph = net, from = V(net)$name == node_name, to = V(net))
    
    # select path with certain number of nodes, return an list object
    path_distance_of_degree <- all_path_to_node[lapply(all_path_to_node, length) == degree]
    
    # multiple nodes from 2 to degree - 1
    path_distance_nodes_multipled <- lapply(path_distance_of_degree, function(x){
        x <- names(x)
        c(x[1], rep(x[2:(degree - 1)], each = 2), x[degree])
    })
    
    # select edge ids  
    select_edges_ids <- lapply(path_distance_nodes_multipled, FUN = get.edge.ids, graph = net, directed = T)
    
    # select edges along nodes  
    selected_edges_list <- list()
    for(i in 1:length(select_edges_ids)){
        selected_edges_list[[i]] <- E(net)[select_edges_ids[[i]]]
    }
    
    # set edge colors 
    ecol <- rep("grey", ecount(net))
    for(i in 1:length(selected_edges_list)){
        ecol[E(net) %in% selected_edges_list[[i]]] <- edge_color
    }
    
    # set vertex color  
    vcol <- rep("grey", vcount(net))
    for(j in 1:length(path_distance_of_degree)){
        vcol[V(net)$name %in% path_distance_of_degree[[j]] %>% names()] <- "tomato"
    }
    
    # set node color for query node
    for(j in 1:length(path_distance_of_degree)){
        vcol[V(net)$name == node_name] <- node_color
    }
    
    # plot the net
    plot(net, 
         vertex.color = vcol, 
         edge.color = ecol, 
         edge.arrow.size = 0.4)
}