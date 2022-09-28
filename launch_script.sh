#!/bin/bash

ArrayID=$(sbatch --parsable test_script_submit.slurm)          # ID of the job array submission.
sbatch --depend=afterok:$ArrayID combine_results_submit.slurm  # Launch combine results job which waits for job array to complete successfully

