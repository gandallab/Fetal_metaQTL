## Genotype 
### Pre-imputation QC
- Pre-imputation QC code, from starting data to files for imputation
- First apply PLINK filters, and then split by chromosome and sort
- Walker data is already filtered; we split the data by chromosome and imputed it
- For all the other datasets, we applied the same filters that the Walker data have had `--hwe 1e6 --maf 0.01 --mind 0.10 --geno 0.05`
- Note: for HDBR, we used `--mind 0.3`; for LIBD, we fixed strand flips by running an extra step of conform-gt, which automatically splits the data by chromosome
### Post-imputation QC
- Scripts in `prep/`: inputs are imputed genotype files downloaded from server; concatenate by chromosomes, index, filter by R2, and take the **intersection** of high impute quality variants across datasets
- Note: except for Walker data, we applied R2>.3 filter during imputation; so here we only applied R2>.3 on Walker imputed data and intersected with the other datasets
- (Remove subjects that are not in rnaseq, reheader to match subject IDs)
- Map to dbSNP rsID
- PLINK filter `--hwe 1e-6 --maf 0.01 --geno 0.05`
- Crossmap to hg19
- Sort, as some variants become unsorted after Crossmap
- Convert VCF to PLINK
- Run [checkVCF](https://github.com/zhanxw/checkVCF) for sanity check
- Merge data with 1000genomes to calculate genotype PCs and call ancestry
- Subsect ancestry genotype, and apply PLINK filters and calculate genotype PCs respectively
- Remove any outlier subjects from rnaseq expression