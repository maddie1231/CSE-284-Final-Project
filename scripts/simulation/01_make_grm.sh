#Script to call GCTA to make genetic relationship matrix for 1000G EUR chromosomes needed for the traits we are studying. (Files too large to upload on github, download yourself and change the paths to your downloaded 1000G data)

/usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr6 \
  --make-grm \
  --out grms/chr6_grm
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr3 \
  --make-grm \
  --out grms/chr3_grm
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr13 \
  --make-grm \
  --out grms/chr13_grm
  
  /usr/bin/time -v gcta64 \
  --bfile /path/to/your/downloaded/1000G/chr20 \
  --make-grm \
  --out grms/chr20_grm
