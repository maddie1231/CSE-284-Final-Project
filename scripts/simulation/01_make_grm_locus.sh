#Script to call GCTA to make genetic relationship matrix for 1000G EUR specific loci needed for the traits we are studying.

/usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr6_HLA \
  --make-grm \
  --out inputs/grms/chr6_HLA_grm
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr3_FOXP1 \
  --make-grm \
  --out inputs/grms/chr3_FOXP1_grm
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr13_LINC \
  --make-grm \
  --out inputs/grms/chr13_LINC_grm
  
  /usr/bin/time -v gcta64 \
  --bfile inputs/filtered_plinks/chr20_MACROD2 \
  --make-grm \
  --out inputs/grms/hr20_MACROD2_grm
