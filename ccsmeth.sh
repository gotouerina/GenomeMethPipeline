##start hifi reads file of PacBio Revio Data
##contain kinestic signature like fi fn et.al

bam=hifi_reads.bc2036.bam  ##rename this
ref=ref.fasta ##rename this
prefix=

##Denova mode call meth, GPU step
singularity  exec --nv ccsmethphase_latest.sif ccsmeth call_mods --model_file /opt/models/ccsmeth/model_ccsmeth_5mCpG_call_mods_attbigru2s_b21.v2.ckpt \ 
--input $bam --output $prefix --mode denovo --threads 10 --threads_call 2 --model_type attbigru2s

##Pbmm2 align, CPU step
singularity exec ccsmethphase_latest.sif  ccsmeth  align_hifi    --hifireads $prefix.modbam.bam --ref $ref \
--output $prefix --threads 10


##Call frequency, GPU step
singularity exec --nv  ccsmethphase_latest.sif ccsmeth call_freqb  --input_bam  \ 
--ref $ref  --output $prefix.modbam.pbmm2.freq --threads 10 --sort --bed --call_mode aggregate  \
--aggre_ /opt/models/ccsmeth/model_ccsmeth_5mCpG_aggregate_attbigru_b11.v2p.ckpt
