#Script to run GCTA GWAS simulation tool in 1000G EUR population for each trait using previously generated "causal" snps from actual GWAS data. Each GWAS uses simu-cc and simu-k to have a 200 case / 200 control split of donors in the results. Heritabilities are changed to realistically depict estimated heritability for each trait from current research.

#T1D: use chr6 to capture MHC locys and .5 heritability to replicate T1D
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/T1D_causal_snps_clean.txt \
  --simu-hsq 0.5 \
  --simu-k .5 \
  --simu-rep 1 \
  --out T1D_results/T1D_sim_chr6
  
  
 #Anorexia: use chr3 to capture sig loci and .6 heritability to replicate anorexia
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.3 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Anorexia_causal_snps_clean.txt \
  --simu-hsq 0.6 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Anorexia_results/Anorexia_sim_chr3
  
#Schizophrenia: use chr6 to capture sig loci and .75 heritability to replicate schizophrenia
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Schizophrenia_causal_snps_clean.txt \
  --simu-hsq 0.75 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Schizophrenia_results/Schizophrenia_sim_chr6
  
 #MDD: use chr13 to capture sig loci and .4 heritability to replicate MDD
 /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.13 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/MDD_causal_snps_clean.txt \
  --simu-hsq 0.4 \
  --simu-k .5 \
  --simu-rep 1 \
  --out MDD_results/MDD_sim_chr13
  
  #Autism: use chr20 to capture sig loci and .8 heritability to replicate Autism
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.20 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Autism_causal_snps_clean.txt \
  --simu-hsq 0.8 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Autism_results/Autism_sim_chr20
