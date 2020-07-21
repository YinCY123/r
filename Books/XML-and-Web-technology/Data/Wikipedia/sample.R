# The idea here is to sample from the very large wikipedia
# file and to take out just k pages.

library(XML)

if(TRUE) {
  # This determines which pages we sample. 
  # The number 170598 comes from grep'ing the XML file for <page>
 N = 50
 indices = sort(sample(1:170598, N))
} else {
 indices = 1:4
 N = length(indices)
}

count <- 0
numNodesProcessed = 0

assignNode =
function(node)
{
 file = paste("page", xmlValue(node[["id"]]), ".xml", sep = "")
 saveXML(node, file)
 cat("saved", file, "\n")
}
class(assignNode) = "SAXBranchFunction"

page = 
function(parser, name, attrs, ...)
{
  numNodesProcessed <<- numNodesProcessed + 1
  if(count == N) {
     cat("Stopping parser\n")
     xmlStopParser(parser)
  } else {
    if(numNodesProcessed %in% indices) {
       count <<- count + 1
          # return a branch function which causes xmlEventParse to 
          # collect up the node and then pass it to that function.
       return(assignNode)
    }
  }


  FALSE
}

class(page) = "XMLParserContextFunction"

b.page = 
function(parser, node)
{
  numNodesProcessed <<- numNodesProcessed + 1
  if(count == N) {
     cat("Stopping parser\n")
     xmlStopParser(parser)
  } else {
    if(numNodesProcessed %in% indices) {
       count <<- count + 1
          # return a branch function which causes xmlEventParse to 
          # collect up the node and then pass it to that function.
       assignNode(node)
    } else
     cat("skipping", numNodesProcessed, count, "\n")
  }

  FALSE
}
class(b.page) = "XMLParserContextFunction"

xmlEventParse("enwikisource-20080526-pages-meta-history.xml", 
               branches = list(page = b.page), saxVersion = 1L)


if(FALSE) {
# less direct, but more efficient
xmlEventParse("enwikisource-20080526-pages-meta-history.xml", 
               handlers = list(page = page), saxVersion = 2L)
}

# system.time(source("sample.R"))
