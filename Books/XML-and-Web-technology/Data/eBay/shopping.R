# http://open.api.ebay.com/shopping?callname=FindItems&responseencoding=XML&appid=YourAppIDHere&siteid=0&version=517&QueryKeywords=harry%20potter%20phoenix&MaxEntries=50

getForm("http://open.api.ebay.com/shopping", responseencoding = "XML",
   appid='UCDAVISS1IUSCQ7IP3158BKE848MZJ',
   siteid = 0,
   version = 517,
   QueryKeywords= "harry potter phoenix",
   MaxEntries = 50, .opts = list(verbose = TRUE))

