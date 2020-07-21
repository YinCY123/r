getExitPoll =
function(state = "california",
         url = paste("http://elections.nytimes.com/2008/results/states/exitpolls/", state, ".html", sep = ""))
{
    # Read the document and throw away any reported errors
  doc = try(htmlParse(url, error = function(...){}))
  if(inherits(doc, "try-error"))
    return(NULL)

    #  Get the tables. There are 10 of them and all 10 have
    # information we want.  If we wanted to ensure they are all
    # relevant, check the class ans summary attributes
    #    class="nytint-results-table-acol" summary="Exit Polls."
  tables = getNodeSet(doc, "//table")

    # Now process each table, and get the topic from the caption.
  structure(lapply(tables, readTable),
            names = sapply(tables, function(x) xmlValue(x[["caption"]])))
}

readTable =
  # 
  # Turn the table in HTML into a 
  #
function(tbl, basic = FALSE)
{
  ans = t(xmlSApply(tbl[["tbody"]],
                     function(x) {
                          # only the first four columns of interst since shift from '04 typically not available.            
                       vals = sapply(xmlChildren(x)[names(x) == "td"][1:4], xmlValue)
                           # Now, we want to get rid of the % at the end
                       ans = gsub("%$", "", iconv(vals, "UTF-8", "ascii", ""))
                     }))

         # Create a data frame with number and the group as a factor.
  tmp = as.data.frame(lapply(c(1,3,4), function(i) as.numeric(ans[,i])))
  names(tmp) = c("% of Population", "Obama", "McCain")  
  tmp$Group = ans[,2]

  tmp
}
  


