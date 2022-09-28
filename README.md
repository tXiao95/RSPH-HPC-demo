# SPENSER Demo for RSPH HPC

This repo contains a small demo demonstrating use of the RSPH HPC cluster. Serial jobs and job arrays are covered, as well as encoding job dependencies.

## How to launch

Once logged in to the RSPH HPC, just run the following 

```bash
./launch_script.sh
```

## Overview of code 
The goal of this code is to evaluate the density of 10 different values under 10 different exponential distributions in parallel, and combine the final result in a one data frame.

To start the code is designed to run 10 jobs in parallel. The arguments for each job are read from `PARAMS.csv` corresponding to the job ID. Each job takes in two arguments: `theta` and `x`. `theta` corresponds to the rate parameter of an exponential distribution and `x` is a value in the support that the script will generate the density for. 

The output of each job is the value of `dexp(x, 1 / theta)`. The job then writes the numeric value to a data.table under the column name `density`, and saves the 1x1 table to a `.csv` in the directory `temp`. The file is named by its `SLURM_ARRAY_TASK_ID`. For example, the job corresponding to task ID 1 will be saved to `1.csv`. 

Finally, the ten `.csv`'s in the `temp` folder need to be unified into one `.csv`. This is when the serial job comes in.  

## File structure 

* `PARAMS.csv`: table of one column of job ID's, and other columns containing parameter values
* `launch_script.sh`: Launch script for both job array and combining results serial job.
* `test_script.R`: R script that takes in arguments for `x` and `theta`, and generates a the value of `dexp(x, 1 / theta)`. 
* `test_script_submit.slurm`: Job array that launches the R script across 10 cores.
* `combine_results.R`: R script that combines all of the results in the `temp` folder into one data frame and saves to `final_results.csv`. 
* `combine_results_submit.slurm`: Serial job that waits for all 10 jobs in the `test_script_submit.slurm` job array to complete successfully, before launching `combine_results.R`.   
