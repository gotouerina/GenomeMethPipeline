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
 
##注意，这是r10芯片的模型，r9芯片的需要用别的模型##
##dorado需要带CUDA的GPU运行；
 

Last, call meth using modkit

        modkit pileup calls.bam out.bed --log-filepath pileup.log

        ![image](https://github.com/user-attachments/assets/bc2e66ec-305b-4032-a544-d629d6bbb07e)
        ![image](https://github.com/user-attachments/assets/3c1db2f8-6c46-47c2-a25b-b731ab777cda)


Definitions:

Nmod - Number of calls passing filters that were classified as a residue with a specified base modification.

Ncanonical - Number of calls passing filters were classified as the canonical base rather than modified. The exact base must be inferred by the modification code. For example, if the modification code is m (5mC) then the canonical base is cytosine. If the modification code is a, the canonical base is adenosine.

Nother mod - Number of calls passing filters that were classified as modified, but where the modification is different from the listed base (and the corresponding canonical base is equal). For example, for a given cytosine there may be 3 reads with h calls, 1 with a canonical call, and 2 with m calls. In the bedMethyl row for h Nother_mod would be 2. In the m row Nother_mod would be 3.

Nvalid_cov - the valid coverage. Nvalid_cov = Nmod + Nother_mod + Ncanonical, also used as the score in the bedMethyl

Ndiff - Number of reads with a base other than the canonical base for this modification. For example, in a row for h the canonical base is cytosine, if there are 2 reads with C->A substitutions, Ndiff will be 2.

Ndelete - Number of reads with a deletion at this reference position

Nfail - Number of calls where the probability of the call was below the threshold. The threshold can be set on the command line or computed from the data (usually failing the lowest 10th percentile of calls).

Nnocall - Number of reads aligned to this reference position, with the correct canonical base, but without a base modification call. This can happen, for example, if the model requires a CpG dinucleotide and the read has a CG->CH substitution such that no modification call was produced by the basecaller.

