#Script to filter actual GWAS sumstats to a list of significant rsids to use as "causal snps" in GWAS simulations to make simulations more realistic.

#T1D Sumstats - these sumstats have p val column so filter based on that and keep rsid list
awk -F'\t' '$2 < 5e-8 {print $1}' GCST90014023_buildGRCh38.tsv > T1D_causal_snps.txt
grep -v -E '^$|^NA$' T1D_causal_snps.txt | sort -u > T1D_causal_snps_clean.txt

# #Autism Spectrum - no p val column so filter on z score
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' Grove.NatGenet.2019.Autism_Spectrum_Disorder.sumstats > Autism_causal_snps.txt
grep -v -E '^$|^NA$' Autism_causal_snps.txt | sort -u > Autism_causal_snps_clean.txt

# #Schizophrenia sumstats: same format as autism sumstats, use z-score
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' PGC.Nature.2014.Schizophrenia.sumstats > Schizophrenia_causal_snps.txt
grep -v -E '^$|^NA$' Schizophrenia_causal_snps.txt | sort -u > Schizophrenia_causal_snps_clean.txt

#Anorexia sumstats: same format again, use z-score but not all rows have values for Z score so need to filter out those too.
awk 'NR==1 || (NF>=5 && ($4 > 5.45 || $4 < -5.45))' Watson.2018.NatGenet.Anorexia_Nervosa.sumstats > Anorexia_causal_snps.txt
awk '{print $1}' Anorexia_causal_snps.txt | grep -v -E '^$|^NA$' | sort -u > Anorexia_causal_snps_clean.txt

#MDD also has same sumstats format
awk 'NR==1 || ($4 > 5.45 || $4 < -5.45)' Wray.biorxiv.2018.Major_Depressive_Disorder.sumstats > MDD_causal_snps.txt
grep -v -E '^$|^NA$' MDD_causal_snps.txt | sort -u > MDD_causal_snps_clean.txt