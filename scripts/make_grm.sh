#Script to call GCTA to make genetic relationship matrix for 1000G EUR chromosomes needed for the traits we are studying. (Paths point to files on lab cluster)


/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6 \
  --make-grm \
  --out chr6_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.3 \
  --make-grm \
  --out chr3_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.13 \
  --make-grm \
  --out chr13_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/ref/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.20 \
  --make-grm \
  --out chr20_grm