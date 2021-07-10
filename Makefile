#
# Copyright (C) 2020-2021 HandsomeMod Project
# 
# GPLV2 License
#

uname_r=$(shell uname -r)

# If KERNELRELEASE is defined, we've been invoked from the
# kernel build system and can use its language
ifneq ($(KERNELRELEASE),)
snd-soc-ac108-objs := ac108.o

obj-m += snd-soc-ac108.o

ifdef DEBUG
ifneq ($(DEBUG),0)
	ccflags-y += -DDEBUG -DAC101_DEBG
endif
endif



else

DEST := /lib/modules/$(uname_r)/kernel

all:
	make -C /lib/modules/$(uname_r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(uname_r)/build M=$(PWD) clean

install:
	sudo cp snd-soc-ac108.ko ${DEST}/sound/soc/codecs/
	sudo depmod -a


.PHONY: all clean install

endif

