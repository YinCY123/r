library(Matrix)
library(fs)

read10x <- function(sample, rowname = NULL, ...){
    features_table <- read.table(file = dir_ls(path = sample, type = "file", regexp = "gene|feature"), 
                                 header = F, 
                                 sep = "\t")
    
    barcodes_table <- read.table(file = dir_ls(path = sample, type = "file", regexp = "barcode"), 
                                 header = F, 
                                 sep = "\t")
    
    counts_table <- readMM(file = dir_ls(path = sample, type = "file", regexp = "matrix|.mtx$"))
    
    # set rownames
    if(is.null(rowname)){
        rownames(counts_table) <- features_table[, 1, drop = TRUE]
    }
    
    if(is.integer(rowname)){
        if(rowname <= ncol(features_table)){
            rownames(counts_table) <- features_table[, rowname, drop = TRUE]
        }else{
            print("This column does not present. Please set a smaller number.")
        }
    }else{
        print("Only column index are accepted.")
    }
    
    # set colnames
    colnames(counts_table) <- barcodes_table[, 1, drop = TRUE]
    
    return(counts_table)
}
