#Script to run GCTA GWAS simulation tool in 1000G EUR population for each trait using previously selected 5 random"causal" snps. Each GWAS uses simu-cc and simu-k to have a 200 case / 200 control split of donors in the results. Heritabilities are changed to realistically depict estimated heritability for each trait from current research. (Paths point to Gaulton lab cluster but input files can be found on ref folder on github)

#T1D: 
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr6_HLA/chr6_HLA \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/T1D_HLA_5causal.txt \
  --simu-hsq 0.5 \
  --simu-k .5 \
  --simu-rep 1 \
  --out T1D_results/T1D_sim_HLAregion
  
  
 #Anorexia: 
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr3_FOXP1 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Anorexia_5causal.txt \
  --simu-hsq 0.6 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Anorexia_results/Anorexia_sim_FOXP1
  
#Schizophrenia: 
/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr6_HLA/chr6_HLA \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Schizophrenia_5causal.txt \
  --simu-hsq 0.75 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Schizophrenia_results/Schizophrenia_sim_HLA
  
 #MDD: 
 /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr13_LINC \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/MDD_5causal.txt \
  --simu-hsq 0.4 \
  --simu-k .5 \
  --simu-rep 1 \
  --out MDD_results/MDD_sim_LINC
  
  #Autism: 
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr20_MACROD2 \
  --simu-cc 200 200 \
  --simu-causal-loci /nfs/lab/tscc/mpittigher/random/sumstats/Autism_5causal.txt \
  --simu-hsq 0.8 \
  --simu-k .5 \
  --simu-rep 1 \
  --out Autism_results/Autism_sim_MACROD2