# CSE-284-Final-Project
LMMs vs LDSC for Heritability Estimation in CEU




Simulate GWAS Phenotypes using GCTA

Input: 1000G Euro 
# Simulate a quantitative trait with the heritability of 0.5 for 3 times
gcta64  --bfile test  --simu-qt  --simu-hsq 0.5 --simu-rep 3 --out test
