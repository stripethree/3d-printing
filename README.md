# Adventures in 3D Printing

## Printer

[Creality CR-6 SE](https://www.creality.com/goods-detail/cr-6-se-3d-printer)

## Printer Modifications

## OctoPrint &amp; OctoDash

_Hardware_
- [Raspberry Pi 4B 2019](https://www.amazon.com/gp/product/B07TD42S27/ref=ppx_yo_dt_b_asin_title_o05_s00?ie=UTF8&psc=1)
- [Miuzel 4" 800x480 Touchscreen](https://www.amazon.com/gp/product/B07XBVF1C9/ref=ppx_yo_dt_b_asin_title_o06_s00?ie=UTF8&psc=1)
- [Raspberry Pi USB-C Power Supply](https://www.amazon.com/gp/product/B07W93C4Z9/ref=ppx_yo_dt_b_asin_title_o01_s01?ie=UTF8&psc=1)
- [Raspberry Pi Camera V2](https://www.amazon.com/gp/product/B01ER2SKFS/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1) with [2 Meter Flex Cable](https://www.amazon.com/gp/product/B00XW2NCKS/ref=ppx_yo_dt_b_asin_title_o01_s01?ie=UTF8&psc=1)

_Printed Parts_
- [Raspberry Pi 4B housing for Miuzei 800x480 4" Touchscreen for CR-6 SE](https://www.thingiverse.com/thing:4663911)

_Software_
- [OctoPrint](https://octoprint.org/)
- [OctoDash](https://github.com/UnchartedBull/OctoDash)
- [LCD Show](https://github.com/goodtft/LCD-show) for touchscreen drivers

_Setup_
- Followed [_Install Octoprint - In 5 Minutes - Raspberry Pi_](https://www.youtube.com/watch?v=mnN4HVmjafs) for OctoPrint
- Followed [_OctoDash - Octoprint Touch Screen App_](https://www.youtube.com/watch?v=kwo3HMBnqC4) for OctoDash

_Commands for formatting the the SD card on an OSX machine_

```
> diskutil list   // used to determined which disk label
> diskutil unmountDisk /dev/diskN
> sudo dd bs=1m if=path-to-octoprint-image.img of=/dev/rdiskN; sync
> sudo diskutil eject /dev/rdiskN
```

_Touchscreen Drivers_

Installing drivers for the touchscreen involved following _Step 2_ and _Step 3_ of the [`LCD_Show` README](https://github.com/goodtft/LCD-show#2-step2-clone-my-repo-onto-your-pi). The driver used was _4.0" HDMI Display(MPI4008)_. After opening an SSH connect to the Raspberry Pi:
```
sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo ./MHS40-show
```

After installing the driver, there was another issue to resolve, which was that the screen was not detected. Xorg was also raised a fatal error around a dependency.
```
[    40.507] (WW) Warning, couldn't open module fbturbo
[    40.507] (EE) Failed to load module "fbturbo" (module does not exist, 0)
[    40.507] (EE) No drivers available.
[    40.507] (EE) 
Fatal server error:
[    40.509] (EE) no screens found(EE) 
[    40.510] (EE) 
```

To resolve this, `xserver-xorg-video-fbturbo` was manually installed following the guidance of  [this Stackoverflow question](https://raspberrypi.stackexchange.com/questions/100169/xorg-not-working-after-upgrading-to-buster). Packages were upgraded based on the information in [this comment](https://raspberrypi.stackexchange.com/a/104524) and then the module was installed based on the command from [this comment](https://raspberrypi.stackexchange.com/a/101085). No pacages needed to be ugraded as this is also a part of the _Install Octoprint - In 5 Minutes - Raspberry Pi_ however it was worth checking since other software had been installed.

Additionally, based on [this comment](https://www.raspberrypi.org/forums/viewtopic.php?p=1685758&sid=e009eb13cab9b66145f1bc1dbea6f764#p1685758) from the Raspberry Pi forums, the resolution was manually set to 480x800 via `raspi-config`.

After these changes, the Raspberry Pi started up with OctoPrint and OctoDash in landscape format. Hooray!

## Printer Accessories

- [Printer Improvements](https://www.instructables.com/CR-6-SE-3D-Printer-Improvements/) 
- [Creaity CR-6 SE modifications](https://www.thingiverse.com/pandataco/collections/cr-6-se) _Thingiverse_

### Updates
- *TODO* - Firmware: [Marlin Community](https://github.com/CR6Community/Marlin) [v2.0.7.1 release 3](]https://github.com/CR6Community/Marlin/releases/tag/v2.0.7.1-cr6-community-release-3)

When formatting the micro SD card for the display firmware updates, the card must be no larger than 4GB and formatted FAT32 with a block size of 4096.
```
> diskutil unmountDisk /dev/disk2
> sudo newfs_msdos -F 32 -v CREALITY -b 4096 /dev/disk2s1
```

Several times during some trial and error I had micro SD cards become unreadable by OSX. This rendered them completely unsuable, even to Disk Utility. Erasing the disk at the command line fixed this.
```
diskutil eraseDisk FAT32 CREALITY MBRFormat disk2
```

### Resource Links
- [Creality CR-6 post-unboxing checklist](https://www.reddit.com/r/CR6/comments/ibwvvf/cr6_postunboxing_checklist/) _Reddit_
- [Marlin CommunityFireware](https://github.com/CR6Community/Marlin) _GitHub_


