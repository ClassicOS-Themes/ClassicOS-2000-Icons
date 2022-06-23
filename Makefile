export ICON_THEME_NAME=ClassicOS-2000
freedesktop:
	VERBOSE=TRUE ./build-icons.sh

png:
	MAKEPNG=TRUE VERBOSE=TRUE MAKEFREEDESKTOP=FALSE ./build-icons.sh

ico:
	MAKEPNG=TRUE MAKEICO=TRUE MAKEFREEDESKTOP=FALSE ./build-icons.sh

all:	
	MAKEPNG=TRUE MAKEICO=TRUE VERBOSE=TRUE ./build-icons.sh


install:	
	./install-icons.sh

clean:
	rm -r build
	rm -r buildpng
	rm -r buildico
