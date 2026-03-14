
##### step 0 ###
# download precomputed LD scores 
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/eur_w_ld_chr.tar.bz2
tar -jxvf eur_w_ld_chr.tar.bz2

##### step 1 ###
# input: simulated gwas summary statistics with varying h2 
# output: summary statistics in ldsc format

# NOTE: change this to the directories on your machine 
ldsc_dir=/Users/rosanwang/ldsc  # dir LDSC is installed in 
repo_dir=/Users/rosanwang/Documents/school/ucsd/year\ 2/CSE\ 284/project/ # dir of the github project

cd ${ldsc_dir}  
conda activate ldsc 

indir=${repo_dir}/inputs/gwas_simulation
outdir=${repo_dir}/inputs/ldsc/sumstats
num=489

# loci gwas 
loci=(
  ${indir}/T1D/T1D_sim_gwas_HLA.mlma
  ${indir}/Schizophrenia/Schizophrenia_sim_gwas_HLA.mlma
  ${indir}/MDD/MDD_sim_gwas_LINC.mlma
  ${indir}/Autism/Autism_sim_gwas_MACROD2.mlma
  ${indir}/Anorexia/Anorexia_sim_gwas_FOXP1.mlma
)

for f in "${loci[@]}"; do
    name=$(basename "$f" .mlma)
    echo "${name}"
    ./munge_sumstats.py \
        --sumstats ${f} \
        --N ${num} \
        --out ${outdir}/${name}
done


# chr gwas 
chr=(
  ${indir}/T1D/T1D_sim_gwas_chr6.mlma
  ${indir}/Schizophrenia/Schizophrenia_sim_gwas_chr6.mlma
  ${indir}/MDD/MDD_sim_gwas_chr13.mlma
  ${indir}/Autism/Autism_sim_gwas_chr20.mlma
  ${indir}/Anorexia/Anorexia_sim_gwas_chr3.mlma
)


##### step 2 ###
# --ref-ld-chr: independent variable in LDSC
# --w-ld-chr: ld scores to use for regresison weights 
dir=${repo_dir}/inputs/ldsc/sumstats
ref=${repo_dir}/inputs/ldsc/ref/baselineLD_v2.3/baselineLD.
weights=${repo_dir}/inputs/ldsc/ref/GRCh38/weights/weights.hm3_noMHC.
out=${repo_dir}/results/ldsc

files=(
  ${dir}/T1D_sim_gwas_HLA.sumstats.gz
  ${dir}/Schizophrenia_sim_gwas_HLA.sumstats.gz
  ${dir}/MDD_sim_gwas_LINC.sumstats.gz
  ${dir}/Autism_sim_gwas_MACROD2.sumstats.gz
  ${dir}/Anorexia_sim_gwas_FOXP1.sumstats.gz
)

for file in ${dir}/*.sumstats.gz; do
    name=$(basename "$file" .sumstats.gz)
    echo "  Running LDSC for ${name}..."

    gtime -v -o "${outdir}/${name}.time.txt" \
        ./ldsc.py \
        --h2 ${file} \
        --ref-ld-chr ${ref} \
        --w-ld-chr ${weights} --out ${out}/${name}_h2

done


for f in ${dir}/*.sumstats.gz
do 
    name=$(basename "$f" .sumstats.gz)
    echo "  Running LDSC for ${name}..."
    ./ldsc.py \
        --h2 ${f} \
        --ref-ld-chr ${ref} \
        --w-ld-chr ${weights} --out ${out}/${name}_h2
done

