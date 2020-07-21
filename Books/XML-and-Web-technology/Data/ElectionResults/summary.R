getStateSummary =
function(state = "california",
         url = paste("http://elections.nytimes.com/2008/results/states/", state, ".html", sep = ""))
{
    doc = try(htmlParse(url, error = function(...){}))
    tbls = getNodeSet(doc, "//table")
    ids = gsub("-.*", "", sapply(tbls, xmlGetAttr, "id"))
    structure(lapply(tbls, readSummaryTable),
              names = ids)
}


readSummaryTable =
function(tbl)
{
   type = xmlGetAttr(tbl, "id")
   
   ans = t(xmlSApply(tbl[["tbody"]],
                     function(x) {
                          # only the first four columns of interst since shift from '04 typically not available.            
                       vals = sapply(xmlChildren(x)[names(x) == "td"], xmlValue)

                       # Have to deal also with when there is no contest and one person alone is standing.
                       if(length(grep("^house", type)) > 0 && length(vals) == 6)
                         vals = c(vals[1:4], "Other", "0", vals[5])
                         
                       else if(length(grep("^presidential", type)) > 0 && length(vals) ==  6)
                         vals = vals[-1]

                           # Now, we want to get rid of the % at the end
                        trim(gsub("%$", "", iconv(vals, "UTF-8", "", "")))
                     }))
   
   ans
 }
