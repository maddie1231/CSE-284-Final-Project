#Script to run GCTA GWAS simulation tool in 1000G EUR population for each trait using previously selected 5 random"causal" snps. Each GWAS uses simu-cc and simu-k to have a 200 case / 200 control split of donors in the results. Heritabilities are changed to realistically depict estimated heritability for each trait from current research. (Paths point to files on lab cluster, change to your paths to downloaded data)

#T1D: 
/usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr6_HLA \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/T1D_HLA_5causal.txt \
  --simu-hsq 0.5 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/T1D/T1D_sim_HLAregion
  
  
 #Anorexia: 
/usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr3_FOXP1 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Anorexia_5causal.txt \
  --simu-hsq 0.6 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Anorexia/Anorexia_sim_FOXP1
  
#Schizophrenia: 
/usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr6_HLA \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Schizophrenia_5causal.txt \
  --simu-hsq 0.75 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Schizophrenia/Schizophrenia_sim_HLA
  
 #MDD: 
 /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr13_LINC \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/MDD_5causal.txt \
  --simu-hsq 0.4 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/MDD/MDD_sim_LINC
  
  #Autism: 
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr20_MACROD2 \
  --simu-cc 200 200 \
  --simu-causal-loci inputs/causal_snp_files/Autism_5causal.txt \
  --simu-hsq 0.8 \
  --simu-k .5 \
  --simu-rep 1 \
  --out inputs/gwas_simulation/Autism/Autism_sim_MACROD2
