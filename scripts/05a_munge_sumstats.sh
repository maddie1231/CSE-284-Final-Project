
##### step 0 ###
# download precomputed LD scores 
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/eur_w_ld_chr.tar.bz2
tar -jxvf eur_w_ld_chr.tar.bz2

##### step 1 ###
# input: simulated gwas summary statistics with varying h2 
# output: summary statistics in ldsc format
cd /Users/rosanwang/ldsc
conda activate ldsc 

indir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/gwas_simulation
outdir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/sumstats
num=489

# Define the array
files=(
  ${indir}/T1D/T1D_sim_gwas_HLA.mlma
  ${indir}/Schizophrenia/Schizophrenia_sim_gwas_HLA.mlma
  ${indir}/MDD/MDD_sim_gwas_LINC.mlma
  ${indir}/Autism/Autism_sim_gwas_MACROD2.mlma
  ${indir}/Anorexia/Anorexia_sim_gwas_FOXP1.mlma
)

for f in "${files[@]}"; do
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
outdir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/sumstats
ref=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/ref/baselineLD_v2.3/baselineLD.
weights=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ldsc/ref/GRCh38/weights/weights.hm3_noMHC.

files=(
  ${outdir}/T1D_sim_gwas_HLA.sumstats.gz
  ${outdir}/Schizophrenia_sim_gwas_HLA.sumstats.gz
  ${outdir}/MDD_sim_gwas_LINC.sumstats.gz
  ${outdir}/Autism_sim_gwas_MACROD2.sumstats.gz
  ${outdir}/Anorexia_sim_gwas_FOXP1.sumstats.gz
)

for file in ${outdir}/*.sumstats.gz; do
    name=$(basename "$file" .sumstats.gz)
    echo "  Running LDSC for ${name}..."

    gtime -v -o "${outdir}/${name}.time.txt" \
        ./ldsc.py \
        --h2 ${file} \
        --ref-ld-chr ${ref} \
        --w-ld-chr ${weights} --out ${outdir}/${name}_h2

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

