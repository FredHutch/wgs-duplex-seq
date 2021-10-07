#!/bin/bash

set -Eeuo pipefail

echo "Specimen: $specimen"
echo "R1: $R1"
echo "R2: $R2"
echo "Reference genome index:"
echo "${ref}" | tr ' ' '\n'

# The ref variable contains all of the index files
# To get the base filename, we will find the file ending
# with .amb and strip off that suffix
GENOME=\$(echo "${ref}" | tr ' ' '\\n' | grep '.amb' | sed 's/.amb//' )
echo "Reference genome prefix: \$GENOME"

echo "Running BWA MEM"
bwa \
    mem \
    -a \
    -t ${task.cpus} \
    -T ${params.min_align_score} \
    -C \
    "\$GENOME" \
    ${R1} \
    ${R2} \
| samtools \
    sort \
    -m3G \
    --threads ${task.cpus} \
    -o aligned.bam -

echo "DONE"