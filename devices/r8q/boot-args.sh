# The r8q's boot-args, for run.sh (a run from a PC) and mk-recovery.sh (iOS from the phone): sourced, from the
# top of the repository. ARGS set beforehand replaces the drivers' list.
# every driver of the phone (devices/r8q/xnu, devices/r8q/README.md says what each does)
ARGS=${ARGS-"r8q_touch=1 r8q_buttons=1 r8q_battery=1 r8q_cpufreq=1 r8q_ddr=1 r8q_audio=5 r8q_mic=4 r8q_mic_ns=1 r8q_mic_drc=0 r8q_gpu=21 \\
r8q_gpu_use=1 gpu_recover=1 r8q_backlight=50 r8q_gpu_speed=1 r8q_display=1 r8q_display_hz=60 \\
r8q_haptic=5 r8q_wifi=5 r8q_wifi_rddm=0 wifi_bdf_phone=1 wifi_station=1 r8q_flip=1 \\
r8q_gpu_present=1 r8q_charger=3"}
# the radio's address, kept beside the phone's Wi-Fi firmware (one line, AA:BB:CC:DD:EE:FF)
if [ -f fw-wifi-r8q/mac ]; then ARGS="$ARGS wifi_mac=$(head -1 fw-wifi-r8q/mac)"; fi