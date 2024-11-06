# PacBio_meth
Pipeline for revio meth call


##  01.ccsmeth

Pull container：

    singularity pull docker://nipengcsu/ccsmethphase:latest


##    02.CpG tools (PacBio official Pipeline)

Notice: It is more recommanded to use cpgtools.pl but not bash scripts

### Install CpG tools
        
        wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.1/pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu.tar.gz
        tar -xzf pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu.tar.gz
        pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --help

### Install PBMM2

        wget https://github.com/PacificBiosciences/pbmm2/releases/download/v1.13.0/pbmm2

# Nanopore_meth

Dorado + modkit using pod5 format for input.

Firstly, convert fast5 to pod5:

        pod5 convert fast5 fast5/*.fast5  --output  pod5/ --one-to-one ./fast5 

Then, call bam from the pod5,

        dorado  basecaller  /groups/lzu_public/home/u220220932211/software/dna_r10.4.1_e8.2_400bps_hac@v5.0.0/     /groups/lzu_public/home/u220220932211/work/   --modified-bases-models /groups/lzu_public/home/u220220932211/software/dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mC_5hmC@v1/    > calls.bam

 /dna_r10.4.1_e8.2_400bps_hac@v5.0.0/   and      dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mC_5hmC@v1/  are model files,
 you can download them from the release.

Last, call meth using modkit

        modkit pileup calls.bam out.bed --log-filepath pileup.log
