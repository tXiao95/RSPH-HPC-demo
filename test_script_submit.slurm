#!/bin/bash
#SBATCH --job-name=cluster_demo        # create a name for the job
#SBATCH --nodes=1                      # Node count (number of computers)
#SBATCH --ntasks-per-node=1            # total number of tasks across all nodes
#SBATCH --cpus-per-task=1              # cpu-cores per task (>1 if multi-threaded tasks, internal parallelization within R for example)
#SBATCH --mem-per-cpu=1G               # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00                # total run time limit (HH:MM:SS)
#SBATCH --array=1-10                   # Job array with index values. Show up as SLURM_ARRAY_TASK_ID
#SBATCH --partition=chang              # Designation of which cluster nodes to launch jobs on
#SBATCH --mail-type=FAIL               # Email received when job fails only (can also set as start, etc.)
#SBATCH --mail-user=thsiao3@emory.edu  # Email to receive
#SBATCH --output=output/slurm-%A.%a.out       # Output file
#SBATCH --error=error/slurm-%A.%a.err        # Error file

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID."
echo "Executing on the machine:" $(hostname)

module load R

Rscript test_script.R
