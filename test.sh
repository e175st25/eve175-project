#!/bin/bash

PASS=0
FAIL=0

# Test 1: Normal input -- header and variants
cat > /tmp/test_variants.vcf << 'EOF'
##fileformat=VCFv4.2
#CHROM POS ID REF ALT QUAL FILTER INFO
chr1 100 . A G 50 PASS .
chr1 200 . AT A 40 PASS .
chr1 300 . C CGA 45 PASS .
chr1 400 . T C 60 PASS .
EOF

expected="SNPs: 2
Insertions: 1
Deletions: 1
Total variants: 4"

actual=$(./vcf_counter.sh /tmp/test_variants.vcf)

if [ "$actual" = "$expected" ]; then
    echo "PASS: correct output for normal input"
    ((PASS++))
else
    echo "FAIL: wrong output for normal input"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((FAIL++))
fi

# Test 2: Edge case  -- header only
cat > /tmp/test_empty.vcf << 'EOF'
##fileformat=VCFv4.2
#CHROM POS ID REF ALT QUAL FILTER INFO
EOF

expected="SNPs: 0
Insertions: 0
Deletions: 0
Total variants: 0"

actual=$(./vcf_counter.sh /tmp/test_empty.vcf)

if [ "$actual" = "$expected" ]; then
    echo "PASS: handles header only "
    ((PASS++))
else
    echo "FAIL: wrong output for header only"
    ((FAIL++))
fi

# Test 3: Error case - no arguments
./vcf_counter.sh > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "PASS: exits with error when no arguments given"
    ((PASS++))
else
    echo "FAIL: should exit with error when no arguments given"
    ((FAIL++))
fi

# Test 4: Error case - nonexistent file
./vcf_counter.sh /tmp/no_file.vcf > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "PASS: exits with error for nonexistent file"
    ((PASS++))
else
    echo "FAIL: should exit with error for nonexistent file"
    ((FAIL++))
fi

# Clean up
rm -f /tmp/test_variants.vcf /tmp/test_empty.vcf

echo ""
echo "Results: $PASS passed, $FAIL failed"
