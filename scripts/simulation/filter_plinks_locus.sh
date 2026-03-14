#T1D: Filter to HLA region on chr6
# plink2   
# --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6  \
# --chr 6  \
# --from-bp 25000000   \
# --to-bp 34000000  \
# --make-bed   \
# --out new_plinks/chr6_HLA \


#Anorexia
plink2 \
 --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.3 \
 --chr 3 \
 --from-bp 70000000 \
 --to-bp 72000000 \
 --make-bed \
 --out new_plinks/chr3_FOXP1
 
 #Autism
 plink2 \
 --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.20 \
 --chr 20 \
 --from-bp 14500000 \
 --to-bp 16000000 \
 --make-bed \
 --out new_plinks/chr20_MACROD2
 
 #MDD
 plink2 \
 --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.13 \
 --chr 13 \
 --from-bp 53000000 \
 --to-bp 55000000 \
 --make-bed \
 --out new_plinks/chr13_LINC