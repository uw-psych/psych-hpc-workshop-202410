#!/usr/bin/env bash

# Convert DICOM files to Nifti

# Set the account
#SBATCH --account=psych

# Set the partition
#SBATCH --partition=cpu-g2-mem2x

# Set the job name:
#SBATCH --job-name=hpc-dcm2niix

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1

# Request 8GB of memory per task:
#SBATCH --mem=8G

# Request 1 hour of runtime max:
#SBATCH --time=1:00:00

# Run 4 array tasks:
#SBATCH --array=0-3

# Load the dcm2niix module to convert DICOM files to NIfTI
module load escience/dcm2niix

# Create  an output directory for the converted files under /gscratch/scrubbed
# The $USER variable will be replaced with your UW NetID
mkdir -p "/gscratch/scrubbed/$USER/hpc-workshop-01-output"


# Convert the DICOM files in each of these directories to NIfTI format:
# -o precedes the output directory
# the input directory is the last argument
# $SLURM_ARRAY_TASK_ID will be replaced by 0,1,2,3 at runtime
srun dcm2niix -o /gscratch/scrubbed/$USER/hpc-workshop-01-output /mmfs1/gscratch/psych/hpc-workshop-01/datafiles/$SLURM_ARRAY_TASK_ID


# Print a message to the job log to indicate that the conversion is done
echo "Done!"
