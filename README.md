# VCF Variant Counter
This project implements a Bash script that reads a VCF file and counts the number of different variant types.

The script classifies variants into three categories:
- SNPs
- Insertions
- Deletions

It also reports the total number of variants in the file.

## Usage
Run the script with a VCF file as input: 
./vcf_counter.sh input.vcf

Example: 
./vcf_counter.sh ~/programming_project/data/variants.vcf

## Input
The script expects a standard VCF (Variant Call Format) file.

Header lines beginning with "#" are ignored.
Variant lines are parsed using the REF and ALT columns.

## Output
The script prints the number of:
- SNPs
- Insertions
- Deletions
- Total variants

Example output: 
SNPs: 9 
Insertions: 5 
Deletions: 6 
Total variants: 20 

## Testing
The repository includes a test script that runs several test cases.

Run tests with: 
./test.sh 

The tests include:
- normal input
- edge case (header only)
- error cases (missing arguments, nonexistent file)
