#!/usr/bin/env bash
shopt -s nullglob
for g in `find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V`; do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;

## look for VGA compatible device matching your dGPU
## along with its partner audio device
## the PCI addresses will look like 
### 0000:03:00.0
## and the device id will look like
### 1002:7480
