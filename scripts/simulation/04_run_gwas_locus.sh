#Script to run a mlma GWAS on GCTA simulated GWAS data for each trait.

/usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr6_HLA \
  --pheno inputs/gwas_simulation/T1D/T1D_sim_HLAregion.phen \
  --mlma \
  --out inputs/gwas_simulation/T1D/T1D_sim_gwas_HLA
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr3_FOXP1 \
  --pheno inputs/gwas_simulation/Anorexia/Anorexia_sim_FOXP1.phen \
  --mlma \
  --out inputs/gwas_simulation/Anorexia/Anorexia_sim_gwas_FOXP1
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr6_HLA \
  --pheno inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_HLA.phen \
  --mlma \
  --out inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_gwas_HLA
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr13_LINC \
  --pheno inputs/gwas_simulation/MDD/MDD_sim_LINC.phen \
  --mlma \
  --out inputs/gwas_simulation/MDD/MDD_sim_gwas_LINC
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr20_MACROD2 \
  --pheno inputs/gwas_simulation/Autism/Autism_sim_MACROD2.phen \
  --mlma \
  --out inputs/gwas_simulation/MDD/Autism_sim_gwas_MACROD2
