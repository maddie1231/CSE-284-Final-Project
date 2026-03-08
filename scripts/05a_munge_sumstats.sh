
##### step 0 ###
# download precomputed LD scores 
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/eur_w_ld_chr.tar.bz2
tar -jxvf eur_w_ld_chr.tar.bz2

##### step 1 ###
# input: simulated gwas summary statistics with varying h2 
# output: summary statistics in ldsc format

indir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/gwas_simulation
outdir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/sumstats
num=489

for f in ${indir}/T1D/T1D*.mlma
do 
    name=$(basename "$f" .mlma)
    echo "${name}"
    ./munge_sumstats.py \
        --sumstats ${f} \
        --N ${num} \
        --out ${outdir}/${name}
done



##### step 2 ###
# --ref-ld-chr: independent variable in LDSC
# --w-ld-chr: ld scores to use for regresison weights 
ref=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/ref/baselineLD_v2.3/baselineLD.
weights=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/ref/GRCh38/weights/weights.hm3_noMHC.

for file in ${outdir}/T1D_sim_gwas_chr6.sumstats.gz; do


    # start_time=$(date +%s)
    name=$(basename "$file" .sumstats.gz)
    echo "  Running LDSC for ${name}..."
    ./ldsc.py \
        --h2 ${file} \
        --ref-ld-chr ${ref} \
        --w-ld-chr ${weights} --out ${outdir}/${name}_h2

    # end_time=$(date +%s)
    # runtime_s=$(( (end_time - start_time) / 1000000000 ))

    # peak_mem=$(grep "Maximum resident" "${outdir}/${name}.time.txt" | awk '{print $NF}')
    # echo -e "${name}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
done


indir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc
for f in ${indir}/*.sumstats.gz
do 
    name=$(basename "$f" .sumstats.gz)
    echo "  Running LDSC for ${name}..."
    ./ldsc.py \
        --h2 ${f} \
        --ref-ld-chr ${ref} \
        --w-ld-chr ${weights} --out ${outdir}/${name}_h2
done

