Bit2Int <- function(x){
  require(stringr)
  len <- nchar(x)
  n <- as.integer(str_split(x, "")[[1]])
  ten <- vector(mode = "integer", length = len)
  for(i in seq_len(len)){
    if(n[[i]] == 1){
      ten[[i]] <- as.integer(1 * 2^(len + 1 - i))
    }else{
      ten[[i]] <- as.integer(0 * 2^(len + 1 - i))
    }
  }
  return(sum(ten))
}
