#

# A script to visualise the output of bsnp.py to identify sample swaps
# Based on output from https://github.com/DKFZ-ODCF/AlignmentAndQCWorkflows/blob/master/resources/analysisTools/qcPipeline/bsnp.py
# Usage: Rscript --vanilla plot_fingerprinting.R --args [fp_file1.fp] [fp_file2.fp] ...

library(pheatmap)
args = commandArgs(trailingOnly=TRUE)

cat(args, sep = "\n")

out_df <- data.frame()

for(i in 1:length(args)) {
  in_df <- read.table(args[i], sep="\t")
  names(in_df)[names(in_df) == 'V8'] <-  basename(args[i])
  if (ncol(out_df)<1){
    out_df <- as.data.frame(in_df[8])
  } else {
    out_df <- cbind(out_df,as.data.frame(in_df[8]))
  }
}

pdf("fingerprint.pdf", width=10, height=10)
pheatmap(as.matrix(out_df))
