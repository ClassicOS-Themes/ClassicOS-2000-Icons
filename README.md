# ClassicOS 2000 Icon Theme

Scalable Linux Desktop Icon Theme modeled after Windows 2000.

## Note

Version 2 of the icon theme is currently in the works, sporting a new build system and more 24px icons, among other improvements.

## Installation

Requires bash for build & installation.
Generating PNG or ICO files also requires inkscape and imagemagick's `convert` program.

### Freedesktop Icon Theme

```bash
make freedesktop
make install
# for system-wide installation, use 'sudo make install'
# or set the PREFIX environment variable to a different prefix:
# PREFIX=/usr/local/share make install
```

### Generate PNG Files

```bash
make png
```

### Generate PNG and ICO files

```bash
make ico
```

## Screenshots

### In Use (Nemo on GNOME 40)

![Icon theme in use with Nemo File Manager](screenshots/nemo.png)

[16px](screenshots/16px-files.png) [32px](screenshots/32px-files.png) [48px](screenshots/48px-files.png) [oversize](screenshots/oversize-files.png)

### Misc. Icons

48px @2x: 
<img src="src/svg48/folder-documents.svg" alt="Documents Folder" width="96" height="96">  <img src="src/svg48/folder-pictures.svg" alt="Pirctures Folder" width="96" height="96">  <img src="src/svg48/folder-recent.svg" alt="Refent Folder" width="96" height="96">  <img src="src/svg48/installer-web.svg" alt="Package Manager" width="96" height="96">  <img src="src/svg48/help.svg" alt="Help" width="96" height="96">

48px @1x: 
![Desktop @ 48px](src/svg48/desktop.svg) ![Printer @ 48px](src/svg48/printer.svg) ![Optical Media @ 48px](src/svg48/media-optical.svg) ![Installer @ 48px](src/svg48/installer.svg) ![Keyboard @ 48px](src/svg48/keyboard.svg) ![Default App @ 48px](src/svg48/application-default-icon.svg) ![Audio Card @ 48px](src/svg48/audio-card.svg) ![Audio File @ 48px](src/svg48/audio-x-generic.svg) ![Computer @ 48px](src/svg48/computer.svg) ![Notepad @ 48px](src/svg48/text-editor.svg) ![Control Panel @ 48px](src/svg48/preferences-desktop.svg) ![Trash @ 48px](src/svg48/trash-full.svg) 

32px @1x: 
![Full Battery @ 32px](src/svg32/battery-full-charging.svg) ![MS-DOS @ 32px](src/svg32/dosemu.svg) ![DLL @ 32px](src/svg32/application-object.svg) ![gears @ 32px](src/svg32/gears.svg)  ![ISO file @ 32px](src/svg32/application-x-cd-image.svg)  ![Dialog Error @ 32px](src/svg32/dialog-error.svg) ![Dialog Warning @ 32px](src/svg32/dialog-warning.svg) ![Dialog Information @ 32px](src/svg32/dialog-information.svg) ![Magnifier @ 32px](src/svg32/magnifier.svg) 

16px @1x: 
![File](src/svg16/file.svg) ![Open](src/svg16/file-open.svg) ![Save](src/svg16/save.svg) ![Save All](src/svg16/save-all.svg) ![Cut](src/svg16/edit-cut.svg) ![Copy](src/svg16/edit-copy.svg) ![Paste](src/svg16/edit-paste.svg) ![Back](src/svg16/back.svg) ![Forward](src/svg16/forward.svg) ![Delete](src/svg16/delete.svg) ![New Folder](src/svg16/folder-new.svg) ![Email-Read](src/svg16/msg-read.svg) ![Email-Unread](src/svg16/msg-unread.svg) ![Zoom-fit](src/svg16/zoom-fit.svg) ![Zoom-in](src/svg16/zoom-in.svg) ![Zoom-out](src/svg16/zoom-out.svg) ![Zoom-zero](src/svg16/zoom-zero.svg) ![Program Group](src/svg16/program-group.svg)  ![Admin Tools](src/svg16/applications-system.svg)

## Misc Notes

Falls back to [98SE](https://github.com/nestoris/Win98SE), [Chicago95](https://github.com/grassmunk/Chicago95), [Windows-XP](https://github.com/B00merang-Artwork/Windows-XP/), [Retrosmart Icons](https://github.com/mdomlop/retrosmart-icon-theme), and [Tango](http://tango.freedesktop.org/Tango_Icon_Library) for missing icons
