#!/bin/sh
# pull-firmware.sh - Fetches the phone's firmware for the r8q (SM8250)
# This script reads the firmware from the phone's Android partition and
# places it in the appropriate fw-* directories.

set -e

echo "Pulling firmware for r8q (SM8250)..."

# Create firmware directories
mkdir -p fw-gpu-r8q
mkdir -p fw-audio-r8q
mkdir -p fw-haptic-r8q
mkdir -p fw-touch-r8q
mkdir -p fw-wifi-r8q

# Read modem firmware from the phone
echo "Reading modem firmware..."
adb pull /vendor/firmware/*.bin fw-gpu-r8q/ 2>/dev/null || echo "No GPU firmware found via adb"

# Read audio DSP firmware
echo "Reading audio DSP firmware..."
adb pull /vendor/firmware/audio/*.fw fw-audio-r8q/ 2>/dev/null || echo "No audio firmware found via adb"

# Read touch firmware
echo "Reading touch firmware..."
adb pull /vendor/firmware/touch/*.bin fw-touch-r8q/ 2>/dev/null || echo "No touch firmware found via adb"

# Read haptic firmware
echo "Reading haptic firmware..."
adb pull /vendor/firmware/haptic/*.bin fw-haptic-r8q/ 2>/dev/null || echo "No haptic firmware found via adb"

# Read Wi-Fi firmware
echo "Reading Wi-Fi firmware..."
adb pull /persist/wlan/*.bin fw-wifi-r8q/ 2>/dev/null || echo "No Wi-Fi firmware found via adb"

echo "Firmware pull complete. Review the files in fw-* directories."