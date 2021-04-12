ICON_THEME_NAME="${ICON_THEME_NAME:-ClassicOS2000}"

DEFAULT_PREFIX="/usr/share"
if [[ $EUID -ne 0 ]]; then
   DEFAULT_PREFIX="$HOME/.local/share"
fi

PREFIX="${PREFIX:-${DEFAULT_PREFIX}}"

STARTING_DIR=`pwd`

if [ ! -e "$STARTING_DIR/build-icons.sh" ] ; then
	echo "You must run this script from the root of the repository."
	exit
fi

if [ ! -e "$STARTING_DIR/install-icons.sh" ] ; then
	echo "You must run this script from the root of the repository."
	exit
fi
if [ ! -e "$STARTING_DIR/src" ] ; then
	echo "You must run this script from the root of the repository."
	exit
fi
if [ ! -e "$STARTING_DIR/build" ] ; then
	echo "You must first build the icon theme before installing"
	exit
fi


if [ ! -d "$PREFIX" ]; then
    echo "The prefix you chose ($PREFIX) does not exist."
    read -r -p "Do you want to create it? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        mkdir -p "$PREFIX"
        if [ ! $? = 0 ]; then
            echo "Failed to create directory '$PREFIX'. Either create the directory yourself, or use a different install prefix."
            exit
        fi
    else 
        echo "Cannot continue without '$PREFIX'. Either create the directory yourself, or use a different install prefix."
        exit
    fi
fi

if [ -d "$PREFIX/icons/$ICON_THEME_NAME" ]; then
    echo "Old theme found at $PREFIX/icons/$ICON_THEME_NAME"
    read -r -p "Do you want to remove the directory and replace it? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        rm -r "$PREFIX/icons/$ICON_THEME_NAME"
        if [ ! $? = 0 ]; then
            echo "Cannot remove existing folder. Either remove the directory yourself, or use a different install prefix."
            exit
        fi
    else 
        echo "Cannot continue. Either remove the directory yourself, or use a different install prefix."
        exit
    fi
fi

echo "Installing $ICON_THEME_NAME to $PREFIX/icons/$ICON_THEME_NAME..."

# TODO: make use of the install command instead of cp
cp -r "$STARTING_DIR/build/$ICON_THEME_NAME" "$PREFIX/icons/$ICON_THEME_NAME"

echo "Updating icon cache...."
gtk-update-icon-cache "$PREFIX/icons/$ICON_THEME_NAME"

echo "Done"