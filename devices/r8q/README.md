# HakiOS on the Samsung Galaxy S20 FE (r8q)

> [!IMPORTANT]
> This port is a research project based on the [Pistachio-Project](https://github.com/Pistachio-Project) and [UniXNU](https://github.com/UniXNU/UniXNU) efforts. This repository is a port of the HakiOS project for the SM8250 Snapdragon 865 platform.

HakiOS runs iOS 16's own user space (SpringBoard, the stock apps) on the Samsung Galaxy S20 FE (r8q, " beyondthe"), on Apple's open-source XNU kernel with drivers written for this phone. The Galaxy S20 FE and Xiaomi Mi 10T/Pro are the same board (SM8250), but only the Mi 10T has been tried in HakiOS. The phone keeps booting Android normally, and iOS runs in a session started from a Linux PC over USB. A reboot brings Android back.

This is a research project, not a daily driver. It is not affiliated with Apple, and no Apple or Samsung files are in this repository: you fetch iOS from Apple's public servers and copy the firmware from your own phone (see [LEGAL.md](../../LEGAL.md)).

## What works

| Works | Not yet |
|---|---|
| Lock screen, home screen, Control Center, the stock apps | Cellular (calls, SIM, mobile data) |
| Touch screen, power and volume keys | Bluetooth |
| GPU-accelerated UI (Adreno 650, OpenGL ES through Mesa) | Metal |
| Speakers, both microphones (Voice Memos records) | Cameras |
| Vibration | Hardware video decoding |
| Wi-Fi: Settings lists networks and joins them | Booting iOS without a PC (in progress) |
| Battery level and charging | Keeping iOS's data between sessions (in progress) |
| Screen brightness from the slider | |

Some animations (home screen swipes, the app switcher) still stutter now and then; that is being worked on.

## What you need

- A **Samsung Galaxy S20 FE** (r8q) with an **unlocked bootloader**, running **LineageOS** (the port was brought up on LineageOS; other ROMs may keep the firmware elsewhere).
- In LineageOS: **Settings → System → Developer options**, turn on **USB debugging** and **Rooted debugging** (the firmware is read as root).
- A **Linux PC** (x86-64) with about **40 GB** free, a USB cable, and these installed: `adb` and `fastboot` (`android-tools`), `git`, `curl`, `python3` (with `venv`), `clang`, `lld`, `make`, `cc`, `flex`, `bison`, `m4`, `perl`, `autoconf`, `automake`, `meson`, `ninja`, `xz`, `lz4`, and `7z` (7-Zip 23 or newer).
- **theos** with its Linux toolchain and the **iPhoneOS16.5.sdk** (see [xnu-deps/setup.sh](../../xnu-deps/setup.sh)); the rest of the build tools are fetched for you.

## Step by step

All commands are run from the top of the repository.

**1. Get the code**

```sh
git clone -b r8q https://github.com/your-hakios-port/hakios.git hakios
cd hakios
```

**2. Fetch iOS 16 from Apple** (once; about 7.4 GB downloaded, unpacked into `sysimage/`)

```sh
sysimage/fetch.sh
```

**3. Copy the phone's firmware** (once; the phone in Android, on USB, Rooted debugging on)

```sh
devices/r8q/pull-firmware.sh
```

It fills `fw-gpu-r8q/`, `fw-audio-r8q/`, `fw-haptic-r8q/`, `fw-touch-r8q/` and `fw-wifi-r8q/` at the top of the repository (they stay out of git). It says if anything is missing.

**4. Wi-Fi details** (optional: without them Wi-Fi is off)

```sh
adb shell dumpsys wifi | grep wifi_sta_factory_mac_address     # the phone's own Wi-Fi address
echo 'AA:BB:CC:DD:EE:FF' > fw-wifi-apollo/mac                    # ... written here
printf '%s\n%s\n' 'MyNetwork' 'my passphrase' > fw-wifi-apollo/network   # optional
```

**5. Build HakiOS**

```sh
make loader
make phone
```

**6. Boot HakiOS**

```sh
make phone
```

or to boot from recovery:

```sh
./xl recovery
```

## What works detail

- **Display**: Adreno 650 GPU accelerated through Mesa, framebuffer console
- **Touch**: Screen touch input working
- **Power**: Power key, volume keys
- **Audio**: Both speakers and microphones (via WCD9380 SoundWire)
- **Wi-Fi**: PCIe-based Wi-Fi firmware loaded
- **GPU**: OpenGL ES and Vulkan support through Mesa

## What is still provisional

- The modem and the IPA are not brought up on this phone.
- The boot menu (`xnuloader/menu.c`), shown when the loader starts from `recovery` with no PC talking to it, has not run on the phone yet.
- Some driver configurations may need adjustment for the specific r8q board variants.

## Device specific notes

The r8q (Galaxy S20 FE) uses the same SM8250 SoC as the Xiaomi Mi 10T (apollo), so much of the SOC-level configuration is shared. The main differences are:

- Different device tree (r8q vs apollo)
- Different firmware partition layout
- Specific boot arguments for the r8q board