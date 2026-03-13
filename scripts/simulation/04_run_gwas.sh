#Script to run a mlma GWAS on GCTA simulated GWAS data for each trait.

/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6 \
  --pheno T1D_results/T1D_sim_chr6.phen \
  --mlma \
  --out GWAS_results/T1D_sim_gwas_chr6
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.3 \
  --pheno Anorexia_results/Anorexia_sim_chr3.phen \
  --mlma \
  --out GWAS_results/Anorexia_sim_gwas_chr3
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6 \
  --pheno Schizophrenia_results/Schizophrenia_sim_chr6.phen \
  --mlma \
  --out GWAS_results/Schizophrenia_sim_gwas_chr6
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.13 \
  --pheno MDD_results/MDD_sim_chr13.phen \
  --mlma \
  --out GWAS_results/MDD_sim_gwas_chr13
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.20 \
  --pheno Autism_results/Autism_sim_chr20.phen \
  --mlma \
  --out GWAS_results/Autism_sim_gwas_chr20
