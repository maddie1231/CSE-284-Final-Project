#Script to call GCTA to make genetic relationship matrix for 1000G EUR specific loci needed for the traits we are studying. (Paths point to files on lab cluster but references are included in ref folder on github)


/nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr6_HLA/chr6_HLA \
  --make-grm \
  --out chr6_HLA_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr3_FOXP1 \
  --make-grm \
  --out chr3_FOXP1_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr13_LINC \
  --make-grm \
  --out chr13_LINC_grm
  
  /nfs/lab/tscc/mpittigher/random/gcta-1.95.1-linux-x86_64/squashfs-root/usr/bin/gcta64 \
  --bfile /nfs/lab/tscc/mpittigher/random/new_plinks/chr20_MACROD2 \
  --make-grm \
  --out chr20_MACROD2_grm
