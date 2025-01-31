#!/bin/bash
#$ -l h_data=4G,h_rt=12:00:00,highp
#$ -wd /u/project/gandalm/cindywen/isoform_twas/salmon/
#$ -pe shared 12
#$ -j y
#$ -o ./log/job_out_obrienEqClass
#$ -m a
#$ -t 1-120

SALMON_INDEX=/u/project/gandalm/shared/refGenomes/hg19/Gencode/v33/salmon_index_with_decoys
INPUT_FILE=./../star/sample_list_obrien.txt

INLINE=`head -n ${SGE_TASK_ID} ${INPUT_FILE} | tail -n 1`
IFS=$'\t' params=(${INLINE})
SAMPLE_ID=${params[0]}             
IN_FASTQS_R1=${params[1]}          
IN_FASTQS_R2=${params[2]}          

SAMPLE_PATH=./obrienEqClass/${SAMPLE_ID}
mkdir -p ${SAMPLE_PATH}

/u/project/gandalm/shared/apps/salmon/salmon-latest_linux_x86_64/bin/salmon \
	quant \
	-i ${SALMON_INDEX} \
	-l A \
	-1 ${IN_FASTQS_R1} \
	-2 ${IN_FASTQS_R2} \
	--validateMappings \
	--useEM \
	--numBootstraps 50 \
	--seqBias \
	--gcBias \
	-p 12 \
	-o ${SAMPLE_PATH} \
	--dumpEq
