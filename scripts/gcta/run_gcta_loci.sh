#!/usr/bin/env bash

# Estimate heritability using GCTA (LMM based approach)
# Runs on 5 simulated diseases. This time, we just run on one locus.
# Uses the following input files
#   GRM files: grms/chr{3,6,13,20}_<locus>_grm.*
#   Phenotype files: gwas_simulation/<trait>/<trait>_sim_<locus>.phen
# Creates the following analysis files
#   Heritability estimates: results/gcta/single_loci/<trait>_locus.hsq
#   Log files: results/gcta/single_loci/<trait>_locus.log
#   Runtime logs: results/gcta/single_loci/<trait>_locus.time.txt
#   Runtime and peak mem: results/gcta/single_loci/gcta_loci_timing.tsv

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
GRM_DIR="${REPO_DIR}/inputs/grms"
SIM_DIR="${REPO_DIR}/inputs/gwas_simulation"
OUT_DIR="${REPO_DIR}/results/gcta/single_loci"
TIMING_FILE="${OUT_DIR}/gcta_loci_timing.tsv"

mkdir -p "$OUT_DIR"

# Map each disease to its locus GRM and phen file suffix
declare -A DISEASE_LOCUS=(
    [Anorexia]=FOXP1
    [Autism]=MACROD2
    [MDD]=LINC
    [Schizophrenia]=HLA
    [T1D]=HLA
)

declare -A DISEASE_CHR=(
    [Anorexia]=3
    [Autism]=20
    [MDD]=13
    [Schizophrenia]=6
    [T1D]=6
)

declare -A DISEASE_PHEN_SUFFIX=(
    [Anorexia]=FOXP1
    [Autism]=MACROD2
    [MDD]=LINC
    [Schizophrenia]=HLA
    [T1D]=HLAregion
)

echo -e "trait\truntime_s\tpeak_mem_kb" > "$TIMING_FILE"

for disease in Anorexia Autism MDD Schizophrenia T1D; do
    chr="${DISEASE_CHR[$disease]}"
    locus="${DISEASE_LOCUS[$disease]}"
    phen_suffix="${DISEASE_PHEN_SUFFIX[$disease]}"
    grm="${GRM_DIR}/chr${chr}_${locus}_grm"
    phen_file="${SIM_DIR}/${disease}/${disease}_sim_${phen_suffix}.phen"
    echo "  Running ${disease} ${locus} locus (chr${chr})"

    start_time=$(date +%s%N)

    /usr/bin/time -v gcta64 \
        --grm "$grm" \
        --pheno "$phen_file" \
        --reml \
        --reml-no-constrain \
        --out "${OUT_DIR}/${disease}_locus" \
        2> "${OUT_DIR}/${disease}_locus.time.txt"

    end_time=$(date +%s%N)
    runtime_s=$(( (end_time - start_time) / 1000000000 ))

    peak_mem=$(grep "Maximum resident" "${OUT_DIR}/${disease}_locus.time.txt" | awk '{print $NF}')
    echo -e "${disease}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
done
