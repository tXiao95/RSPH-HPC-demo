#!/bin/bash
#SBATCH --job-name=combine-results-test       # Create short name for job
#SBATCH --nodes=1                             # node count
#SBATCH --ntasks=1	                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1                     # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G                      # memory per cpu-core (4G is default)
#SBATCH --mail-type=FAIL                      # send email when job fails
#SBATCH --mail-user=thsiao3@emory.edu         # Email user

module load R
Rscript combine_results.R
