#!/bin/bash

# Usage: [MAKEPNG=TRUE [MAKEICO=TRUE]] [MAKEFREEDESKTOP=TRUE] [VERBOSE=TRUE] ./build-icons.sh
#


ICON_THEME_NAME="${ICON_THEME_NAME:-ClassicOS2000}"

VERBOSE="${VERBOSE:-FALSE}"
MAKEFREEDESKTOP="${MAKEFREEDESKTOP:-TRUE}"
MAKEPNG="${MAKEPNG:-FALSE}"
MAKEICO="${MAKEICO:-FALSE}"
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
if [ $MAKEFREEDESKTOP = TRUE ]; then 

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
	for subdir in ${ICON_CATEGORIES[@]}; do
		if [ $VERBOSE = TRUE ]; then
			echo "Creating ${subdir} directory for ${size}..."
		fi
		mkdir -p "$STARTING_DIR/build/$ICON_THEME_NAME/$subdir/$size"
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
			iconcategory=`dirname $line`
			iconname=`basename $line`
			thisiconfile="$iconcategory/$size/$iconname.svg"
			if [ $FIRST = 0 ]; then
				cp "$STARTING_DIR/src/svg$size/$file.svg" "$STARTING_DIR/build/$ICON_THEME_NAME/$thisiconfile"
				
				FIRST=1
				ORIGINAL_FILE="$thisiconfile"
			else
				if [ $VERBOSE = TRUE ]; then
					echo " entering $STARTING_DIR/build/$ICON_THEME_NAME"
				fi

				cd "$STARTING_DIR/build/$ICON_THEME_NAME"

				if [ $VERBOSE = TRUE ]; then
					echo "Linking $ORIGINAL_FILE to $thisiconfile ..."
				fi
				ln -s "../../$ORIGINAL_FILE" "$thisiconfile"
				if [ ! $? = 0 ]; then
					echo "Failed to link $ORIGINAL_FILE to $thisiconfile (from list$size/$file)!"
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
fi


if [ $MAKEPNG = TRUE ]; then

	if [ -d "$STARTING_DIR/buildpng" ]; then
		if [ $VERBOSE = TRUE ]; then
			echo "Removing old buildpng directory..."
		fi
		rm -r "$STARTING_DIR/buildpng" 
	fi

	if [ $MAKEICO = TRUE ]; then
		if [ $VERBOSE = TRUE ]; then
			echo "Removing old buildico directory..."
		fi
		rm -r "$STARTING_DIR/buildico" 

	fi
	if [ $VERBOSE = TRUE ]; then
		echo "Building PNG iconset..."
	fi



	for size in ${ICON_SIZES[@]}; do
		if [ $VERBOSE = TRUE ]; then
			echo "Creating $STARTING_DIR/buildpng/$size..."
		fi
		mkdir -p "$STARTING_DIR/buildpng/$size"

		if [ $MAKEICO = TRUE ]; then
			if [ $VERBOSE = TRUE ]; then
				echo "Creating $STARTING_DIR/buildico/$size..."
			fi
			mkdir -p "$STARTING_DIR/buildico/$size"
		fi
		cd "$STARTING_DIR/src/list$size"
		for file in * ; do
				echo "Exporting images for $size/$file"
				inkscape  --export-dpi=96 --export-area-page  --export-type=png  "$STARTING_DIR/src/svg$size/$file.svg"
				mv "$STARTING_DIR/src/svg$size/$file.png" "$STARTING_DIR/buildpng/$size/$file-1x.png"

				inkscape --export-dpi=192 --export-area-page  --export-type=png "$STARTING_DIR/src/svg$size/$file.svg"
				mv "$STARTING_DIR/src/svg$size/$file.png" "$STARTING_DIR/buildpng/$size/$file-2x.png"

				inkscape --export-dpi=288 --export-area-page  --export-type=png  "$STARTING_DIR/src/svg$size/$file.svg" 
				mv "$STARTING_DIR/src/svg$size/$file.png" "$STARTING_DIR/buildpng/$size/$file-3x.png"
				
				inkscape --export-dpi=384 --export-area-page  --export-type=png  "$STARTING_DIR/src/svg$size/$file.svg"
				mv "$STARTING_DIR/src/svg$size/$file.png" "$STARTING_DIR/buildpng/$size/$file-4x.png"

				inkscape --export-dpi=512 --export-area-page  --export-type=png  "$STARTING_DIR/src/svg$size/$file.svg"
				mv "$STARTING_DIR/src/svg$size/$file.png" "$STARTING_DIR/buildpng/$size/$file-5.333x.png"

				convert "$STARTING_DIR/buildpng/$size/$file-1x.png" -colors 256 +dither png8:"$STARTING_DIR/buildpng/$size/$file-1x-256color.png"
				convert "$STARTING_DIR/buildpng/$size/$file-2x.png" -colors 256 +dither png8:"$STARTING_DIR/buildpng/$size/$file-2x-256color.png"
				convert "$STARTING_DIR/buildpng/$size/$file-1x.png" -colors 16 +dither png8:"$STARTING_DIR/buildpng/$size/$file-1x-16color.png"
				convert "$STARTING_DIR/buildpng/$size/$file-2x.png" -colors 256 +dither png8:"$STARTING_DIR/buildpng/$size/$file-2x-16color.png"
				
				if [ $MAKEICO = TRUE ]; then
					convert "$STARTING_DIR"/buildpng/*/$file-1x.png "$STARTING_DIR/buildpng/$size/$file-2x.png"  "$STARTING_DIR/buildpng/$size/$file-3x.png"  "$STARTING_DIR/buildpng/$size/$file-4x.png" "$STARTING_DIR/buildpng/$size/$file-5.333x.png" "$STARTING_DIR"/buildpng/*/$file-1x-256color.png "$STARTING_DIR"/buildpng/*/$file-1x-16color.png "$STARTING_DIR/buildico/$size/$file.ico"
				fi
		done
	done
fi
