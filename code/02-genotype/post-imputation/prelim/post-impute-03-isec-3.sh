#!/bin/bash
#$ -l h_data=16G,h_rt=4:00:00,highp
#$ -wd /u/project/gandalm/shared/GenomicDatasets/FetalBrain/
#$ -o /u/home/c/cindywen/project-gandalm/isoform_twas/genotype/log/job.out.post.impute.03.3
#$ -j y
#$ -m a

# merge datasets together, intersecting the high imputation quality variants (R2 > .3)
. /u/local/Modules/default/init/modules.sh
module load bcftools/1.9
module load htslib/1.9

outfolder=/u/home/c/cindywen/project-gandalm/isoform_twas/genotype/all_data/isec_R2_greater_than_3
mkdir -p ${outfolder}

#excluding LIBD h650 array and phase2only 1M
walker=./Walker2019_eQTL/geno/imputed/concat.R2.3.vcf.gz
obrien=./Obrien2018_eQTL/geno/imputed/concat.all.vcf.gz
werling=./Werling2020_eQTL/geno/imputed/concat.all.vcf.gz
libd_1and2_1M=./LIBD_1and2/geno/phase1and2/imputed/array_1M/concat.all.vcf.gz
hdbr=./HDBR/geno/imputed/concat.all.vcf.gz

# -c none, -c all, not much difference
# -c none is intersecting by chr:position:ref:alt
# -c all by chr:position
# -c all slightly outputing more intersecting variants, but not much
# also losing ref:alt information

bcftools isec ${walker} ${obrien} ${werling} ${libd_1and2_1M} ${hdbr} -c none -n=5 -p ${outfolder}

for i in {0..4..1}
do 
bgzip ${outfolder}/000${i}.vcf
tabix -p vcf ${outfolder}/000${i}.vcf.gz
done
