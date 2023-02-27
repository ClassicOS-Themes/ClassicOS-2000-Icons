# ClassicOS 2000 Icon Theme

Scalable Linux Desktop Icon Theme modeled after Windows 2000.
This is for version 2.0 of the theme, which is still a work-in-progress.

## Compilation

This icon theme must be compiled before use, as some icons are produced by compositing several SVG files on top of each other.

To do this, the [Tin-Can Icon Theme Builder](https://github.com/tin-can-tomatoes/tc-icons-build) must be installed and accessible from $PATH.

Then, simply issue the build command from the root of the repository:

```bash
tc-icons-build build --svg --freedesktop --gz
```

Where:

 - `build` specifies the path to the build directory (where the output files go). This must always be the first argument
 - `--svg` instructs the script to composite the SVG files into (build dir)/svg
 - `--freedesktop` instructs the script to take the SVG files and structure them into a proper freedesktop icon theme
 - `--gz` instructs the script to produce .tar.gz archives of the generated output.

## Installation

Done manually for now