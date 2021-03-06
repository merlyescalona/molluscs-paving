sim-molluscs: Simulations for the discovery of PAV
================
Merly Escalona <merlyescalona@uvigo.es>
March 12th, 2018

-   [Introduction](#introduction)
    -   [Objectives](#objectives)
-   [Requirements](#requirements)
-   [Simulation process](#simulation-process)
    -   [`INDELible`](#indelible)
    -   [`ART`](#art)
-   [Parameterization](#parameterization)
    -   [Trees](#trees)
    -   [Sequence features](#sequence-features)
-   [Simulations](#simulations)
    -   [The gene trees](#the-gene-trees)

Introduction
============

This simulations are being made to analyze if there is any effect of the heterozygosity

Objectives
----------

Requirements
============

-   [INDELible](http://abacus.gene.ucl.ac.uk/software/indelible/):
-   [INDELible-NGSphy](https://github.com/merlyescalona/indelible-ngsphy)
-   [NGSphy](https://github.com/merlyescalona/ngsphy)
-   [ART](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm)

Simulation process
==================

The simulation process starts with the generation of sequences from trees. These will be done with `INDELible` [\[1\]](#fletcher2009). Afterwards, next-generation sequencing (NGS) reads will be generated from such sequences, this will be done with the NGS simulator `ART` [\[2\]](#huang2012). The later process will be parameterized with available empirical datasets, get NGS data quality as close to the original datasets as possible.

`INDELible`
-----------

`INDELible` generates nucleotide, amino acid and codon sequences data by simulating insertions and deletions (indels) as well as substitutions. Indels are simulated under several models of indel-length distribution. The program implements a rich repertoire of substitution models, the general unrestricted model and nonstationary nonhomogeneous models of nucleotide substitution, mixture, and partition models that account for heterogeneity among sites, and codon models that allow the nonsynonymous/synonymous substitution rate ratio to vary among sites and branches.

In order to generate data from `INDELible`, it is required to set up a configuration/control file. While the manual of INDELible can be foud [here](http://abacus.gene.ucl.ac.uk/software/indelible/manual/) and tutorials for its usage can be found [here](http://abacus.gene.ucl.ac.uk/software/indelible/tutorial/), shown below there is a small example of control file.

    // It is useful to know that anything on a line after two forward slashes is ignored.
    /*
       Another useful thing to know is that anything after a forward slash and star
       is ignored until INDELible sees a star followed by a forward slash later on.
    */     
    [TYPE] AMINOACID 2  //  EVERY control file must begin with a [TYPE] command.
                //  The number after "AMINOACID" can be 1 or 2 and chooses the
                //  algorithm that INDELible uses (see manuscript). Both give
                //  identical results but in some cases one is quicker.
                //  Other blocks and commands following this statement
                //  can come in any order you like.
    [MODEL]    modelname         //  Evolutionary models are defined in [MODEL] blocks.
      [submodel] WAG             //  Here the substitution model is simply set as WAG.
      [indelmodel]  POW  1.7 500 //  Power law insertion/deletion length distribution (a=1.7)
      [indelrate]   0.1          //  insertion rate = deletion rate = 0.1
                                 //  relative to average substitution rate of 1.   
    [TREE] treename  (A:0.1,B:0.1);        //  User trees are defined here
    [PARTITIONS] partitionname             //  [PARTITIONS] blocks say which models go with
      [treename modelname 1000]            //  which trees and define the length of the
                                           //  sequence generated at the root (1000 here).
    [EVOLVE] partitionname 100 outputname  //  This will generate 100 replicate datasets
                                           //  from the [PARTITIONS] block named above.
    // The true alignment will be output in a file named outputname_TRUE.phy
    // The unaligned sequences will be output in a file named outputname.fas
    // To learn how to implement more complicated simulations (or different
    // models) please consult the manual or the other example control files.

`ART`
-----

ART is a set of simulation tools to generate synthetic next-generation sequencing reads. ART simulates sequencing reads by mimicking real sequencing process with empirical error models or quality profiles summarized from large recalibrated sequencing data. ART can also simulate reads using user own read error model or quality profiles. ART supports simulation of single-end, paired-end/mate-pair reads of three major commercial next-generation sequencing platforms: Illumina's Solexa, Roche's 454 and Applied Biosystems' SOLiD. ART can be used to test or benchmark a variety of method or tools for next-generation sequencing data analysis, including read alignment, de novo assembly, SNP and structure variation discovery. ART outputs reads in the FASTQ format, and alignments in the ALN format. ART can also generate alignments in the SAM alignment or UCSC BED file format.

<!-- ###  
No hotspots
play with tree height = mutation rate
let hotspot have a value that's depending on the mutation rate. -->
Parameterization
================

Trees
-----

For the purpose of the simulation the tree is given and contains only two (`2`) species. The important parameter to vary within trees is the tree depth. Tree used, for all simulation scenarios will be:

![](report.sim.molluscs_files/figure-markdown_github/unnamed-chunk-1-1.png)

Corresponding to the Newick tree:

    (A,B);

Sequence features
-----------------

Simulations
===========

The gene trees
--------------

![](report.sim.molluscs_files/figure-markdown_github/The%20gene%20tree-1.png)

------------------------------------------------------------------------

**References**

-   \[1\] Fletcher, W. and Yang, Z. 2009. *INDELible: a flexible simulator of biological sequence evolution.* Mol. Biol. and Evol. 2009 26(8):1879-1888 [DOI: 10.1093/molbev/msp098](https://doi.org/10.1093/molbev/msp098)

-   \[2\] Weichun Huang Leping Li Jason R. Myers Gabor T. Marth (2012) *ART: a next-generation sequencing read simulator.* Bioinformatics 28 (4): 593-594. [DOI: 10.1093/bioinformatics/btr708](https://doi.org/10.1093/bioinformatics/btr708)
