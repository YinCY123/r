combine_file <- function(files = files, header = T, addc = ids, ...){
  df = c()
  for(i in seq_along(files)){
    cur = read.csv(file = files[[i]], header = header)
    cur[, addc] = i
    df = rbind(df, cur)
  }
  df = df[, c("Slice", "Count", "Total.Area", "X.Area", "file")]
  return(df)
}