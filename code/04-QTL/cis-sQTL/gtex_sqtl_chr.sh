#!/bin/bash -l
#$ -cwd
#$ -l h_data=4G,h_rt=24:00:00
#$ -j y
#$ -o /u/project/gandalm/cindywen/isoform_twas/sqtl_new/log/job.out.gtex.qtl.chr
#$ -m a
#$ -t 1-22

num_hcp=40
chunk=${SGE_TASK_ID}

expr=/u/project/gandalm/cindywen/isoform_twas/sqtl_new/cluster/leafcutter_perind.counts.nochr.gz.qqnorm_all_fixSubj_combat.bed.gz
geno=/u/project/gandalm/cindywen/isoform_twas/genotype/all_data/isec_R2_greater_than_3/ancestry/filtered.hg19.sorted.removeRel.vcf.gz
cov=/u/project/gandalm/cindywen/isoform_twas/sqtl_new/data/${num_hcp}hcp_cov.txt
rel_file=/u/project/gandalm/cindywen/isoform_twas/genotype/all_data/isec_R2_greater_than_3/ancestry/related.txt
outdir=/u/project/gandalm/cindywen/isoform_twas/sqtl_new/results/mixed_nominal_${num_hcp}hcp_1e6

. /u/local/Modules/default/init/modules.sh
module load gcc/11.3.0
/u/project/gandalm/cindywen/isoform_twas/sqtl_new/fastqtl-gtex/bin/fastQTL.static \
            --vcf ${geno} \
            --bed ${expr} \
            --window 1e6 \
            --cov ${cov} \
            --seed 123 \
            --exclude-samples ${rel_file} \
            --chunk ${chunk} 22 \
            --out ${outdir}/gtex_chunk${chunk}.txt.gz \
            --log ${outdir}/gtex_chunk${chunk}.log \
            --normal
