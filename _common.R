# Installation of packages if necessary
InstallPackages <- function(Packages) {
  InstallPackage <- function(Package) {
    if (!Package %in% installed.packages()[, 1]) {
      install.packages(Package, repos="https://cran.rstudio.com/")
    }
  }
  invisible(sapply(Packages, InstallPackage))
}

# Basic packages
InstallPackages(c("bookdown", "formatR", "kableExtra", "magick", "ragg"))

# Chunk font size hook: allows size='small' or any valid Latex font size in chunk options
def.chunk.hook  <- knitr::knit_hooks$get("chunk")
knitr::knit_hooks$set(chunk = function(x, options) {
  x <- def.chunk.hook(x, options)
  ifelse(options$size != "normalsize", paste0("\n \\", options$size,"\n\n", x, "\n\n \\normalsize"), x)
})

# Add necessary packages here
Packages <- c("compiler",  "doParallel", "foreach", "future", "future.apply", "gridExtra", "htmlwidgets",  "methods",  "testthat",  "usethis", "BiodiversityR", "vegan","dplyr", "tidyverse", "magrittr","here", "data.table", "ggplot2", "prettyR", "pastecs","ggpubr", "PerformanceAnalytics", "taxize", "FD", "vegetarian","adespatial", "adegraphics", "ade4", "readxl", "ggsci", "labdsv", "indicspecies", "kableExtra", "knitr", "mvpart","tinytex","bookdown","pandoc")

# Install them if necessary
InstallPackages(Packages)

# example R options set globally
knitr::opts_chunk$set(
  cache = TRUE,   # Cache chunk results
  echo = FALSE,     # Show/Hide R chunks
  warning = FALSE, # Show/Hide warnings
  # Figure alignment and size
  fig.align='center', out.width='80%', fig.asp=.75,
  # Graphic devices (ragg_png is better than standard png)
  dev = c("ragg_png", "pdf"),
  # Code chunk format
  tidy=TRUE, tidy.opts=list(blank=FALSE, width.cutoff=60),
  size="scriptsize", knitr.graphics.auto_pdf = TRUE
)
options(width=60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  )

# ggplot style
library("tidyverse")
theme_set(theme_bw())
theme_update(panel.background = element_rect(fill = "transparent", colour = NA),
             plot.background = element_rect(fill = "transparent", colour = NA))
knitr::opts_chunk$set(dev.args=list(bg="transparent"))

# Random seed
set.seed(973)

# Create packages.bib file to reference them as @R-package
knitr::write_bib(Packages, file="packages.bib")