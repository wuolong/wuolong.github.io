# Dual-Boot Linux on Mac

There are many instructions online about how to install Linux on a Mac in a dual-boot
configuration. Some however are quite outdated. This one on
[MakeUseOf](https://www.makeuseof.com/tag/install-linux-macbook-pro/) is recent and
fairly easy to follow. It is a bit too verbose however so here is a simplified
version.

## Create a Bootable USB Drive with Linux 

- Decide upon the flavor of Linux (e.g., [Xubuntu](https://xubuntu.org)) and
  download the disk image (ISO) file.
- On a Mac, using Disk Utility to prepare a USB Drive with "MS DOS (FAT)" filesystem,
  and "GUID Partition Map".
- Use [Ethcer](https://www.balena.io/etcher/) to "flash" the image file to the USB
  drive. Note that afterwards MacOS will complain that the USB drive is not readable
  and offers to "initialize" it. Don't do that, select "Ignore" or "Eject" instead.

## Prepare a Partition for Linux

This can be done easily in Disk Utility without any data loss. To be on the safe
side, it's a good idea to keep a complete backup of the original system via Time
Machine or [Carbon Copy Cloner](https://bombich.com).

Note that newer Macs use [Apple File System
(APFS)](https://developer.apple.com/documentation/foundation/file_system/about_apple_file_system)
and Disk Utilities offers "Add Volume" as the default option. Ignore that and choose
"Partition" and create two partitions in "MS-DOS (FAT)" format:

- A main partition for Linux, say 160GB.
- A swap partition with the same size as the amount of memory (e.g., 8GB).

## Install Boot Manager

This is slightly more involved. To be able to install
[rEFind](https://sourceforge.net/projects/refind/) boot manager, we have to
temporarily disable SIP (System Integrity Protection) and re-enable it afterwards.

- Disable SIP
  - Restart and hold down **Command + R** to enter [Recovery Mode](https://support.apple.com/en-us/HT201314).
  - Select **Utilities** and launch **Terminal**
  - Run command `csrutil disable` and reboot.
- Install rEFind
  - Run command `refind-install` in Terminal. Root password is required.
- Re-enable SIP
  - The same process as before, run command `csrutil clear`.

## Install Linux

- With Linux Bootable USB plugged in, restart the Mac.
- Press down Option key which will present boot options.
- Use arrow keys to select **Boot EFI** option and press Enter to boot into Linux
  running from the USB drive. At this point, nothing has been installed to the hard
  drive yet.
- To start the actual installation, click the "Install Xubuntu" icon (that looks like
  a CD). 
- Select the option for "Install third party software for graphics and Wi-Fi hardware
  and additional media formats."
- For "Installation Type" (next screen), select "Something else" (rather than "Erase
  disk").
- On the next screen, select the partition to install Linux. It should be called
  `/dev/sda3`. Make sure that the size is what you have in mind so as not to erase
  the wrong partition. 
- Double click to select "Use as: Ext4 journaling file system", set the Mount point
  to `/` and check the box to "Format the partition". Click OK.
- Select the partition (`/dev/sda4`) for "Use as swap space".
- In the **Device for boot loader installation** dropdown menu, select the same main
  Linux partition (`/dev/sda3`)
- **Install Now** and follow prompts to choose a time zone and create a user account!
