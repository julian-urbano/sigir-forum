# UPDATE THESE TWO
issue <- "June 2023, Volume 57 Number 1"
pdfpath <- "http://sigir.org/wp-content/uploads/2023/06/"

suppressWarnings(suppressMessages({
  library(glue)
  library(pdftools)
  library(htmltools)
}))

pubtypes <- list(`SIGIR NEWS` = "SIGIR News",
                 `KEYNOTE EXTENDED ABSTRACT` = "Keynote Extended Abstracts",
                 `PAPER` = "Papers",
                 `EVENT REPORT` = "Event Reports",
                 `OPINION PAPER` = "Opinion Papers",
                 `DISSERTATION ABSTRACT` = "Dissertation Abstracts")

prev_pubtype <- NULL
for(f in list.files(".", pattern = "p\\d+.pdf")) {
  m <- pdf_info(f)
  
  the_title <- m$keys$Title
  the_authors <- m$keys$Author
  the_pubtype <- m$keys$Subject
  if(the_title == "" || the_authors == "" || the_pubtype == "")
    stop(glue("No metadata in {f}"))
  
  if(is.null(prev_pubtype)) {
    cat(glue("<h1>{issue}</h1>"), "\n")
    cat("<h2>Table of Contents</h2>", "\n")
  }
  if(is.null(prev_pubtype) || prev_pubtype != the_pubtype) {
    prev_pubtype <- the_pubtype
    cat(glue("<h3>{pubtypes[[the_pubtype]]}</h3>"), "\n")
  }
  cat(glue('<p><a href="{pdfpath}{f}">{htmlEscape(the_title)}</a>\n   <br>{htmlEscape(the_authors)}</p>'), "\n")
}
