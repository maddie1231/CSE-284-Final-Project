external=/anvil/projects/x-mcb130189/rwang22/bican/ref
genome=GRCh38
ldsc=/home/x-rwang22/ldsc

prefix=$1
type=$2
bed=$3

#### 1. making annotation file 
cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/$type

[ -d "$prefix" ] || mkdir $prefix

cd $prefix

for i in {1..22} 
do
  echo "chr$i"
  python $ldsc/make_annot.py --bed-file $bed --bimfile $external/$genome/plink_files/1000G.EUR.hg38.$i.bim --annot-file $prefix.$i.annot.gz
done

#### 2. create custom partitioned LD score files 
# 03.22.2024 -- trying snps from hm3_no_MHC.list.txt; $external/hapmap3_snps/hm.$i.snp is incompatiable with baselineLD model in 3B
for i in {1..22} 
do
  echo "chr$i"
  python $ldsc/ldsc.py --l2 --bfile $external/$genome/plink_files/1000G.EUR.hg38.$i --ld-wind-cm 1 --annot $prefix.$i.annot.gz --thin-annot --out /anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore/$type/$prefix.$i --print-snps $external/hm3_no_MHC.list.txt
done