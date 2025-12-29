+++
title = "USB Capture in Linux"
description = "How to capture USB  in Linux"
date = 2025-12-29T12:15:00.000
authors = [ "tr1x_em" ]
draft = false

[taxonomies]
tags = [ "tutorials"]

[extra]
styles = []
accent_color = [ "orange", "hsl(184 100% 62.2%)" ]
banner = "banner.png"

+++

Today we will learn how to capture USB packets in Linux.

Follow along the video and copy commands from here

{{ youtube(id="UcMSPA5Q57Y") }}

> [!NOTE]
> All package name are for archlinux so for any other distro you
> might need to search google what it is

### STEP 1

#### Install wireshark or wireshark-qt

Do it according to your distro, then

**ONE TIME PROCESS**

- Add yourself to wireshark group - (**IMPORTANT**)

```bash
sudo groupadd wireshark
sudo usermod -a -G wireshark $USER
```

### STEP 2

#### Install usbmon

Do it according to your distro, then

**ONE TIME PROCESS**

- Add yourself to usbmon group - (**IMPORTANT**)

```bash
sudo groupadd usbmon
sudo usermod -a -G usbmon $USER
```

Then run this : (**IMPORTANT**)

It would let u capture usb packets without root permissions

```bash
sudo tee /etc/udev/rules.d/99-usbmon.rules <<'EOF'
SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger
```

> [!NOTE]
> You might need to logout and login again

### STEP 3

#### Load usbmon module

Run

```
sudo modprobe usbmon
```

It would load the kernel module

## STEP 4 - 6

- Capture USB packets
- Do the thing thats told to you
- Name the file and send it.

Voila, you have captured your USB packets 🫡
