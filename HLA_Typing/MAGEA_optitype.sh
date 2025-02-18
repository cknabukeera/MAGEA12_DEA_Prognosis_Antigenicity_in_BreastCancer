#!/bin/bash
#SBATCH --job-name=HLA2_Typing                  # Name of the job
#SBATCH --output=my_job_output.txt          # Output file
#SBATCH --error=my_job1_error.txt            # Error file
#SBATCH --ntasks=1                          # Number of tasks
#SBATCH --cpus-per-task=1                   # Number of CPU cores per task
#SBATCH --mem=4G                            # Memory required


# Path to the folder containing the fastq files
READS_DIR="./sra_files"
OUTPUT_DIR="./HLA_results/new_Results"
OPTITYPE_SCRIPT="../OptiType/OptiTypePipeline.py"

# Loop through all single-end fastq files
for read in "$READS_DIR"/*.fastq; do
    # Extract the sample name (removes the .fastq suffix)
    sample=$(basename "$read" .fastq)

    # Create an output directory for each sample
    sample_output_dir="${OUTPUT_DIR}/${sample}_results"
    mkdir -p "$sample_output_dir"

    # Run the OptiType pipeline for each read
    python "$OPTITYPE_SCRIPT" -i "$read" --rna -v -o "$sample_output_dir"

done

