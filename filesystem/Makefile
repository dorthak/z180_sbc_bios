.PHONY: all clean burn lsimg getsaves

-include ../MakeInfo.default


all: filesystem.img

filesystem.img: ../bios.bin ../cpm/filesystem/* ../adventure/adv-B03 ./saves/* ../progs/*.com
	rm -f filesystem.img
	mkfs.cpm -f $(DISKDEF) -b ../bios.bin filesystem.img
	cpmcp -f $(DISKDEF) filesystem.img ../cpm/filesystem/* 0:
	cpmcp -f $(DISKDEF) filesystem.img ../adventure/adv-B03/* 0:
	cpmcp -f $(DISKDEF) filesystem.img ./saves/* 0:
	cpmcp -f $(DISKDEF) filesystem.img ../progs/*.com 0:

clean:
	rm -f *.hex
	rm -f *.bin
	rm -f *.obj
	rm -f *.lst
	rm -f *.com
	rm -f *.tmp
	rm -f *.dep
	rm -f *.img
	rm -f *.com

# burn:
# 	sudo dd if=bios.bin of=/dev/sda1 bs=512
# 	sync

burn: filesystem.img
	@ if [ `hostname` != "$(SD_HOSTNAME)" -o ! -b "$(SD_DEV)" ]; then\
		echo "\nWARNING: You are either NOT logged into $(SD_HOSTNAME) or there is no $(SD_DEV) mounted!\n"; \
		false; \
	fi
	sudo dd if=$< of=$(SD_DEV) bs=512 conv=fsync
	sync

getsaves: 
	@ if [ `hostname` != "$(SD_HOSTNAME)" -o ! -b "$(SD_DEV)" ]; then\
		echo "\nWARNING: You are either NOT logged into $(SD_HOSTNAME) or there is no $(SD_DEV) mounted!\n"; \
		false; \
	fi
	rm -f filesystem.img
	sudo dd if=$(SD_DEV)  bs=512 conv=fsync count=1000 > filesystem.img
	
#	cpmls -f $(DISKDEF) filesystem.img
	cpmcp -f $(DISKDEF) -p filesystem.img  0:*.sav ./saves/


lsimg: filesystem.img
	cpmls -f $(DISKDEF) $^