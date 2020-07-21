trim = function(x)
          gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)

getStateLinks =
  #
  # This fetches the links for each of the states. The result is an vector
  # with the link and the names are the state names
function(url = "http://elections.nytimes.com/2008/results/president/map.html")
{
  dd = htmlParse(url)
  links = getNodeSet(dd, "//a[@href and starts-with(@id, 'nytint-state')]")
  ans = sapply(links, xmlGetAttr, "href")
  names(ans) = gsub(".*/(.*)\\.html", "\\1", ans)
  ans
}


getState =
function(state = "california",
         url = paste("http://elections.nytimes.com/2008/results/states/president/", state, ".html", sep = ""))
{
    # Alaska might fail.
  ind = try(htmlParse(url, error = function(...){}))
  if(inherits(ind, "try-error"))
    return(NULL)
           
  tbl = getNodeSet(ind, "//th[text() = 'County']/ancestor::table")[[1]]

  vals =
    xmlSApply(tbl[["tbody"]],
             function(row) {
               tds = xmlChildren(row)[names(row) == "td"]
               sapply( tds [c(1, 3, 5, 6)], function(cell) trim(xmlValue(cell[[1]])))
             })


    # Could well do all of the states in one go by stacking the
    # values on top of each other and then applying the gsub, etc. to
    # all of them in one go.
  tmp = t(vals)
  ans = as.data.frame(apply(tmp[, 2:3], 2, function(x) as.integer(gsub(",", "", x))))
    # Assumes they are always in the same order. We could check from the attributes
    # on the cell, but ....
  names(ans) = c("Obama", "McCain")
  ans$county = tmp[,1]
  ans$reporting = as.numeric(gsub("%", "", tmp[,4]))

  ans
}

       
getStates =
function(fun = getState)
{  
  stateNames = gsub(" ", "-", tolower(c(rownames(USArrests), "district of columbia")))
  states = lapply(stateNames, fun)
  names(states) = stateNames

  nas = !sapply(states, is.null)
  states = states[nas]
}




if(FALSE) {
   # Combine into a single data frame.
  allStates = do.call("rbind", states)
  allStates$state = rep(stateNames[nas], sapply(states, nrow))
}

if(FALSE) {
 plot(McCain ~ Obama, allStates, col = terrain.colors(49),
       xlim = c(0, max(allStates$Obama)),  ylim = c(0, max(allStates$Obama)))
 abline(a = 0, b = pi/4)
}
