#!/bin/sh
# pull-soc.sh - Extracts SoC-specific information for the r8q (SM8250)
# This script reads the device tree and extracts SoC configuration.

set -e

echo "Extracting SoC info for r8q (SM8250)..."

# The device tree blob
echo "Extracting device tree..."
adb pull /sys/firmware/fdt device-tree.dtb devices/r8q/ 2>/dev/null || echo "Could not pull device tree"

# Extract SOC configuration using hakios-device.py
echo "Running soc extraction..."
python3 tools/hakios-device.py soc devices/r8q --soc sm8250 --title "Samsung SM8250" --vendor Samsung --maintainer "yourname" --fdt devices/r8q/device-tree.dtb

echo "SoC extraction complete."