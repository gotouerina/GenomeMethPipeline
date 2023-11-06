# PacBio_meth
Pipeline for revio meth call


##  01.ccsmeth

拉取镜像：

    singularity pull docker://nipengcsu/ccsmethphase:latest


##    02.CpG tools (PacBio official Pipeline)

### install CpG tools
        
        wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.1/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu.tar.gz
        tar -xzf pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu.tar.gz
        pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --help

### install PBMM2

        wget https://github.com/PacificBiosciences/pbmm2/releases/download/v1.13.0/pbmm2


        
