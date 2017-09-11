# BallisticNG Category Extractor

Small CLI program which converts [BallisticNG's](http://store.steampowered.com/app/473770/BallisticNG/) ShipCategories.bin file to and from a human readable text format.

Windows, Linux, and hopefully soon Mac executables can be found in the releases section of this repo.

## Usage

The program has the following two commands.


### bin-to-txt

 txt-to-bin allows you to convert the ShipCategories.bin file to a human readable text format for easier manual editing. The command takes two arguments.

 * `binary file location`: The location of the ShipCategories.bin file to convert.
 * `text file output path`: File path with the file name for where to store the generated text file. (file does not have to already exist).

 Example

 * `cat-extractor bin-to-txt /path/to/ShipCategories.bin /path/to/store/categories.txt`

### txt-to-bin

 txt-to-bin allows you to generate a game compatible binary file from the human readable text format. The command takes two arguments.

 * `text file location`: The location of the text file to convert.
 * `binary file output path`: File path with the file name for where to store the generated binary file. (does not have to already exist).

 Example

 * `cat-extractor txt-to-bin /path/to/categories.txt /path/to/store/ShipCategories.bin`

## Building

This program is built with [haxe](https://haxe.org/) and has no dependencies on external libraries.

To build the program run `haxe build-neko.hxml` or `haxe build-cpp.hxml`. The resulting program will be built in the `bin/neko` or `bin/cpp` folders depending on which build file was used.
