
##### step 0 ###
# download precomputed LD scores 
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/eur_w_ld_chr.tar.bz2
tar -jxvf eur_w_ld_chr.tar.bz2

##### step 1 ###
# input: simulated gwas summary statistics with varying h2 
# output: summary statistics in ldsc format

munge_sumstats.py \
    --sumstats ${sumstat} \
    --N ${num} \
    --out ${outdir}/


##### step 2 ###
# --ref-ld-chr: independent variable in LDSC
# --w-ld-chr: ld scores to use for regresison weights 
for file in ${outdir}/*.sumstats.gz; do
    ldsc.py \
        --h2 ${file} \
        --ref-ld-chr eur_w_ld_chr/ --w-ld-chr eur_w_ld_chr/ --out scz_h2
done