# ROSMAP-APOE-methylation

Final output in [`methylation.long.tsv`](methylation.long.tsv).

According to the info [here](https://www.synapse.org/Synapse:syn3157275), data was generated using
the Infinium MethylationEPIC v2.0 Kit.

You can get hg38 annotation from [here](https://zwdzwd.github.io/InfiniumAnnotation), specifically
[this download](https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/EPICv2/EPICv2.hg38.manifest.tsv.gz).

Data was downloaded using Syanpse as follows:
```bash
module load synapseclient # If necessary

# ROSMAP_arrayMethylation_imputed.tsv.gz | Site-specific methylation values
synapse get --downloadLocation Data syn3168763

# ROSMAP_arrayMethylation_metaData.tsv  | cpg-position dictionary
synapse get --downloadLocation Data syn3168775

# ROSMAP_biospecimen_metadata.csv  | methID-to-donorID dictionary
synapse get --downloadLocation Data syn21323366

# ROSMAP_clinical.csv | APOE genotype data
synapse get --downloadLocation Data syn3191087

# Infinium EPIC v2 hg38 annotation
wget --directory Data https://github.com/zhou-lab/InfiniumAnnotationV1/raw/main/Anno/EPICv2/EPICv2.hg38.manifest.tsv.gz
```

And massaged together using [`combine-methylation-data.R`](combine-methylation-data.R)
```bash
module load R/4.4
Rscript combine-methylation-data.R
```

