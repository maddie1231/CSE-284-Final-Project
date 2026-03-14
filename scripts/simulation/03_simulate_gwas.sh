#Script to run GCTA GWAS simulation tool in 1000G EUR population for each trait using previously generated "causal" snps from actual GWAS data. Each GWAS uses simu-cc and simu-k to have a 200 case / 200 control split of donors in the results. Heritabilities are changed to realistically depict estimated heritability for each trait from current research.

#T1D: use chr6 to capture MHC locys and .5 heritability to replicate T1D
/usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr6 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/T1D_causal_snps_clean.txt \
  --simu-hsq 0.5 \
  --simu-k .5 \
  --simu-rep 1 \
  --out T1D_results/T1D_sim_chr6
  
  
 #Anorexia: use chr3 to capture sig loci and .6 heritability to replicate anorexia
/usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr3 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Anorexia_causal_snps_clean.txt \
  --simu-hsq 0.6 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Anorexia/Anorexia_sim_chr3
  
#Schizophrenia: use chr6 to capture sig loci and .75 heritability to replicate schizophrenia
/usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr6 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Schizophrenia_causal_snps_clean.txt \
  --simu-hsq 0.75 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_chr6
  
 #MDD: use chr13 to capture sig loci and .4 heritability to replicate MDD
 /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr13 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/MDD_causal_snps_clean.txt \
  --simu-hsq 0.4 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/MDD/MDD_sim_chr13
  
  #Autism: use chr20 to capture sig loci and .8 heritability to replicate Autism
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr20 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Autism_causal_snps_clean.txt \
  --simu-hsq 0.8 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Autism/Autism_sim_chr20
