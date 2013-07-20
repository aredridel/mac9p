NAME=Mac9P
PKG=$(NAME).pkg

PKGROOT=/tmp/$(NAME)
KEDIR=$(PKGROOT)/System/Library/Extensions/9p.kext
FSDIR=$(PKGROOT)/System/Library/FileSystems/9p.fs
NPDIR=$(PKGROOT)/System/Library/FileSystems/NetFSPlugins/9p.bundle
MNDIR=$(PKGROOT)/usr/local/share/man/man8

PKGRESDIR=Package/Contents/Resources
PKGRESFILES=\
	License.rtf\
	Welcome.rtf\
	InstallationCheck\
	InstallationCheck.strings\
#	background.tiff\

PKGDEP=\
	../kext/9p\
	../mount/mount_9p\
	../load/load_9p\
	../plugin/9p\
	mount_9p.8\
	FSInfo.plist\
	KEInfo.plist\
	NPInfo.plist\
	$(PKGRESFILES)

all: pkg

$(PKG): $(PKGDEP)
	mkdir -p $(KEDIR)/Contents
	cp -pX KEInfo.plist $(KEDIR)/Contents/Info.plist
	mkdir -p $(KEDIR)/Contents/MacOS
	cp -pX ../kext/9p $(KEDIR)/Contents/MacOS/9p
	chmod 644 $(KEDIR)/Contents/MacOS/9p
	mkdir -p $(KEDIR)/Contents/Resources
	cp -pX ../load/load_9p $(KEDIR)/Contents/Resources
	mkdir -p $(FSDIR)/Contents
	cp -pX FSInfo.plist $(FSDIR)/Contents/Info.plist
	mkdir -p $(FSDIR)/Contents/Resources
	cp -pX ../mount/mount_9p $(FSDIR)/Contents/Resources
	mkdir -p $(PKGROOT)/usr/sbin
	ln -s /System/Library/FileSystems/9p.fs/Contents/Resources/mount_9p $(PKGROOT)/usr/sbin/mount_9p
	mkdir -p $(NPDIR)/Contents
	cp -pX NPInfo.plist $(NPDIR)/Contents/Info.plist
	mkdir -p $(NPDIR)/Contents/MacOS
	cp -pX ../plugin/9p $(NPDIR)/Contents/MacOS/9p
	mkdir -p $(MNDIR)
	cp -pX mount_9p.8 $(MNDIR)
	chmod u+s $(KEDIR)/Contents/Resources/load_9p
	pkgbuild \
		--root $(PKGROOT) \
		--identifier com.lab-fgb.9p \
		--ownership recommended \
		$@
	mkdir -p $(PKGRESDIR)
	cp -pX $(PKGRESFILES) $(PKGRESDIR)
	rm -fr $(PKGROOT)

clean:
	rm -fr *.pkg

pkg: $(PKG)

install: pkg
	sudo installer -pkg $(PKG) -target /
