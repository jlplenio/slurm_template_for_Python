# Multiprocessing Python template for HPC with Slurm

Template for running a multiprocessing Python script on an HPC with Slurm. 
Job files will be copied to and run in the temporary scratch directory. 
After job completion, all script and calculation outputs will be saved in an output folder in the user home.
The scratch directory will be deleted.

The example calculates Pi 100 times (with default 4 cores) and saves an .scv output file.  
See [slurm_job.sh](slurm_job.sh) for all relevant settings.

Script was tested on the High-Performance-Cluster [High-Performance Computing at ZEDAT](https://www.fu-berlin.de/en/sites/high-performance-computing/index.html) of the Freie Universität Berlin, Germany

For an implementation in R see [slurm_template_for_R_Language](https://github.com/ndevln/slurm_template_for_R_Language)
