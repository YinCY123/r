# find common sequencing primers form shanghai sheng gong

PrimerFinder <- function(primers_file, plasmid_file, ...){
  require(Biostrings)
  require(readxl)
  # load in common sequencing primers
  primers = read_xlsx(path = primers_file, sheet = 1)
  primers <- na.omit(primers)
  len_primers <- nchar(primers$Sequence)
  primer_set <- DNAStringSet(primers$Sequence)
  
  # load in plasmid sequence
  plasmid = read.table(file = plasmid_file)
  plasmid = as.character(plasmid)
  plasmid = DNAString(plasmid)
  
  # multiple alignment
  res = pairwiseAlignment(pattern = primer_set, subject = plasmid, type = "local")
  
  # number of matched nucleotide
  num_matches <- nmatch(res)
  
  # location of matched primers
  locs <- which(num_matchs == len_primers)
  
  # get perfectly matched primers
  return(primers$Name[locs])
}

