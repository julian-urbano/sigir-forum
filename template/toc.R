# UPDATE THESE TWO
issue <- "December 2024, Volume 58 Number 2"
pdfpath <- "https://sigir.org/wp-content/uploads/2025/01/"

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
    cat(glue("<h1>SIGIR Forum\n{issue}</h1>"), "\n\n")
    cat("<h2>Table of Contents</h2>", "\n\n")
  }
  if(is.null(prev_pubtype) || prev_pubtype != the_pubtype) {
    prev_pubtype <- the_pubtype
    cat(glue("<h3>{pubtypes[[the_pubtype]]}</h3>"), "\n\n")
  }
  cat(glue('<a href="{pdfpath}{f}">{htmlEscape(the_title)}</a>\n   {htmlEscape(the_authors)}'), "\n\n")
}
