#!/bin/bash

VCF_FILE="$1"

#test to see if the file is provided
if [ -z "$VCF_FILE" ]; then
    echo "Error: please provide a VCF file"
    exit 1
fi

#test to see if the file exist
if [ ! -f "$VCF_FILE" ]; then
    echo "Error: File '$VCF_FILE' not found"
    exit 1
fi

#test to see if the file format is correct
if [[ "$VCF_FILE" != *.vcf ]]; then
    echo "Error: File must end in .vcf"
    exit 1
fi

#counter
TOTAL=$(grep -vc "^#" "$VCF_FILE")
SNP=$(grep -v "^#" "$VCF_FILE" | awk -F'\t' 'length($4)==1 && length($5)==1' | wc -l)
INSER=$(grep -v "^#" "$VCF_FILE" | awk -F'\t' 'length($4)<length($5)' | wc -l)
DEL=$(grep -v "^#" "$VCF_FILE" | awk -F'\t' 'length($4)>length($5)' | wc -l)

#report
echo "SNPs: $SNP"
echo "Insertions: $INSER"
echo "Deletions: $DEL"
echo "Total variants: $TOTAL"

