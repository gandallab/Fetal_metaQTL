#!/bin/bash -l 
#$ -cwd
#$ -l h_data=60G,h_rt=12:00:00
#$ -j y
#$ -o /u/project/gandalm/cindywen/isoform_twas/isoqtl_new/log/job.out.snakemake
#$ -m a

source /u/local/apps/anaconda3/2019.03/bin/activate snakemake

snakemake \
    --snakefile Snakefile \
    --jobscript cluster_jobscript.sh \
    --cluster-sync "qsub -l h_data={resources.mem_gb}G,h_rt=00:{resources.time_min}:00 -pe shared {resources.num_cores} -o /u/project/gandalm/cindywen/isoform_twas/isoqtl_new/log/job.out.pipeline" \
    --jobs 150 \
    --max-jobs-per-second 10 \
    --restart-times 0 \
    --latency-wait 5 \
    --default-resources mem_gb=4 time_min=240 num_cores=1 
