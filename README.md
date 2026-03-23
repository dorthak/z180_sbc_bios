This project is a firmware boot loader, BIOS, and CP/M 2.2 s100computes z180 sbc board (https://s100computers.com/My%20System%20Pages/Z180%20SBC/Z180%20SBC1.htm).  The project is heavily based on the code created by John Winans in his z80 Retro project (https://github.com/Z80-Retro), modified for this hardware.

Version 1.0 is the first fully functional (if extremely limited) firmware, bios, and CP/M combo.  It supports only a single disk (as a partition on the board's SD card) and a single serial console (on the board's USB Port A). 

All development was done on a Raspberry Pi 3B running Raspberry Pi OS 13 (Trixie) 64-bit.  It should work fine on any other Linux-based system, and maybe others, but I've not tested it on any other platforms.

To flash the board's ROM you will need either a ROM programmer (I use XGecu T48 on a Windows PC using their native software) or a way to flash it in-system.  I switched to the latter by using John Winans' z80 Retro programmer (hardware and software here: https://github.com/Z80-Retro/2065-Z80-programmer) connected to the same RPi and my own adapter board (https://github.com/dorthak/z180_SBC_ISP_Adapter).

This project is currently designed to be assembled using the vasm assembler, found here: http://sun.hasenbraten.de/vasm/ and here: https://github.com/StarWolf3000/vasm-mirror  It needs to be built to support the oldstyle syntax module and the z80 CPU module.

See Makefile for assembler options.

Some other Makefile notes:

Be sure to edit `MakeInfo.default` with the correct paths and device names for your installation.  DO NOT USE AS-IS, some of the options can damage your host system if not set correctly.  

`make` or `make all` will build the firmware and the bios.  To build test programs, run, for example `make blinky1`.

`make clean` will delete all intermediate and compiled files.

`make flash` will install firmware.bin onto the z180 SBC board using a z80 Retro programmer.  Be sure to set a path to flash program in `MakeInfo.default`.

`make progs` will assemble (into COM files) several test programs in the progs directory.

`make install` will generate a file system to place on an SD card.  You must install cpm tools using `sudo apt install cpmtools` or equivalent, and you must have a valid diskdefs file in the correct location.  This will create a file system image that includes the BIOS/CPM, all of the files in the `cpm/filesystem/`directory, the files for the Adventure game located in the `adventure/adv-B03/` directory, any `.com` files in the `progs/` directory and any save files previously extracted with `make getsaves`

`make getsaves` downloads an image from the SD card and extracts `.SAV ` files, if any, into the `filesystem/saves` directory for later inclusion in `make install`

`make burn` will put the file system onto the SD card.  Be sure to look carefully at the `MakeInfo.default` to make certain the correct device is being written to, and that the code is being run on the correct device.  The settings there work on my RPi.  Getting this wrong can brick your computer!
