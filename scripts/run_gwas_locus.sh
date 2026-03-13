#Script to run a mlma GWAS on GCTA simulated GWAS data for each trait.

/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr6_HLA/chr6_HLA \
  --pheno T1D_results/T1D_sim_HLAregion.phen \
  --mlma \
  --out GWAS_results/T1D_sim_gwas_HLA
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr3_FOXP1 \
  --pheno Anorexia_results/Anorexia_sim_FOXP1.phen \
  --mlma \
  --out GWAS_results/Anorexia_sim_gwas_FOXP1
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr6_HLA/chr6_HLA \
  --pheno Schizophrenia_results/Schizophrenia_sim_HLA.phen \
  --mlma \
  --out GWAS_results/Schizophrenia_sim_gwas_HLA
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr13_LINC \
  --pheno MDD_results/MDD_sim_LINC.phen \
  --mlma \
  --out GWAS_results/MDD_sim_gwas_LINC
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr20_MACROD2 \
  --pheno Autism_results/Autism_sim_MACROD2.phen \
  --mlma \
  --out GWAS_results/Autism_sim_gwas_MACROD2