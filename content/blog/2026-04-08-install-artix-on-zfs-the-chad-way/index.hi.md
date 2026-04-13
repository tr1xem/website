+++
title = "ZFS के साथ Artix को CHAD तरीके से इंस्टॉल करें"
description = "ZFSBootMenu के साथ ZFS पर Artix इंस्टॉल करें"
redirect_to = "@/content/blog/2026-04-08-install-artix-on-zfs-the-chad-way/index.md"

[taxonomies]
categories = [ "Featured" ]

[extra]
accent_color = [ "hsl(270 13% 48%)", "hsl(290 20% 71%)" ]
banner = "banner.png"
disclaimer = "यह पृष्ठ में ब्लैकजैक और हुकर्स, और इस तरह के खराब चुटकुले शामिल हैं।"

[extra.fediverse]
host = "mastodon.social"
user = "tr1x_em"
id = "116396462736866565"
+++

# परिचय

तो यह हमेशा की तरह ही हुआ—एक दिन मैं उठा और फैसला किया कि जिंदगी में अब मज़ा नहीं आ रहा है, **मुझे कुछ अलग करना चाहिए**। चूँकि मेरे पास बहुत खाली समय था (लिनक्स इंस्टॉल करने की सबसे बड़ी ज़रूरत ही असल में बेरोजगार होना है ~~मजाक कर रहा हूँ~~), मैंने अब तक का सबसे 'चैड' (Chad) लिनक्स सेटअप बनाने का फैसला किया। यह था ZFS[^1] के साथ Artix। आप पूछ सकते हैं क्यों? यही हम अगले सेक्शन में जानेंगे और अगर आप मेरी बकबक नहीं सुनना चाहते हैं, तो आप सीधे [Installation](#installation) सेक्शन पर जा सकते हैं {{ demoji(name="xdd") }}।

## प्रेरणा (Motivation)

![](pasted-image-1776064929480.webp)

यदि आप systemd विवाद के बारे में नहीं जानते हैं (तो बधाई हो, आपके पास नौकरी और असली जिंदगी है), तो बात बस इतनी है कि लोग systemd को पसंद नहीं करते। ज्यादातर लोग इसे एक इनिट सिस्टम (init system)[^2] के रूप में देखते हैं, लेकिन इसके बजाय यह हर चीज़ का एक ढेर जैसा है जिसमें नेटवर्किंग, कंटेनर (पता नहीं कैसे पर सच है) आदि शामिल हैं। मूल रूप से हम कह सकते हैं कि systemd केवल एक इनिट सिस्टम नहीं है—यह एक प्लेटफॉर्म है, और यही कारण है कि लोग तर्क देते हैं कि यह यूनिक्स (Unix) दर्शन को तोड़ता है जो कहता है "एक काम करो और उसे अच्छे से करो"। इसलिए "प्रति काम एक टूल" मिलने के बजाय आपको "कई कामों के लिए एक ईकोसिस्टम" मिलता है। <small>वैसे आप में से कुछ इसे अच्छी चीज़ भी मान सकते हैं, सच कहूँ तो मुझे नहीं पता कि आपको क्या बताऊँ</small> {{ demoji(name="dumb") }}। आप इसके बारे में [nosystemd](https://nosystemd.org/) पर और पढ़ सकते हैं <small>PS: इसका मुख्य योगदानकर्ता redhat है, समझदार को इशारा काफी है</small>।

और जैसा कि मैंने पहले बताया, मेरे दोस्त Gaspar[^3] ने मुझे स्विच करने का सुझाव दिया (या कह सकते हैं उकसाया) और हाँ, ज़ाहिर है कि मेरा आर्क इंस्टॉलेशन बहुत ज़्यादा फालतू चीज़ों (bloated) से भरा हुआ था {{ demoji(name="facecry") }}।

इन सब वजहों से मैं हफ़्तों तक 69+ विकी (wiki) पढ़ने में समय बर्बाद करता रहा ताकि ये जान सकूँ कि आखिर ZFS काम कैसे करता है... <small>और हाँ, उसके बाद भी मैं कई बार फेल हुआ</small>।

## ZFS ही क्यों, BTRFS क्यों नहीं?

ZFS वॉल्यूम मैनेजमेंट क्षमताओं वाला एक फाइल सिस्टम है, जिसका मतलब है कि अब फिक्स्ड साइज डिस्क पार्टीशन की झंझट खत्म (वैसे यह सुविधा आपको btrfs में भी मिलती है)। लेकिन जो चीज़ मुझे चाहिए थी, वह थी एन्क्रिप्शन... ठीक है, मैं किसी को LUKS चिल्लाते हुए सुन रहा हूँ, लेकिन मेरी बात तो सुनो—ZFS नेटिव एन्क्रिप्शन को सपोर्ट करता है जो आपको अपने डेटा को मैनेज करने की जबरदस्त आज़ादी देता है। जैसे कि आपके पास `tank` नाम का एक अन-एन्क्रिप्टेड पूल (pool) हो सकता है और उसमें `games` नाम का एक डेटासेट हो सकता है जो अन-एन्क्रिप्टेड है, लेकिन उसी पूल में आपके पास `personal` डेटासेट हो सकता है जो एन्क्रिप्टेड होगा। मेरे लिए यह दिमाग हिला देने वाला था कि मैं एक अन-एन्क्रिप्टेड पूल के अंदर अपने डेटा को सुरक्षित रखने के लिए कुछ एन्क्रिप्टेड डेटासेट रख सकता हूँ।

अन्य फीचर्स जैसे सेल्फ हीलिंग, रेड (raids) और स्नैपशॉट्स तो आपको कहीं भी मिल जाएंगे, लेकिन मेरे लिए नेटिव एन्क्रिप्शन ही मुख्य फीचर था जिसे मैं खोज रहा था।

खैर, आप में से कुछ तर्क दे सकते हैं कि zfs मॉड्यूल डिफ़ॉल्ट रूप से लिनक्स कर्नेल में नहीं आता है और यह बुरा है V: तो भाई जो पसंद हो वो इस्तेमाल करो मुझे कोई फर्क नहीं पड़ता <small>जब तक वह लिनक्स है (हालाँकि यहाँ हम आपको कूल नहीं कहेंगे)</small> {{ demoji(name="laughers") }}। और जो लोग सोच रहे हैं, उनके लिए बता दूँ कि अपने लाइसेंस के कारण ZFS कभी भी लिनक्स कर्नेल में शामिल नहीं किया जाएगा।

## Artix ही क्यों, Arch क्यों नहीं?

![](pasted-image-1776063125206.webp)

क्योंकि Luke Smith[^4] ने इस [वीडियो](https://www.youtube.com/watch?v=SVc6n5aOzy0) में कहा था कि Artix यूज़र्स Arch यूज़र्स से बेहतर होते हैं {{ demoji(name="smart") }}।

## ZFS की कमियां

{% alert(icon="info", title="महत्वपूर्ण", color="purple") %}
ZFS एक आउट-ऑफ-ट्री (out-of-tree) dkms मॉड्यूल है, और चूँकि लोग इसके फीचर्स के कारण इसका उपयोग करते हैं, इसलिए आपको Arch/Artix लिनक्स फ़ोरम पर इसके लिए सहायता नहीं मांगनी चाहिए।
{% end %}

निम्नलिखित जानकारी [Nwildner](https://nwildner.com/posts/2025-09-03-zfs-setup/) की पोस्ट से ली गई है क्योंकि उन्होंने सब कुछ बेहतरीन तरीके से संकलित किया है।

लिनक्स पर `ZFS` का उपयोग करने के अधिकांश नुकसान [इस](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system) Arch Wiki लेख में बताए गए हैं, लेकिन चलिए उन्हें दोहराते हैं:

- ZFS मेटाडेटा को एन्क्रिप्ट नहीं करता है, जिसका अर्थ है कि आपके पूल की कुछ बुनियादी संरचनाएं जैसे डेटासेट, स्नैपशॉट नाम, स्नैपशॉट पदानुक्रम और डिडुप्लीकेशन टेबल (हालाँकि डिडुप्लिकेटेड डेटा एन्क्रिप्टेड होता है) उपयुक्त टूल के साथ दिखाई दे सकते हैं।
- पूल बनाने के लिए डिस्क ज्योमेट्री (disk geometry) का ज्ञान होना आवश्यक है। NVMe के साथ ट्यूनिंग के कुछ दर्द कम हो गए हैं, लेकिन पूरी तरह नहीं।
- zvol के अंदर स्वैप (Swap) संभव नहीं है और यह एक [पुरानी और जानी-मानी समस्या](https://github.com/openzfs/zfs/issues/7734) है। आपको इसके साथ-साथ ZFS के अंदर स्वैपफाइल्स (swapfiles) के उपयोग से भी बचना चाहिए।
- क्रिप्टोग्राफी के लिए aes के अपने कार्यान्वयन के कारण ZFS में कुछ अड़चनें हैं और अतीत में कुछ प्रदर्शन (performance) संबंधी समस्याएं थीं जो अब ठीक कर दी गई हैं। उन्हें अपने स्वयं के तंत्र को लागू करना पड़ा क्योंकि वे कर्नेल एल्गोरिदम को नहीं छू सकते क्योंकि मॉड्यूल GPL के रूप में लाइसेंस प्राप्त नहीं है।
- आउट-ऑफ-ट्री कर्नेल मॉड्यूल। यह काफी स्पष्ट है, लेकिन यदि आप नहीं चाहते कि आपके साथ कोई अनहोनी हो (जैसे कि आपका मॉड्यूल initramfs में न जोड़ा जाए), तो कर्नेल इंस्टॉल प्रक्रिया के दौरान ध्यान दें या बेहतर अनुकूलता के लिए बस `linux-lts` का उपयोग करें।
- यदि आप लैपटॉप यूजर हैं, तो हाइबरनेट (सस्पेंड टू डिस्क) को पूरी तरह से बंद कर दें। अपने लैपटॉप को जगाना, अपने zfs पूल को इंपोर्ट करना और उसके बाद हाइबरनेट डेटा को स्वैप से वापस अपने डिस्क पर लाना संभवतः [आपके zfs पूल को खराब कर देगा](https://github.com/openzfs/zfs/issues/260#issuecomment-991912492)।

> [!NOTE]
> मैं आपको ZFS इंस्टॉल करने की सलाह तभी दूँगा जब आपके पास कम से कम 16GB रैम हो, क्योंकि ZFS का रैम उपयोग सामान्य पारंपरिक फाइल सिस्टम की तुलना में अधिक होता है।

तो अब आप इसकी कमियों को जान गए हैं, आइए इसे इंस्टॉल करने की प्रक्रिया शुरू करते हैं।

मेरे लिए, मैं Open-rc के साथ Artix को ZFS पर इंस्टॉल करूँगा। आप इसे लगभग किसी भी इनिट सिस्टम के लिए अनुकूलित कर सकते हैं।
**PS:** मैंने खुद इस गाइड को पढ़कर ही Artix इंस्टॉल किया था।

# स्थापना मार्गदर्शिका

![](pasted-image-1776063866373.webp)

## SSH सर्विस सेटअप करना

```bash
sudo -i # रूट (root) बनें
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
rc-service sshd start # ssh सर्विस शुरू की
ip -4 address show scope global # आईपी (IP) दिखाएगा
ssh root@192.168.1.10 # अकाउंट में SSH के जरिए लॉगिन करें
```

## Arch ZFS रेपो जोड़ना

```bash
# पैरेलल डाउनलोड बढ़ाकर इंस्टॉलेशन को तेज़ बनाएगा
sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
# /etc/pacman.conf में zfs arch रेपो जोड़ें
tee -a /etc/pacman.conf << 'EOF'
[archzfs]
# TODO: जब साइनिंग सिस्टम फाइनल हो जाए, तो इसे `Required` में बदल दें।
SigLevel = Never
Server = [https://github.com/archzfs/archzfs/releases/download/experimental](https://github.com/archzfs/archzfs/releases/download/experimental)
EOF
pacman -Sy --noconfirm archzfs-dkms && modprobe zfs
```

## सुचारू इंस्टॉलेशन के लिए एनवायरनमेंट वेरिएबल्स सेट करना

```bash
# टाइमज़ोन (Timezone)
INST_TZ=/usr/share/zoneinfo/Asia/Kolkata
# होस्टनेम (Hostname)
INST_HOST='artix'
INST_OS='artixlinux'
# माउंट पॉइंट
INST_MNT=/mnt
```

चुनें कि आप कौन सा कर्नेल इंस्टॉल करना चाहते हैं:

- linux
- linux-lts
- linux-zen
- linux-hardened

```bash
INST_LINVAR='linux-zen'
```

## पार्टिशन्स (Partitions) सेट करना

अब हमें 2 पार्टिशन्स की आवश्यकता है (जिन्हें आप `cfdisk` का उपयोग करके आसानी से बना सकते हैं):

- `part1` = EFI (512mb, क्योंकि यह केवल zfsbootmenu के लिए आवश्यक है)
- `part2` = Root (सुझाव है कि इसका प्रकार 'solaris root' रखें)

एक अच्छे पार्टिशन का उदाहरण:

```bash
$ fdisk -l /dev/sda
Device        Start      End  Sectors  Size Type
/dev/sda1      2048  1050623  1048576  512M EFI System
/dev/sda2   1050624 83884031 82833408 39.5G Solaris root
```

> [!NOTE]
> आपके मामले में यदि आप SSD का उपयोग कर रहे हैं, तो sda1 की जगह nvme0n1 होगा और पार्ट्स nvme0n1p1...p3 जैसे होंगे। यहाँ p1 का मतलब पार्टिशन 1 है।

डिस्क वेरिएबल्स को इस प्रकार सेट करें:

```bash
DISK=/dev/disk/by-id/nvme-foo_NVMe_bar_512GB
DISK_BOOT=${DISK}-part1
DISK_ROOT=${DISK}-part2
```

यह मानकर कि part1 (जिसे आपने p1 के रूप में देखा) EFI पार्टिशन है और part2 रूट है।

## Live ISO सेटअप करना

```bash
# होस्ट आईडी जेनरेट करें
zgenhostid
# पासफ़्रेज़ वह पासवर्ड है जो आपके फाइलसिस्टम को डिक्रिप्ट करने के लिए पूछा जाएगा
# मान लेते हैं कि rpool रूट पूल का नाम है
echo '<passphrase>' > /etc/zfs/rpool.key
chmod 000 /etc/zfs/rpool.key
```

## पार्टिशन्स सेटअप करना

### रूट पार्टिशन सेटअप करना (एन्क्रिप्शन के साथ)

```bash
zpool create \
      -o ashift=12 \
      -O acltype=posixacl \
      -O canmount=off \
      -O compression=zstd \
      -O dnodesize=auto \
      -O normalization=formD \
      -O relatime=on \
      -O xattr=sa \
      -O mountpoint=/ \
      -R $INST_MNT \
      -O encryption=aes-256-gcm \
      -O keylocation=file:///etc/zfs/rpool.key \
      -O keyformat=passphrase \
      rpool  \
      $DISK_ROOT
```

मैं यहाँ हर विकल्प को नहीं समझा सकता, लेकिन हम यहाँ `aes-256-gcm` एन्क्रिप्शन[^5] बना रहे हैं जिसे 'keylocation' पर मौजूद कुंजी का उपयोग करके अनलॉक किया जाएगा। हम प्रदर्शन और SSD की शुद्धता के लिए zstd कम्प्रेशन और 4K सेक्टर अलाइनमेंट का उपयोग कर रहे हैं। 'rpool' पूल का नाम है जो हमारे द्वारा सेट किए गए `$INST_MNT` वेरिएबल पर माउंट होगा।

> [!NOTE]
> मैं आपको 'keylocation' फ्लैग का उपयोग करने का सुझाव देता हूँ क्योंकि यह असुरक्षित नहीं है; आपकी कुंजी पहले से ही एक एन्क्रिप्टेड डिस्क में संग्रहीत है। यह केवल सिस्टम को आसानी से बूट करने की अनुमति देगा, अन्यथा आपको बूट करते समय 2 बार अपना पासवर्ड टाइप करना होगा। यदि आप ऐसा नहीं चाहते हैं, तो आप `keylocation=prompt` कर सकते हैं।

### बूट पार्टिशन्स (Boot partitions)

बूट पार्टिशन को fat32 के रूप में फॉर्मेट करें:

```plain
 mkfs.fat -n BOOT $DISK_BOOT
```

## डेटासेट्स (Datasets) सेटअप करना

मैं अपने रूट और डेटा को अलग-अलग डेटासेट में रखूँगा ताकि यदि मैं केवल डेटा का स्नैपशॉट लेना चाहूँ तो वह कर सकूँ।

कंटेनर डेटासेट्स बनाएँ:

```bash
zfs create -o canmount=off -o mountpoint=none rpool/ROOT
zfs create -o canmount=off -o mountpoint=none rpool/DATA
```

अब हम उस OS के नाम से एक डेटासेट बनाते हैं जिसे आप इंस्टॉल कर रहे हैं। क्यों? ताकि भविष्य में यदि आप उसी पूल पर एक अलग OS को डुअल बूट करना चाहें, तो आप बस उस OS के नाम का डेटासेट बनाकर ऐसा कर सकें।

```bash
 zfs create -o mountpoint=/ -o canmount=noauto rpool/ROOT/$INST_OS
```

रूट फाइलसिस्टम डेटासेट और बूट पार्टिशन को माउंट करें:

```bash
zfs mount rpool/ROOT/$INST_OS
mkdir -p $INST_MNT/boot/efi
mount $DISK_BOOT $INST_MNT/boot/efi
```

> [!WARNING]
> बूट पार्टिशन को `/boot` पर माउंट न करना महत्वपूर्ण है, क्योंकि इससे इंस्टॉलेशन अनबूट करने योग्य (unbootable) हो सकता है। बूट पार्टिशन में कर्नेल या ऐसी चीजें नहीं होंगी; आपको इसकी आवश्यकता केवल `zfsbootmenu` रखने के लिए होगी।

यूज़र डेटा को रूट फाइलसिस्टम से अलग करने के लिए डेटासेट्स बनाएँ:

```bash
zfs create -o mountpoint=/ -o canmount=off rpool/DATA/$INST_OS

for i in {usr,var,var/lib};
do
    zfs create -o canmount=off rpool/DATA/$INST_OS/$i
done

for i in {home,root,srv,usr/local,var/log,var/spool,var/tmp};
do
    zfs create -o canmount=on rpool/DATA/$INST_OS/$i
done

chmod 750 $INST_MNT/root
chmod 1777 $INST_MNT/var/tmp
```

अब आपके पास कुछ इस तरह की संरचना होनी चाहिए:

```bash
artix-live:[root]:/mnt# zfs list
NAME                                USED  AVAIL  REFER  MOUNTPOINT
rpool                              4.02M  37.8G   192K  /mnt
rpool/DATA                         2.25M  37.8G   192K  none
rpool/DATA/artixlinux              2.06M  37.8G   192K  /mnt
rpool/DATA/artixlinux/home          192K  37.8G   192K  /mnt/home
rpool/DATA/artixlinux/root          192K  37.8G   192K  /mnt/root
rpool/DATA/artixlinux/srv           192K  37.8G   192K  /mnt/srv
rpool/DATA/artixlinux/usr           384K  37.8G   192K  /mnt/usr
rpool/DATA/artixlinux/usr/local     192K  37.8G   192K  /mnt/usr/local
rpool/DATA/artixlinux/var           960K  37.8G   192K  /mnt/var
rpool/DATA/artixlinux/var/lib       192K  37.8G   192K  /mnt/var/lib
rpool/DATA/artixlinux/var/log       192K  37.8G   192K  /mnt/var/log
rpool/DATA/artixlinux/var/spool     192K  37.8G   192K  /mnt/var/spool
rpool/DATA/artixlinux/var/tmp       192K  37.8G   192K  /mnt/var/tmp
rpool/ROOT                          568K  37.8G   192K  none
rpool/ROOT/artixlinux               376K  37.8G   376K  /mnt
```

## पैकेज इंस्टॉलेशन

```bash
basestrap $INST_MNT base vim grub connman connman-openrc openrc elogind-openrc
```

कर्नेल और zfs कर्नेल मॉड्यूल इंस्टॉल करें:

```bash
# intel microcode वैकल्पिक है, इसे केवल तभी इंस्टॉल करें जब आपका डिवाइस इसे सपोर्ट करता हो
basestrap $INST_MNT $INST_LINVAR $INST_LINVAR-headers archzfs-dkms sudo efibootmgr wget intel-ucode
# यदि आपके कंप्यूटर में ऐसा हार्डवेयर है जिसे चलाने के लिए फर्मवेयर की आवश्यकता है
basestrap $INST_MNT linux-firmware sof-firmware
```

अपने कॉन्फ़िगरेशन को नए OS में कॉपी करना:

```bash
cp /etc/hostid $INST_MNT/etc

mkdir $INST_MNT/etc/zfs   # यदि यह पहले से मौजूद होने का संदेश आए तो कृपया अनदेखा करें
# rpool को अपने पूल के नाम से बदलें
cp /etc/zfs/rpool.key $INST_MNT/etc/zfs

cp /etc/pacman.conf $INST_MNT/etc/pacman.conf
cp /etc/resolv.conf $INST_MNT/etc/resolv.conf
echo $INST_HOST > $INST_MNT/etc/hostname

ln -sf $INST_TZ $INST_MNT/etc/localtime
echo "en_US.UTF-8 UTF-8" >> $INST_MNT/etc/locale.gen
echo "LANG=en_US.UTF-8" >> $INST_MNT/etc/locale.conf
```

माउंट पॉइंट्स सेटअप करें

हमें ZFS डेटाट्री के माउंट्स की आवश्यकता नहीं है और ZFS `zfs-magic` का उपयोग करके उन्हें स्वचालित रूप से संभाल लेता है।

```bash
fstabgen -U $INST_MNT | grep "/boot/efi" >> $INST_MNT/etc/fstab
```

## अपने इंस्टॉलेशन में Chroot करना

Chroot:

```bash
artix-chroot $INST_MNT
```

लोकेल्स (Locales) जेनरेट करें:

```bash
locale-gen
```

zpool.cache जेनरेट करें:

```bash
zpool set cachefile=/etc/zfs/zpool.cache rpool
```

रूट (root) पासवर्ड सेट करें:

```bash
passwd
```

### Initramfs सेटअप करना

अपनी `/etc/mkinitcpio.conf` फाइल एडिट करें

और ये भाग जोड़ें:

```bash
# rpool की कुंजी जोड़ना महत्वपूर्ण है
FILES=(/etc/zfs/rpool.key /boot/intel-ucode.img)
# fsck को हटा दें क्योंकि zfs को वास्तव में इसकी आवश्यकता नहीं है और यह कुछ कारणों से कर्नेल को कंपाइल नहीं होने देगा
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block zfs filesystems)
```

> [!CAUTION]
> हुक्स (hooks) में `zfs`, `filesystems` से पहले होना चाहिए अन्यथा बूट करते समय आपको rootfs एरर मिलेगा।

फिर Initramfs को फिर से जेनरेट करें

```bash
mkinitcpio -P
```

अपने लिए एक नया यूज़र बनाएँ:

```bash
useradd -m -G wheel -s /bin/bash trix
passwd trix
```

फिर visudo फ़ाइल एडिट करें:

```bash
EDITOR=vim visudo
```

और अनकमेंट (uncomment) करें ताकि आपका यूज़र sudo कमांड चला सके:

```plain
%wheel ALL=(ALL:ALL) ALL
```

## ZFS सर्विसेज सेटअप करना

zfs-openrc रेपो को क्लोन करें और स्क्रिप्ट को उनके सही स्थान पर ले जाएँ

```bash
git clone [https://gitlab.com/aur3675443/zfs-openrc](https://gitlab.com/aur3675443/zfs-openrc)
cd zfs-openrc
cp zfs-* /etc/init.d/
chmod +x /etc/init.d/zfs-*
```

फिर सर्विस को सक्रिय करें

```bash
rc-update add zfs-import boot ## (यह ज़रूरी है!)
rc-update add zfs-load-key boot ## (केवल तभी जब आपको इसकी आवश्यकता हो!)
rc-update add zfs-zed boot ## (यह ज़रूरी है!)
rc-update add zfs-mount boot ## (यह बहुत महत्वपूर्ण है!! अन्यथा zpool(s) इम्पोर्ट तो हो जाएंगे लेकिन माउंट नहीं होंगे!)
```

## बूटलोडर सेटअप करना

हमारे इस तरह के सेटअप के लिए [ZFSBootMenu](https://zfsbootmenu.org/)(उर्फ "ZBM") सबसे बेहतरीन विकल्प है। यह एक बहुत ही शानदार सॉफ्टवेयर है जो ZFS बूट एनवायरनमेंट के कई पहलुओं को प्रबंधित करता है और ZFS नेटिव एन्क्रिप्शन का समर्थन करता है। यदि चीजें गलत हो जाती हैं, तो यह सीधे स्नैपशॉट में बूट करने का भी समर्थन करता है।

### ZFS बूट कमांड लाइन सेटअप करना

```bash
zpool set bootfs=rpool/ROOT/artixlinux rpool
```

यह मानते हुए कि आपका सेटअप इस गाइड के समान है।

अब बूट कमांड सेटअप करें

```bash
zfs set org.zfsbootmenu:commandline="noresume init_on_alloc=0 rw spl.spl_hostid=$(hostid) video=1920x1080" rpool/ROOT
```

`video=1920x1080` फ्लैग आपकी स्क्रीन के आकार के अनुसार होना चाहिए।

### zfsbootmenu इंस्टॉल करना

ZBM को [AUR](https://aur.archlinux.org/packages?O=0&K=zfsbootmenu) द्वारा भी प्रदान किया जाता है लेकिन यह एक बहुत ही सरल EFI निष्पादन योग्य (executable) फाइल है और मैं इसे पैकेज मैनेजर के बाहर प्रबंधित करना पसंद करता हूँ।

```bash
mkdir -p /boot/efi/EFI/zbm
wget [https://get.zfsbootmenu.org/latest.EFI](https://get.zfsbootmenu.org/latest.EFI) -O /boot/efi/EFI/zbm/zfsbootmenu.EFI
```

अब ZBM की एंट्री के लिए EFI मेनू सेटअप करें, यह मानते हुए कि `disk` sda है (यह disk होनी चाहिए पार्टिशन नहीं) और `part` 1 है जिसका अर्थ है पहला पार्टिशन, इसे अपने अनुसार एडिट करें।

```bash
efibootmgr --disk /dev/sda --part 1 --create --label "ZFSBootMenu" --loader '\EFI\zbm\zfsbootmenu.EFI' --unicode "spl_hostid=$(hostid) zbm.timeout=3 zbm.prefer=rpool zbm.import_policy=hostid video=1920x1080" --verbose
```

## बाहर निकलें और सफाई करें

```bash
exit
umount /mnt/boot/efi
zpool export rpool
reboot
```

और उम्मीद है कि अब आप अपने बिल्कुल नए Artix इंस्टॉलेशन में बूट करेंगे।

# आगे क्या?

कुछ चीजें हैं जिन्हें मैं चाहता हूँ कि आप उनके बारे में पढ़ें और खुद सेटअप करें:

- [`zrepl`](https://zrepl.github.io/): zrepl ZFS रेप्लीकेशन के लिए एक वन-स्टॉप समाधान है। यह आपको स्वचालित रूप से स्नैपशॉट बनाने की अनुमति देगा ताकि चीजें गलत होने पर आप कभी भी बैकअप ले सकें। यहाँ [मेरा कॉन्फ़िगरेशन](https://github.com/tr1xem/dotfiles/blob/xmonad/system/etc/zrepl/zrepl.yml) है।
- [`ConnMan`](https://wiki.archlinux.org/title/ConnMan): एक कमांड-लाइन नेटवर्क मैनेजर जो Artix में आपकी मुख्य नेटवर्किंग उपयोगिता होगी (यह काफी आसान है)।
- [`Artix Wiki`](https://wiki.artixlinux.org/): यदि आप Artix से संबंधित कुछ भी सीखना चाहते हैं तो यह एक बेहतरीन संसाधन है।
- [`zram`](https://wiki.archlinux.org/title/Zram): रैम में एक कंप्रेस्ड ब्लॉक डिवाइस बनाने के लिए लिनक्स कर्नेल मॉड्यूल, ZFS का उपयोग करते समय बहुत उपयोगी है।

# निष्कर्ष

हमने अभी जो सेटअप इंस्टॉल किया है वह हर मामले में बेजोड़ (GOATED) है। आपको नेटिव एन्क्रिप्टेड रूट पूल के साथ एक systemd-मुक्त OS मिल रहा है, भला इससे ज्यादा और क्या चाहिए?

यहाँ मेरा सेटअप कुछ ऐसा दिखता है:

<fig>

![](pasted-image-1776061993092.webp)

<figcaption>Xmonad सेटअप</figcaption>

</fig>

यदि आपने मेरे [डेव सेटअप](blog/my-dev-setup-is-better-than-yours/) के बारे में पढ़ा है, तो आप जानते हैं कि मैं एक wayland उपयोगकर्ता था और हाँ मैंने X11 पर स्विच कर लिया है, यह स्विच अपरिहार्य था।

<fig>

![](pasted-image-1776062472003.webp)

<figcaption>ZFS सूची</figcaption>

</fig>

यद्यपि ये सभी एक ही पूल पर हैं, केवल एक ही एन्क्रिप्टेड है जो काफी अद्भुत है।

तो आज के लिए बस इतना ही, उम्मीद है कि आपने कुछ नया सीखा होगा। आपके सेटअप के बारे में जानकर खुशी होगी।
अगले ब्लॉग में मिलते हैं, तब तक अपना ख्याल रखें।

### फुटनोट्स (Footnotes)

[^1]: [ZFS](https://en.wikipedia.org/wiki/ZFS)

[^2]: [इनिट सिस्टम के बारे में और जानें](https://en.wikipedia.org/wiki/Init)

[^3]: [यदि आप मुझे कट्टर FreeBSD उपयोगकर्ता बनते हुए देखते हैं {{demoji(name="troll")}} तो कृपया उसे दोष दें](https://gasparvardanyan.github.io)

[^4]: [Luke Smith के बारे में और जानें](https://lukesmith.xyz)

[^5]: [AES-256-GCM: आधुनिक एन्क्रिप्शन का स्वर्ण मानक](https://petadot.com/blog/aes-256-gcm)
