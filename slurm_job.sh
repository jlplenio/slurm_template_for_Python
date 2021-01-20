#!/bin/bash -l
#SBATCH --job-name=example_job # Custom job name. i.a. will be displayed in squeue

#SBATCH --ntasks=1 # Define task count
#SBATCH --nodes=1 # Define node count
#SBATCH --cpus-per-task=4 # Define cpu core count per task
#SBATCH --time=0-00:05:00 # Expected run time hard cap, if exceeded will force stop the job [d-hh:mm:ss]
#SBATCH --partition main # Partition for your job e.g. GPU to run on. See options with command sinfo
#SBATCH --qos=standard # Set job priority [standard, prio, hiprio]

# Memory hard cap per node / per cpu, if exceeded will force stop the job
##SBATCH --mem-per-cpu=1500MB # this one is not in effect, due to the double hash
#SBATCH --mem=1GB

# Email event notification [NONE, BEGIN, END, FAIL, ALL]
##SBATCH --mail-user=exampleusername@zedat.fu-berlin.de # replace username
##SBATCH --mail-type=END,FAIL

# You may not place any commands before the last SBATCH directive

# Loads most recent Python installed on cluster. See all modules with command module avail
module add Python

# Define a unique scratch directory for the job
SCRATCH_DIRECTORY=/scratch/${USER}/${SLURM_JOB_NAME}/${SLURM_JOBID}

# Define a unique home output directory for the job
OUTPUT_DIRECTORY=/${SLURM_SUBMIT_DIR}/output/$(date +%F)_${SLURM_JOBID}

# Create directories if not exist
mkdir -p "${OUTPUT_DIRECTORY}"
mkdir -p "${SCRATCH_DIRECTORY}/out"

# Copy job script to scratch directory
cp "${SLURM_SUBMIT_DIR}/slurm_job.py" "${SCRATCH_DIRECTORY}"

# Execute script and redirect output to file located in out folder
# Core count is passed to script via argv[1]
cd "${SCRATCH_DIRECTORY}" || exit
echo "now processing ${SLURM_JOB_NAME} - ${SLURM_JOBID}"
python3 slurm_job.py "${SLURM_CPUS_PER_TASK}" > out/"output_${SLURM_JOB_NAME}_${SLURM_JOBID}.txt"

# After script is done, copy all file in out folder to the output directory in home
cp out/* "${OUTPUT_DIRECTORY}"

# Leave scratch directory and delete it
cd "${SLURM_SUBMIT_DIR}" || exit
rm -rf "${SCRATCH_DIRECTORY}"

# finish
exit 0
