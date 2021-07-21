# Crash (19/07/2021) Cmdline Outputs and Commentary for Manjaro Forum Post

TITLE: Black screen of death while working aborad: "Failed to start Simple Desktop Display Manager" (kde)

Please help, I'm working but abroad and have broken my display manager (SSDM) such that I can only access my desktop through tty. I have looked though number of similar posts but none of the solutions seem to work for me. Some guideance would be really appriciated.

# Description
On startup: 

```“Error: Failed to start Simple Desktop Display Manager”``` 

(Note: sometimes it doesnt even show this message)

# System State (via tty1 (Ctrl + Alt + F4))

`> inxi -FZ`

```
system:    Host: nathans-x1-laptop Kernel: 5.10.36-2-MANJARO x86_64 bits: 64 Console: tty pts/0 (vt 2)
           Distro: Manjaro Linux
Machine:   Type: Laptop System: LENOVO product: 20TKCTO1WW v: ThinkPad X1 Extreme Gen 3 serial: <superuser required>
           Mobo: LENOVO model: 20TKCTO1WW v: 0B98417 WIN serial: <superuser required> UEFI: LENOVO
           v: N2VET26W (1.11 ) date: 11/16/2020
Battery:   ID-1: BAT0 charge: 30.9 Wh (43.9%) condition: 70.4/80.0 Wh (88.0%) volts: 15.2 min: 15.4
CPU:       Info: 6-Core model: Intel Core i7-10850H bits: 64 type: MT MCP cache: L2: 12 MiB
           Speed: 900 MHz min/max: 800/5100 MHz Core speeds (MHz): 1: 900 2: 900 3: 900 4: 900 5: 900 6: 900 7: 900
           8: 901 9: 900 10: 900 11: 900 12: 900
Graphics:  Device-1: Intel UHD Graphics driver: i915 v: kernel
           Device-2: NVIDIA TU117M [GeForce GTX 1650 Ti Mobile] driver: nvidia v: 460.80
           Device-3: IMC Networks Integrated Camera type: USB driver: uvcvideo
           Display: server: X.org 1.20.11 driver: loaded: modesetting,nvidia tty: 120x66
           Message: Advanced graphics data unavailable in console. Try -G --display
Audio:     Device-1: Intel Comet Lake PCH cAVS driver: sof-audio-pci
           Sound Server-1: ALSA v: k5.10.36-2-MANJARO running: yes
           Sound Server-2: PulseAudio v: 14.2 running: yes
Network:   Device-1: Intel Comet Lake PCH CNVi WiFi driver: iwlwifi
           IF: wlp0s20f3 state: up mac: 34:2e:b7:cd:02:7b
           IF-ID-1: anbox0 state: down mac: 0e:59:09:67:68:c0
Drives:    Local Storage: total: 471.36 GiB used: 108.64 GiB (23.0%)
           ID-1: /dev/nvme0n1 vendor: Samsung model: SSD 970 EVO Plus 250GB size: 232.89 GiB
           ID-2: /dev/nvme1n1 vendor: Samsung model: MZVLB256HBHQ-000L7 size: 238.47 GiB
Partition: ID-1: / size: 233.24 GiB used: 108.6 GiB (46.6%) fs: ext4 dev: /dev/nvme1n1p2
           ID-2: /boot/efi size: 511 MiB used: 36.2 MiB (7.1%) fs: vfat dev: /dev/nvme1n1p1
Swap:      Alert: No swap data was found.
Sensors:   System Temperatures: cpu: 46.0 C mobo: 40.0 C
           Fan Speeds (RPM): cpu: 0 fan-2: 0
Info:      Processes: 237 Uptime: 34m Memory: 31.12 GiB used: 1.08 GiB (3.5%) Init: systemd Shell: Zsh inxi: 3.3.04
nathan@nathans-x1-laptop:pts/0-> /home > nathan (0)
```

`> mhwd -l -d`

