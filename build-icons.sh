#!/bin/bash

ICON_THEME_NAME="${ICON_THEME_NAME:-ClassicOS2000}"
VERBOSE="${VERBOSE:-FALSE}"
STARTING_DIR=`pwd`
ICON_SIZES=(16 20 24 32 48)
ICON_CATEGORIES=(actions apps categories devices emblems mimes notifications panel places status stock tools)

if [ ! -e "$STARTING_DIR/build-icons.sh" ] ; then
	echo "You must run this script from the root of the repository."
	exit
fi

if [ ! -e "$STARTING_DIR/src" ] ; then
	echo "You must run this script from the root of the repository."
	exit
fi

if [ -d "$STARTING_DIR/build/$ICON_THEME_NAME" ]; then
	if [ $VERBOSE = TRUE ]; then
		echo "Removing old build directory..."
	fi
	rm -r "$STARTING_DIR/build/$ICON_THEME_NAME" 
fi

if [ $VERBOSE = TRUE ]; then
	echo "Creating directory structure..."
fi

for size in ${ICON_SIZES[@]}; do
	if [ $VERBOSE = TRUE ]; then
		echo "Creating ${size} directory..."
	fi
	for subdir in ${ICON_CATEGORIES[@]}; do
		if [ $VERBOSE = TRUE ]; then
			echo "Creating ${subdir} directory for ${size}..."
		fi
		mkdir -p "$STARTING_DIR/build/$ICON_THEME_NAME/$size/$subdir"
	done
done

if [ $VERBOSE = TRUE ]; then
	echo "Populating icons..."
fi

for size in ${ICON_SIZES[@]}; do
	cd "$STARTING_DIR/src/list$size"
	for file in * ; do
		FIRST=0
		ORIGINAL_FILE=''
		while read -r line
		do
			if [ $FIRST = 0 ]; then
				cp "$STARTING_DIR/src/svg$size/$file.svg" "$STARTING_DIR/build/$ICON_THEME_NAME/$size/$line.svg"
				FIRST=1
				ORIGINAL_FILE="../$line.svg"
				if [ $VERBOSE = TRUE ]; then
					echo " entering $STARTING_DIR/build/$ICON_THEME_NAME/$size"
				fi
			else

				cd "$STARTING_DIR/build/$ICON_THEME_NAME/$size"

				if [ $VERBOSE = TRUE ]; then
					echo "Linking $ORIGINAL_FILE to $line.svg ..."
				fi
				ln -s "$ORIGINAL_FILE" "$line.svg"
				if [ ! $? = 0 ]; then

					echo "Failed to link $ORIGINAL_FILE to $line.svg (from list$size/$file)!"
				fi

				cd "$STARTING_DIR/src/list$size"
			fi
		done < "$file"
	done
done

if [ $VERBOSE = TRUE ]; then
	echo "Copying index.theme..."
fi

cp "$STARTING_DIR/src/index.theme" "$STARTING_DIR/build/$ICON_THEME_NAME/index.theme"
