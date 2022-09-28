library(data.table)

files <- list.files("temp", full.names = TRUE)
index <- list.files("temp")
data  <- rbindlist( lapply(files, fread) )
data[, ID := index]

fwrite(data, "final_results.csv")