```
--------------------------------------------------------------------------------
> PCI Device: /devices/pci0000:00/0000:00:01.0/0000:01:00.0 (0300:10de:1f95)
  Display controller nVidia Corporation TU117M [GeForce GTX 1650 Ti Mobile]
--------------------------------------------------------------------------------
  > INSTALLED:

   NAME:        video-hybrid-intel-nvidia-prime
   ATTACHED:    PCI
   VERSION:     2020.11.30
   INFO:        Hybrid prime solution for NVIDIA Optimus Technology - Closed source NVIDIA driver & open source intel driver.
   PRIORITY:    6
   FREEDRIVER:  false
   DEPENDS:     video-modesetting
   CONFLICTS:   video*nvidia*
   CLASSIDS:    0300 0302 0300
   VENDORIDS:   10de 8086

   NAME:        video-modesetting
   ATTACHED:    PCI
   VERSION:     2020.01.13
   INFO:        X.org modesetting video driver.
   PRIORITY:    1
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *



  > AVAILABLE:

   NAME:        video-hybrid-intel-nvidia-prime
   ATTACHED:    PCI
   VERSION:     2020.11.30
   INFO:        Hybrid prime solution for NVIDIA Optimus Technology - Closed source NVIDIA driver & open source intel driver.
   PRIORITY:    6
   FREEDRIVER:  false
   DEPENDS:     video-modesetting
   CONFLICTS:   video*nvidia*
   CLASSIDS:    0300 0302 0300
   VENDORIDS:   10de 8086

   NAME:        video-nvidia
   ATTACHED:    PCI
   VERSION:     2020.11.30
   INFO:        Closed source NVIDIA drivers for linux.
   PRIORITY:    4
   FREEDRIVER:  false
   DEPENDS:     -
   CONFLICTS:   video*nvidia*
   CLASSIDS:    0300 0302
   VENDORIDS:   10de

   NAME:        video-linux
   ATTACHED:    PCI
   VERSION:     2018.05.04
   INFO:        Standard open source drivers.
   PRIORITY:    2
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300 0380 0302
   VENDORIDS:   1002 8086 10de

   NAME:        video-modesetting
   ATTACHED:    PCI
   VERSION:     2020.01.13
   INFO:        X.org modesetting video driver.
   PRIORITY:    1
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *

   NAME:        video-vesa
   ATTACHED:    PCI
   VERSION:     2017.03.12
   INFO:        X.org vesa video driver.
   PRIORITY:    0
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *


--------------------------------------------------------------------------------
> PCI Device: /devices/pci0000:00/0000:00:02.0 (0300:8086:9bc4)
  Display controller Intel Corporation UHD Graphics
--------------------------------------------------------------------------------
  > INSTALLED:

   NAME:        video-hybrid-intel-nvidia-prime
   ATTACHED:    PCI
   VERSION:     2020.11.30
   INFO:        Hybrid prime solution for NVIDIA Optimus Technology - Closed source NVIDIA driver & open source intel driver.
   PRIORITY:    6
   FREEDRIVER:  false
   DEPENDS:     video-modesetting
   CONFLICTS:   video*nvidia*
   CLASSIDS:    0300 0302 0300
   VENDORIDS:   10de 8086

   NAME:        video-modesetting
   ATTACHED:    PCI
   VERSION:     2020.01.13
   INFO:        X.org modesetting video driver.
   PRIORITY:    1
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *



  > AVAILABLE:

   NAME:        video-hybrid-intel-nvidia-prime
   ATTACHED:    PCI
   VERSION:     2020.11.30
   INFO:        Hybrid prime solution for NVIDIA Optimus Technology - Closed source NVIDIA driver & open source intel driver.
   PRIORITY:    6
   FREEDRIVER:  false
   DEPENDS:     video-modesetting
   CONFLICTS:   video*nvidia*
   CLASSIDS:    0300 0302 0300
   VENDORIDS:   10de 8086

   NAME:        video-linux
   ATTACHED:    PCI
   VERSION:     2018.05.04
   INFO:        Standard open source drivers.
   PRIORITY:    2
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300 0380 0302
   VENDORIDS:   1002 8086 10de

   NAME:        video-modesetting
   ATTACHED:    PCI
   VERSION:     2020.01.13
   INFO:        X.org modesetting video driver.
   PRIORITY:    1
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *

   NAME:        video-vesa
   ATTACHED:    PCI
   VERSION:     2017.03.12
   INFO:        X.org vesa video driver.
   PRIORITY:    0
   FREEDRIVER:  true
   DEPENDS:     -
   CONFLICTS:   -
   CLASSIDS:    0300
   VENDORIDS:   *


Warning: no configs for USB devices found!
```

`> systemctl status sddm.service status`

```
Unit status.service could not be found.
● sddm.service - Simple Desktop Display Manager
     Loaded: loaded (/usr/lib/systemd/system/sddm.service; enabled; vendor preset: disabled)
     Active: failed (Result: exit-code) since Mon 2021-07-19 11:22:01 AST; 6min ago
       Docs: man:sddm(1)
             man:sddm.conf(5)
    Process: 1513 ExecStart=/usr/bin/sddm (code=exited, status=1/FAILURE)
   Main PID: 1513 (code=exited, status=1/FAILURE)

Jul 19 11:22:01 nathans-x1-laptop systemd[1]: sddm.service: Scheduled restart job, restart counter is at 2.
Jul 19 11:22:01 nathans-x1-laptop systemd[1]: Stopped Simple Desktop Display Manager.
Jul 19 11:22:01 nathans-x1-laptop systemd[1]: sddm.service: Start request repeated too quickly.
Jul 19 11:22:01 nathans-x1-laptop systemd[1]: sddm.service: Failed with result 'exit-code'.
Jul 19 11:22:01 nathans-x1-laptop systemd[1]: Failed to start Simple Desktop Display Manager.
```



# Tried

- Removing video-vesa: `> sudo mhwd -r pci video-vesa`
```Error: config 'video-vesa' is not installed!```

- Reinstalling video-modesetting: `> sudo mhwd -i pci video-modesetting -f`

- checking `DEFAULT_SESSION` in `~/.xinitrc`: `DEFAULT_SESSION=startplasma-x11`

- Restarting display: `> startplasma-x11`
```$DISPLAY is not set or cannot connect to the X server.```

- Reinstalling graphics drivers: `sudo mhwd -a pci nonfree 0300 -f` (successful but no change)

- Deleting `/etc/X11/xorg.conf` 

# Possible Causes

- `optimus-manager` related (have tried uninstalling and reinstalling to no avail)
- kde ricing (was playing at time of break)
- kernel update (recently updated)  (how would I go about rolling this back?)
- `set-intel.tty` file missing (how can I generate?) 


# Bonus
Looking for an intermediate-friendly explaination of whats going wrong and possible fixes! 

Also if not possible to easily fix, how would I go about backing up whatever I can (e.g. home dir) an fresh installing?

Thx :) 


# References
- https://forum.manjaro.org/t/failed-to-start-simple-desktop-display-manager/1031
