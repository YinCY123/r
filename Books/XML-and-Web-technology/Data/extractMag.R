# need this in two steps so that the doc is not garbage collected
doc = xmlParse("merged_catalog.xml.gz"))
root = xmlRoot(doc)
kids = xmlChildren(root)

numEv = xmlSize(root)
mags = vector("numeric", length = numEv)

for(i in 1:numEV) { 
   mags[i] = xmlGetAttr(kids[[i]][[10]], "value", converter=as.numeric) 
}

# when issue an xpath expression on a node set - start with a "." (i.e. from here)

idx = vector("numeric", length = numEv)
# I don't know why this doesn't work
for(i in 1:numEv) {
  pars = root[[i]]["param", all = TRUE]
  for (j in seq(along = pars)) {
     nm =  xmlGetAttr(pars[[j]], "name") 
     if ("magnitude" == nm)  idx[i] = j 
  }
}

# I don't know why this doesn't work either
#for (i in 1:length(kids) ) {
#   k = xmlChildren(kids[[i]])
#   cat( which("magnitude" == sapply(k, xmlGetAttr, "name")) )
#} 
   

