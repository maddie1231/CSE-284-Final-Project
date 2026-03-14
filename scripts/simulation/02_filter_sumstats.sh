#Script to filter actual GWAS sumstats to a list of significant rsids to use as "causal snps" in GWAS simulations to make simulations more realistic.

#T1D Sumstats
gunzip inputs/ldsc/sumstats/Chiou.Nature.2021.Type_1_diabetes.sumstats.gz
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' inputs/ldsc/sumstats/Chiou.Nature.2021.Type_1_diabetes.sumstats > T1D_causal_snps.txt
grep -v -E '^$|^NA$' T1D_causal_snps.txt | sort -u > T1D_causal_snps_clean.txt

#Autism Spectrum 
gunzip inputs/ldsc/sumstats/Grove.NatGenet.2019.Autism_Spectrum_Disorder.sumstats.gz
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' inputs/ldsc/sumstats/Grove.NatGenet.2019.Autism_Spectrum_Disorder.sumstats > Autism_causal_snps.txt
grep -v -E '^$|^NA$' Autism_causal_snps.txt | sort -u > Autism_causal_snps_clean.txt

#Schizophrenia sumstats:
gunzip inputs/ldsc/sumstats/PGC.Nature.2014.Schizophrenia.sumstats.gz
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' inputs/ldsc/sumstats/PGC.Nature.2014.Schizophrenia.sumstats > Schizophrenia_causal_snps.txt
grep -v -E '^$|^NA$' Schizophrenia_causal_snps.txt | sort -u > Schizophrenia_causal_snps_clean.txt

#Anorexia sumstats: 
gunzip inputs/ldsc/sumstats/Watson.2018.NatGenet.Anorexia_Nervosa.sumstats.gz
awk 'NR==1 || (NF>=5 && ($4 > 5.45 || $4 < -5.45))' inputs/ldsc/sumstats/Watson.2018.NatGenet.Anorexia_Nervosa.sumstats > Anorexia_causal_snps.txt
awk '{print $1}' Anorexia_causal_snps.txt | grep -v -E '^$|^NA$' | sort -u > Anorexia_causal_snps_clean.txt

#MDD also has same sumstats format
gunzip inputs/ldsc/sumstats/Wray.biorxiv.2018.Major_Depressive_Disorder.sumstats.gz
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' inputs/ldsc/sumstats/Wray.biorxiv.2018.Major_Depressive_Disorder.sumstats > MDD_causal_snps.txt
grep -v -E '^$|^NA$' MDD_causal_snps.txt | sort -u > MDD_causal_snps_clean.txt
