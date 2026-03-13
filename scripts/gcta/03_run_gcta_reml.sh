#!/usr/bin/env bash

# Estimate heritability using GCTA (LMM based approach)
# Runs on the 5 simulated diseases using per-chromosome GRMs.
# Uses the following input files
#   GRM files: grms/chr{3,6,13,20}_grm.*
#   Phenotype files: gwas_simulation/<trait>/<trait>_sim_chr*.phen
# Creates the following analysis files
#   Heritability estimates: <trait>.hsq
#   Log files: <trait>.log
#   Runtime logs: <trait>.time.txt
#   Runtime and peak mem: gcta_timing.tsv

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
GRM_DIR="${REPO_DIR}/grms"
SIM_DIR="${REPO_DIR}/gwas_simulation"
OUT_DIR="${REPO_DIR}/results/gcta/full_chromosome"
TIMING_FILE="${OUT_DIR}/gcta_timing.tsv"

mkdir -p "$OUT_DIR"

# # Map each disease to its chromosome GRM
# declare -A DISEASE_CHR=(
#     [Anorexia]=3
#     [Autism]=20
#     [MDD]=13
#     [Schizophrenia]=6
#     [T1D]=6
# )

DISEASES=(Anorexia Autism MDD Schizophrenia T1D)
CHRS=(3 20 13 6 6)

for i in "${!DISEASES[@]}"; do
    disease=${DISEASES[$i]}
    chr=${CHRS[$i]}
    echo "$disease chr$chr"
done

echo -e "trait\truntime_s\tpeak_mem_kb" > "$TIMING_FILE"

# for disease in Anorexia Autism MDD Schizophrenia T1D; do
#     chr="${DISEASE_CHR[$disease]}"
#     grm="${GRM_DIR}/chr${chr}_grm"
#     phen_file="${SIM_DIR}/${disease}/${disease}_sim_chr${chr}.phen"
#     echo "  Running ${disease} chr${chr}"

#     start_time=$(date +%s%N)

#     /usr/bin/time -v /Users/rosanwang/gcta-1.95.1-macOS-arm64/bin/gcta64 \
#         --grm "$grm" \
#         --pheno "$phen_file" \
#         --reml \
#         --reml-no-constrain \
#         --out "${OUT_DIR}/${disease}" \
#         2> "${OUT_DIR}/${disease}.time.txt"

#     end_time=$(date +%s%N)
#     runtime_s=$(( (end_time - start_time) / 1000000000 ))

#     peak_mem=$(grep "Maximum resident" "${OUT_DIR}/${disease}.time.txt" | awk '{print $NF}')
#     echo -e "${disease}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
# done


DISEASES=(Anorexia Autism MDD Schizophrenia T1D)
CHRS=(3 20 13 6 6)

for i in "${!DISEASES[@]}"; do
    disease=${DISEASES[$i]}
    chr=${CHRS[$i]}
    
    grm="${GRM_DIR}/chr${chr}_grm"
    phen_file="${SIM_DIR}/${disease}/${disease}_sim_chr${chr}.phen"
    
    echo "Running ${disease} chr${chr}"
    
    start_time=$(date +%s)

    gtime -v -o "${OUT_DIR}/${disease}.time.txt" \
        /Users/rosanwang/gcta-1.95.1-macOS-arm64/bin/gcta64 \
        --grm "$grm" \
        --pheno "$phen_file" \
        --reml \
        --reml-no-constrain \
        --out "${OUT_DIR}/${disease}"
    
    end_time=$(date +%s)
    runtime_s=$(( end_time - start_time ))
    
    peak_mem=$(grep "Maximum resident" "${OUT_DIR}/${disease}.time.txt" | awk '{print $NF}')
    echo -e "${disease}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
done
