external=/anvil/projects/x-mcb130189/rwang22/bican/ref/GRCh38
ldsc=/home/x-rwang22/ldsc

cts_name=$1

#### 3. partition heritability 
GWAS=/anvil/scratch/x-rwang22/bican/ref/ldsc

output=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/output/${cts_name}

[ -d "$output" ] || mkdir $output

for trait in $GWAS/*.sumstats.gz; do
    filename=$(basename "$trait")
    basename="${filename%.sumstats.gz}"
    echo "Processing $basename"
    sbatch -p shared --mem=50g --time=02:00:00 --nodes=1 --error=%x_%j.err --wrap="python $ldsc/ldsc.py --h2-cts ${trait} --ref-ld-chr $external/baselineLD_v2.2/baselineLD. --out ${output}/${basename}_${cts_name} --ref-ld-chr-cts $cts_name --w-ld-chr $external/weights/weights.hm3_noMHC."
done