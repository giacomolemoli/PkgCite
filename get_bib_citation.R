##### Function to export BibTeX citations for all loaded R packages #####
## library
library(utils)

## directory where to save the bibliography 
bib_dir <- ""  # insert your own

# Get all loaded namespaces
loaded_packages <- loadedNamespaces()

# Function to retrieve BibTeX citation for a package
get_bib_citation <- function(pkg) {
  tryCatch({
    # Get the citation object
    citation_info <- citation(pkg)
    # Convert to BibTeX format
    entry <- utils::toBibtex(citation_info)
    # add a label to the bib entry where missing
    entry <- gsub("\\{,", paste0("\\{", pkg, ","), entry)
    entry
  }, error = function(e) {
    # Handle cases where no citation is available
    message(sprintf("No citation found for package: %s", pkg))
    NULL
  })
}

## Retrieve the BibTeX citations for all loaded packages
refs <- lapply(loaded_packages, get_bib_citation) %>% unlist() 

## Export the bibliography
writeLines(refs, con = paste0(bib_dir, "software.bib"))
