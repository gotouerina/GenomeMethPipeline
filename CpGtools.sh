## From file contain kinestic signature like Mm et.al
ref=
bam=
prefix=

##Align
pbmm2 align $ref $bam $prefix.sort.bam --sort

##Call meth
pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores \
  --bam $prefix.sort.bam \
  --output-prefix $prefix \
  --model pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite \
  --threads 8
