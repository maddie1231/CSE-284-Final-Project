#!/usr/bin/env bash
# =============================================================================
# 05_run_ldsc.sh
# Estimate SNP-based heritability using LDSC from GWAS summary statistics.
# Loops over all munged sumstats files and records runtime and memory.
#
# Usage:
#   bash scripts/05_run_ldsc.sh
#
# Expects:
#   data/sumstats/*.sumstats.gz    Munged sumstats from 04_prepare_sumstats.sh
#   data/ref/ld_scores/            Precomputed LD scores (e.g., 1000G EUR LD scores)
#   data/ref/weights/              LD score regression weights
#   tools/ldsc/ldsc.py             LDSC installation
#
# Outputs (written to results/ldsc/):
#   <trait>.log    LDSC log with h2 estimate
#   ldsc_timing.tsv  Runtime and memory per trait
# =============================================================================

set -euo pipefail

SUMSTATS_DIR="data/sumstats"
OUT_DIR="results/ldsc"
LDSC_DIR="tools/ldsc"
LD_SCORE_DIR="data/ref/ld_scores/eur_w_ld_chr/"   # 1000G EUR LD scores
WEIGHTS_DIR="data/ref/weights/weights.hm3_noMHC."  # LD score weights

TIMING_FILE="${OUT_DIR}/ldsc_timing.tsv"

mkdir -p "$OUT_DIR"

echo -e "trait\truntime_s\tpeak_mem_kb" > "$TIMING_FILE"

for sumstats_file in "${SUMSTATS_DIR}"/*.sumstats.gz; do
    trait=$(basename "$sumstats_file" .sumstats.gz)
    echo "  Running LDSC for ${trait}..."

    start_time=$(date +%s%N)

    /usr/bin/time -v python "${LDSC_DIR}/ldsc.py" \
        --h2 "$sumstats_file" \
        --ref-ld-chr "${LD_SCORE_DIR}" \
        --w-ld-chr "${WEIGHTS_DIR}" \
        --out "${OUT_DIR}/${trait}" \
        2> "${OUT_DIR}/${trait}.time.txt"

    end_time=$(date +%s%N)
    runtime_s=$(( (end_time - start_time) / 1000000000 ))

    peak_mem=$(grep "Maximum resident" "${OUT_DIR}/${trait}.time.txt" | awk '{print $NF}')
    echo -e "${trait}\t${runtime_s}\t${peak_mem}" >> "$TIMING_FILE"
done

echo "Done. LDSC results written to ${OUT_DIR}/"
