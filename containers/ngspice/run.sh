#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
mkdir -p "${repo_root}/results/circuit"

docker build -t aiwa-pb3-ngspice "${repo_root}/containers/ngspice"
docker run --rm \
  -v "${repo_root}/kicad:/work:ro" \
  -v "${repo_root}/results/circuit:/results" \
  aiwa-pb3-ngspice \
  -b -o /results/pb3-architecture-sizing.log /work/pb3-architecture-sizing.cir
