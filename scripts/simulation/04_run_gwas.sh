#Script to run a mlma GWAS on GCTA simulated GWAS data for each trait.

/usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr6 \
  --pheno inputs/gwas_simulation/T1D/T1D_sim_chr6.phen \
  --mlma \
  --out inputs/gwas_simulation/T1D/T1D_sim_gwas_chr6
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr3 \
  --pheno inputs/gwas_simulation/Anorexia/Anorexia_sim_chr3.phen \
  --mlma \
  --out inputs/gwas_simulation/Anorexia/Anorexia_sim_gwas_chr3
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr6 \
  --pheno inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_chr6.phen \
  --mlma \
  --out inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_gwas_chr6
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr13 \
  --pheno inputs/gwas_simulation/MDD/MDD_sim_chr13.phen \
  --mlma \
  --out inputs/gwas_simulation/MDD/MDD_sim_gwas_chr13
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr20 \
  --pheno inputs/gwas_simulation/Autism/Autism_sim_chr20.phen \
  --mlma \
  --out inputs/gwas_simulation/Autism/Autism_sim_gwas_chr20
