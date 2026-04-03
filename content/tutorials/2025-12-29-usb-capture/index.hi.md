+++
title = "Linux में USB कैप्चर"
description = "Linux में USB कैप्चर कैसे करें"
date = 2025-12-29T12:15:00.000
authors = [ "tr1x_em" ]
draft = false

[taxonomies]
tags = [ "tutorials"]

[extra]
styles = []
accent_color = [ "orange", "hsl(200 100% 62.2%)" ]
banner = "banner.png"

+++

आज हम सीखेंगे कि Linux में USB पैकेट कैसे कैप्चर किए जाते हैं।

वीडियो के साथ चलें और यहाँ से कमांड्स कॉपी करें

{{ youtube(id="UcMSPA5Q57Y") }}

> [!NOTE]
> सभी पैकेज के नाम Archlinux के लिए हैं, इसलिए किसी अन्य डिस्ट्रो (distro) के लिए आपको Google पर खोजना पड़ सकता है कि वे क्या हैं।

### चरण 1

#### wireshark या wireshark-qt इंस्टॉल करें

इसे अपने डिस्ट्रो के अनुसार करें, फिर

**एक बार की प्रक्रिया (ONE TIME PROCESS)**

- खुद को wireshark ग्रुप में जोड़ें - (**महत्वपूर्ण**)

bash
sudo groupadd wireshark
sudo usermod -a -G wireshark $USER


### चरण 2

#### usbmon इंस्टॉल करें

इसे अपने डिस्ट्रो के अनुसार करें, फिर

**एक बार की प्रक्रिया (ONE TIME PROCESS)**

- खुद को usbmon ग्रुप में जोड़ें - (**महत्वपूर्ण**)

bash
sudo groupadd usbmon
sudo usermod -a -G usbmon $USER


फिर इसे चलाएं: (**महत्वपूर्ण**)

यह आपको रूट अनुमति (root permissions) के बिना USB पैकेट कैप्चर करने देगा

bash
sudo tee /etc/udev/rules.d/99-usbmon.rules <<'EOF'
SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger


> [!NOTE]
> आपको लॉग आउट करके दोबारा लॉग इन करने की आवश्यकता हो सकती है।

### चरण 3

#### usbmon मॉड्यूल लोड करें

चलाएं


sudo modprobe usbmon


यह कर्नेल मॉड्यूल को लोड कर देगा।

## चरण 4 - 6

- USB पैकेट कैप्चर करें
- वह काम करें जो आपको बताया गया है
- फ़ाइल को नाम दें और इसे भेजें।

वोइला (Voila), आपने अपने USB पैकेट कैप्चर कर लिए हैं 🫡
