library(data.table)

args <- (commandArgs(trailingOnly = TRUE))
print(args)
if(interactive() == TRUE){
   theta <- 1.5
   x     <- 0.5   
} else{
   ID <- as.numeric( Sys.getenv("SLURM_ARRAY_TASK_ID") )
   params <- fread("PARAMS.csv")
   theta  <- params[ID, theta]
   x      <- params[ID, x]
}

Y <- dexp(x, rate = 1 / theta)

message(paste0("SLURM_ARRAY_TASK_ID is : ", ID))
message(paste0("Density of Exp(", round(theta, 3), ") distribution is ", Y))

Sys.sleep(10)

fwrite(data.table(density=Y), paste0("temp/", ID, ".csv"))
