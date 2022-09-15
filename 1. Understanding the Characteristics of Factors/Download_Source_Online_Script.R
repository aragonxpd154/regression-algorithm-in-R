library(tidyverse)

temp <- tempfile()
FF_data <- "https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_5_Factors_2x3_CSV.zip"
download.file(FF_data, temp, quiet = TRUE)

FF_factors <- read_csv(unz(temp, "F-F_Research_Data_5_Factors_2x3.csv"), skip = 3)

head(FF_factors)
FF_factors$...1
