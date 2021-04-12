export ICON_THEME_NAME=ClassicOS-2000

all:	
	./build-icons.sh

install:	
	./install-icons.sh

clean:
	rm -r build
