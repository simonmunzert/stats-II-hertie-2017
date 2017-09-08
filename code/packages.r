
# install packages from CRAN
p_needed <- c("readr", # imports spreadsheet data
              "haven", # imports SPSS, Stata and SAS files
              "dplyr",  # provides neat functions for data frame manipulation
              "babynames", # US baby names provided by the SSA
              "nycflights13", # dataset on all 336776 flights departing from NYC in 2013
              "wooldridge" # datasets used in Wooldridg
)
packages <- rownames(installed.packages())
p_to_install <- p_needed[!(p_needed %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}
lapply(p_needed, require, character.only = TRUE)
