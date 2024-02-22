#! /usr/bin/perl
use strict;
use warnings;

##CCS LONG READS METH PIPELINE
my $ref = shift;
my $bam = shift;
my $prefix = shift;

my $dir = `pwd`
chomp $dir;
open O, ">meth.sh" or die "Usage: perl $0 $ref $bam $prefix";
print O "$dir/pbmm2 align $ref $bam $prefix.sort.bam --sort\n$dir/aligned_bam_to_cpg_scores --bam $prefix.sort.bam --output-prefix $prefix  --model $dir/pileup_calling_model.v1.tflite  --threads 10";
close O;

#Then, type sh meth.sh for analysis;
