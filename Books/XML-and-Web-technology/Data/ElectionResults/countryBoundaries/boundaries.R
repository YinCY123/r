if(FALSE) {
url = "http://general-election-2008-data.googlecode.com/svn/trunk/json/shapes/"
doc = htmlParse(url)
links = as.character(grep("json$", unlist(xpathSApply(doc, "//a/@href")), value = TRUE))
}

readStateBoundaries =
function(id, relativeTo = url)
{
  u = paste(relativeTo, id, sep = "")
  txt = try( getURL(u) )
  if(inherits(txt, "try-error"))
     return(matrix(0, 0, 0))

  els = fromJSON(txt)

  structure(lapply(els$places[[1]],
                      function(x)
                             # Add NAs at the end so we can combine these into a single matrix
                             # for use with polygon.
                         matrix(c(unlist(x$shapes[[1]]$points), NA, NA), , 2, byrow = TRUE)),
             names = sapply(els$places[[1]], function(x) x$name))
}

names(links) = rep("", length(links))
i = match(tolower(state.abb), names(st))

st = lapply(links, readStateBoundaries)
names(st) = gsub(".json", "", links)
if( any(i <- sapply(st, is.null)))
  warning("failed for states ", paste(names(st)[i], collapse = ", "))

statePolygons = lapply(st, function(x) do.call("rbind", x))
allStateBoundaries = do.call("rbind", statePolygons)

#lower48States = seq(along = st)[ - match(c("hi", "ak", "congressional"), names(st)) ]
lower48StateBoundaries = do.call("rbind",
                                  statePolygons[!(names(statePolygons) %in% c("hi", "ak", "us", "pr", "congressional"))])


plot(lower48StateBoundaries, type = "n")
polygon(lower48StateBoundaries)

if(FALSE) {
  v = readStateBoundaries("ar.json")
  z = do.call("rbind", v)
}
