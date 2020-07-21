k = map('county')
stateId = gsub(",.*$", "", k$names)
countyNames = tapply( gsub(".*,", "", k$names), stateId, function(x) x) 
