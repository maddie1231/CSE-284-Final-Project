#Base line code to simulate GWAS dataset from 1000 genotypes dataset. Then we can use 1000 genomes
#genotypes to run gcta LMM based heritability estimation.

#We will run this multiple times with different parameters to simulate different GWAS sumstats.
gcta64 --bfile test --simu-qt --simu-hsq 0.5 --simu-rep 3 --out test
