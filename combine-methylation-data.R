#!/usr/bin/env Rscript

library(data.table)

# Define region of interest
chromosome <- 19
lower_bound <- 45350000
upper_bound <- 45470000

# Read in data
meth <- fread('Synapse_Data/ROSMAP_arrayMethylation_imputed.tsv.gz')
cpgs <- fread('Synapse_Data/ROSMAP_arrayMethylation_metaData.tsv')
biospecimen <- fread('Synapse_Data/ROSMAP_biospecimen_metadata.csv')
clinical <- fread('Synapse_Data/ROSMAP_clinical.csv')


# Get intersection of IDs in both tables and subset to only this set
samplenames <- colnames(meth)[1:length(colnames(meth))]
usable_ids <- intersect(biospecimen$specimenID, colnames(meth))
biospecimen <- biospecimen[specimenID %in% usable_ids]
meth <- meth[, .SD, .SDcols=c('TargetID', usable_ids)]

# Merge in cpg position info
meth <- merge(meth, cpgs, by='TargetID')

# Massage data before plotting
clinical <- merge(biospecimen, clinical, by.x='individualID', by.y='individualID')
apoe <- clinical[, .SD, .SDcols=c( 'individualID', 'specimenID', 'msex', 'apoe_genotype')]


# Rename methylation columns to R##### ID
setnames(meth, apoe$specimenID, apoe$individualID)

# Define gene of interest

meth.subset <- meth[CHR==chromosome & MAPINFO %between% c(lower_bound, upper_bound)]

meth.long <- melt(meth.subset, 
                    measure.vars=apoe$individualID, 
                    variable.name='individualID', 
                    value.name='methylation_normalized')

meth.long <- merge(meth.long, apoe, by='individualID')[!is.na(apoe_genotype)]
setnames(meth.long, 'MAPINFO', 'POS')

meth.out <- meth.long[, .SD, .SDcols=c('individualID','CHR','POS','TargetID','CpG_Island','Island_Feature','msex','apoe_genotype','methylation_normalized')]
fwrite(meth.out, file='methylation.long.tsv', quote=F, row.names=F, col.names=T, sep='\t')