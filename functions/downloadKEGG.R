downloadKEGG <- function(pathway_id = pathway_id, 
                         type = type, 
                         dest = dest){
  require(KEGGREST)
  require(xml2)
  require(png)
  
  if(is.null(pathway_id)){
    message("please provide an pathway id.")
  }
  
  if(is.null(type)){
    message("please provide the type to download: image, kgml")
  }
  
  ob <- keggGet(dbentries = pathway_id, option = type)
  
  if(toupper(type) == "IMAGE"){
    writePNG(image = ob, target = paste(paste(dest, pathway_id, "/"), ".png", sep = ""))
  }
  
  if(toupper(type) == "KGML"){
    kgml <- xmlParse(file = ob)
    write_xml(x = kgml, 
              file = paste(paste(dest, pathway_id, ".kgml", sep = )), 
              options = "as_xml", 
              encoding = XML::getEncoding(kgml))
  }
}


http://rest.kegg.jp/get/mmu00020/kgml