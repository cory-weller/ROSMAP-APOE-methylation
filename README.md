# ROSMAP-APOE-methylation

`ROSMAP_arrayMethylation_covariates.tsv` synapse get syn5843544  

Methylation data from [https://doi.org/10.7303/syn3157275](https://doi.org/10.7303/syn3157275)



Data was downloaded using Syanpse as follows:
```bash
module load synapseclient # If necessary

# ROSMAP_arrayMethylation_imputed.tsv.gz | Site-specific methylation values
synapse get --downloadLocation Synapse_Data syn3168763

# ROSMAP_arrayMethylation_metaData.tsv  | cpg-position dictionary
synapse get --downloadLocation Synapse_Data syn3168775

# ROSMAP_biospecimen_metadata.csv  | methID-to-donorID dictionary
synapse get --downloadLocation Synapse_Data syn21323366

# ROSMAP_clinical.csv | APOE genotype data
synapse get --downloadLocation Synapse_Data syn3191087
```

And massaged together using [`combine-methylation-data.R`](combine-methylation-data.R)
```bash
module load R/4.4
Rscript combine-methylation-data.R
```

