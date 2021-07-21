l>:W
:QA--lines=50 /var/log/Xorg.0.log
[  6970.988] (**) Option "_source" "server/udev"
[  6971.045] (II) mouse0  - not using input device '/dev/input/mouse0'.
[  6971.045] (EE) libinput: SynPS/2 Synaptics TouchPad: Failed to create a device for /dev/input/mouse0
[  6971.045] (EE) PreInit returned 2 for "SynPS/2 Synaptics TouchPad"
[  6971.045] (II) UnloadModule: "libinput"
[  6971.046] (II) config/udev: Adding input device TPPS/2 Elan TrackPoint (/dev/input/event14)
[  6971.046] (**) TPPS/2 Elan TrackPoint: Applying InputClass "evdev pointer catchall"
[  6971.046] (**) TPPS/2 Elan TrackPoint: Applying InputClass "libinput pointer catchall"
[  6971.046] (II) Using input driver 'libinput' for 'TPPS/2 Elan TrackPoint'
[  6971.046] (**) TPPS/2 Elan TrackPoint: always reports core events
[  6971.046] (**) Option "Device" "/dev/input/event14"
[  6971.046] (**) Option "_source" "server/udev"
[  6971.048] (II) event14 - TPPS/2 Elan TrackPoint: is tagged by udev as: Mouse Pointingstick
[  6971.049] (II) event14 - TPPS/2 Elan TrackPoint: device is a pointer
[  6971.052] (II) event14 - TPPS/2 Elan TrackPoint: device removed
[  6971.125] (**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/serio2/input/input10/event14"
[  6971.125] (II) XINPUT: Adding extended input device "TPPS/2 Elan TrackPoint" (type: MOUSE, id 17)
[  6971.125] (**) Option "AccelerationScheme" "none"
[  6971.125] (**) TPPS/2 Elan TrackPoint: (accel) selected scheme none/0
[  6971.125] (**) TPPS/2 Elan TrackPoint: (accel) acceleration factor: 2.000
[  6971.125] (**) TPPS/2 Elan TrackPoint: (accel) acceleration threshold: 4
[  6971.127] (II) event14 - TPPS/2 Elan TrackPoint: is tagged by udev as: Mouse Pointingstick
[  6971.128] (II) event14 - TPPS/2 Elan TrackPoint: device is a pointer
[  6971.132] (II) config/udev: Adding input device TPPS/2 Elan TrackPoint (/dev/input/mouse5)
[  6971.132] (II) No input driver specified, ignoring this device.
[  6971.132] (II) This device may have been added with another device file.
[  6971.133] (II) config/udev: Adding input device PC Speaker (/dev/input/event5)
[  6971.133] (II) No input driver specified, ignoring this device.
[  6971.133] (II) This device may have been added with another device file.
[  6971.138] (II) config/udev: Adding input device ThinkPad Extra Buttons (/dev/input/event4)
[  6971.138] (**) ThinkPad Extra Buttons: Applying InputClass "evdev keyboard catchall"
[  6971.138] (**) ThinkPad Extra Buttons: Applying InputClass "libinput keyboard catchall"
[  6971.138] (**) ThinkPad Extra Buttons: Applying InputClass "system-keyboard"
[  6971.138] (**) ThinkPad Extra Buttons: Applying InputClass "keyboard defaults"
[  6971.138] (II) Using input driver 'libinput' for 'ThinkPad Extra Buttons'
[  6971.138] (**) ThinkPad Extra Buttons: always reports core events
[  6971.138] (**) Option "Device" "/dev/input/event4"
[  6971.138] (**) Option "_source" "server/udev"
[  6971.140] (II) event4  - ThinkPad Extra Buttons: is tagged by udev as: Keyboard Switch
[  6971.140] (II) event4  - ThinkPad Extra Buttons: device is a keyboard
[  6971.140] (II) event4  - ThinkPad Extra Buttons: device removed
[  6971.165] (**) Option "config_info" "udev:/sys/devices/platform/thinkpad_acpi/input/input5/event4"
[  6971.165] (II) XINPUT: Adding extended input device "ThinkPad Extra Buttons" (type: KEYBOARD, id 18)
[  6971.165] (**) Option "xkb_model" "pc105"
[  6971.165] (**) Option "xkb_layout" "gb"
[  6971.165] (**) Option "xkb_options" "caps:escape"
[  6971.167] (II) event4  - ThinkPad Extra Buttons: is tagged by udev as: Keyboard Switch
[  6971.167] (II) event4  - ThinkPad Extra Buttons: device is a keyboard
[  7576.714] (EE) event8  - SynPS/2 Synaptics TouchPad: kernel bug: Touch jump detected and discarded.
See https://wayland.freedesktop.org/libinput/doc/1.17.1/touchpad-jumping-cursors.html for details


