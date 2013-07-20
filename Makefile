export MACOSX_DEPLOYMENT_TARGET=10.5
export ARCHS=-arch i386 -arch x86_64 #-arch ppc
export ROOT=`xcode-select -p`
export SYSROOT=$(ROOT)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk
export WARNINGS=-Wall -Wmost -Wextra -Wno-missing-braces -Wno-trigraphs -Werror
export CFLAGS=-g -isysroot $(SYSROOT) $(WARNINGS) -DNDEBUG
export LFLAGS=-g -isysroot $(SYSROOT)
#export CC=llvm-gcc-4.2
export CC=clang

DIRS=kext load mount plugin inst

all clean:
	@for i in $(DIRS); do\
		$(MAKE) -C $$i $(MAKEFLAGS) $@ || exit 1;\
	done

install:
	$(MAKE) -C inst install
