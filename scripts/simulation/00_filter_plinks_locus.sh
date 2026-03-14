#Filters 1000G chromosome reference files to specific loci

mkdir inputs/filtered_plinks

#T1D: Filter to HLA region on chr6
 plink2   
 --bfile /path/to/your/downloaded/1000G/chr6  \
 --chr 6  \
 --from-bp 25000000   \
 --to-bp 34000000  \
 --make-bed   \
 --out inputs/filtered_plinks/chr6_HLA \


#Anorexia
plink2 \
 --bfile /path/to/your/downloaded/1000G/chr3 \
 --chr 3 \
 --from-bp 70000000 \
 --to-bp 72000000 \
 --make-bed \
 --out inputs/filtered_plinks/chr3_FOXP1
 
 #Autism
 plink2 \
 --bfile /path/to/your/downloaded/1000G/chr20 \
 --chr 20 \
 --from-bp 14500000 \
 --to-bp 16000000 \
 --make-bed \
 --out inputs/filtered_plinks/chr20_MACROD2
 
 #MDD
 plink2 \
 --bfile /path/to/your/downloaded/1000G/chr13 \
 --chr 13 \
 --from-bp 53000000 \
 --to-bp 55000000 \
 --make-bed \
 --out inputs/filtered_plinks/chr13_LINC
