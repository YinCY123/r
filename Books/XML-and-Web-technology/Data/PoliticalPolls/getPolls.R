getAllPolls =
function(races = c(presidential = "index.html", house = "house.html", senate = "senate.html", governor = "governor.html"),
         base = "http://www.realclearpolitics.com/epolls/2008/latestpolls")
{
   structure(lapply(paste(base, races, sep = "/"), getPolls), names = names(races))
}

getPolls =
function(url = "http://www.realclearpolitics.com/epolls/2008/latestpolls/index.html",
          doc = XML:::htmlParse(url, error = function(...){}))
{
   # Get the rows from all of the tables in the <div id='table-[123]'>..
  rows = getNodeSet(doc, "//div[contains(@id, 'table-')]//table//tr")

  processRows(rows)
}


processRows =
  #
  #  This can work on the rows (tr nodes) of any individual table
  #  or the rows from several tables.
  #
function(rows)
{
    # find the rows which are results and not just the date
    # The date row for each group of polls  will have just one cell;
    # the results 4.
  i = sapply(rows, xmlSize) == 4  

    # Each group of polls (i.e. for a given date) has a header
    # line of Race,  Poll, Results, Spread.  These are <th> nodes
    # whereas the actual results are <td> nodes.  So find those
    # rows with all <td> nodes. Then get the contents of the cells
  data.rows = sapply(rows[i], function(x) all(names(x) == "td"))  
  polls  = t(sapply(rows[i][data.rows], 
                   function(r) xmlSApply(r, xmlValue)))

  colnames(polls) = c("Race", "Poll", "Results", "Spread")

     # Now turn these into a data frame by processing the strings
     # in Results of the form  Obama 48, McCain 48, Nader 2 and
     # create a column for each candidate mentioned in any of the polls.
  polls = as.data.frame(polls)
     # Separate the  candidate value, candidate value, ....
  els = strsplit(as.character(polls$Results), ",[ ]*")

      # Get the value and the candidate as the name of the vector.
  results =
     lapply(els, function(x) { 
               tmp = strsplit(x, " ")
               structure(sapply(tmp, `[`, 2), names = sapply(tmp, `[`, 1))
             })

      # Now go get the vectors of values for each candidate and put them
      # into the data frame.
  who = unique(unlist(lapply(results, names)))
  for(w in who)                
     polls[[w]] = as.numeric(sapply(results, `[`, w))
            
       # Drop the original Results
  polls = polls[,  !(names(polls) %in% c("Results", "Spread"))]

      # Next, convert the date for each group of polls into
      # a POSXIct and then repeat it for the number of polls
      # in that group.
  dates = strptime(sapply(rows[!i], xmlValue), "%A, %B %d")  
  reps = diff(c(which(!i), length(i) + 1)) - 2
  polls$date = rep(as.POSIXct(dates), reps)

  polls           
}
