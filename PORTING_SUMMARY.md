# Hakios r8q SM8250 Port

## Port Details

- **Target Device**: Samsung Galaxy S20 FE (codenamed `r8q`)
- **SoC**: Qualcomm SM8250 (Snapdragon 865)
- **iOS Version**: 16 (as requested; iOS 27 recommended for better compatibility)
- **Based on**: Xiaomi Mi 10T (apollo) SM8250 port

## Directory Structure

```
devices/r8q/
├── device.conf          - UEFI/Mu-Silicium configuration
├── boot-args.sh         - Driver boot arguments
├── soc.args             - SOC memory map and registers
├── README.md            - Device documentation
├── pull-firmware.sh     - Firmware extraction script
├── pull-soc.sh          - SoC information extraction script
├── soc/                 - SoC-specific configuration (populated as drivers added)
├── uefi/                - UEFI firmware (to be populated)
├── userland/            - iOS user space (to be populated)
├── wifi/                - WiFi drivers (to be populated)
├── xnu/                 - XNU kernel drivers (to be populated)
└── xnuloader/           - Boot loader (to be populated)
```

## Key Files

### device.conf
Configuration for the Mu-Silicium boot loader, specifying:
- UEFI_TARGET: r8q
- Mu: Mu-Silicium-r8q
- Firmware volume base addresses (FD_BASE, FD_SIZE, PAYLOAD_BASE)

### boot-args.sh
Boot arguments for the Hakios run script, enabling:
- Touch screen, buttons, battery, CPU/DDR
- GPU (Adreno 650), display at 60Hz
- Audio (APOLLO audio DSP 5), microphones
- Haptic feedback, WiFi, flip/page-flipping
- Charger configuration

### soc.args
SM8250 SoC configuration with memory addresses:
- IPA base, GSI base, IPCC, AOSS, resources
- MPSS memory, SMEM, IMEM
- IPA firmware (yupik_ipa_fws)

### README.md
Documentation covering:
- What works and what's still provisional
- Requirements (phone, Linux PC, tools)
- Step-by-step porting instructions
- Device-specific notes comparing r8q to apollo

## Porting Status

**Completed**:
- Device directory structure
- UEFI/MU configuration
- Boot arguments
- SOC memory map
- Documentation
- Firmware extraction scripts

**In Progress / Pending**:
- Building and running the loader
- Adding and testing drivers one at a time
- WiFi configuration
- Audio/DSP configuration
- Touch screen calibration
- GPU acceleration
- Battery status
- Cellular modem (not yet brought up)

## Next Steps

1. **Fetch iOS 16** from Apple's public servers
2. **Copy phone firmware** using `devices/r8q/pull-firmware.sh`
3. **Build the loader** with `make loader`
4. **Boot the kernel** with `make phone`
5. **Add drivers incrementally** following the Hakios porting guide
6. **Test and verify** each subsystem (display, touch, audio, WiFi, etc.)

## References

- Original port: Xiaomi Mi 10T (apollo) - https://github.com/enesuzun2002/hakios-apollo
- HakiOS documentation: https://hackios-web.vercel.app
- SM8250 SoC reference: UniXNU-sm8250-common project