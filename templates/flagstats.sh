#!/bin/bash

set -Eeuo pipefail

# Count up the number of aligned reads
samtools flagstats "${bam}" > "${shard_ix}.flagstats"
