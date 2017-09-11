package;

import haxe.io.BytesOutput;
import haxe.io.BytesInput;
import sys.io.File;
using BinTools;

class BinTools
{
    /**
     *  Reads the ShipCategories.bin file at the provided path and returns all found categories.
     *  @param _path - The path to the binary file.
     *  @return Array<Category>
     */
    public static function readCategoriesBin(_path : String) : Array<Category>
    {
        // TODO : Check if file exists and all that.
        var bytes = new BytesInput(File.getBytes(_path));

        var categories = new Array<Category>();

        for (i in 0...bytes.readInt32())
        {
            categories.push(readCategory(bytes));
        }

        return categories;
    }

    private static function readCategory(_input : BytesInput) : Category
    {
        var name  = _input.readCSharpString();
        var files = new Array<String>();

        for (i in 0..._input.readInt32())
        {
            files.push(_input.readCSharpString());
        }

        return new Category(name, files);
    }

    /**
     *  Exports the provided categories to a ShipCategories.bin file at the requested path.
     *  @param _categories - 
     *  @param _path - 
     */
    public static function writeCategoriesBin(_categories : Array<Category>, _path : String)
    {
        var bytes = new BytesOutput();
        bytes.writeInt32(_categories.length);

        for (cat in _categories)
        {
            bytes.writeCategory(cat);
        }

        File.saveBytes(_path, bytes.getBytes());
    }

    private static function writeCategory(_output : BytesOutput, _category : Category)
    {
        _output.writeCSharpString(_category.name);
        _output.writeInt32(_category.files.length);

        for (file in _category.files)
        {
            _output.writeCSharpString(file);
        }
    }

    /**
     *  Function to write strings which C#'s binary reader can understand.
     *  Before the string is written to the stream a 7 bit encoded UInt of the strings length is written.
     *  
     *  @param _output - The BytesOutput stream to write to.
     *  @param _string - The string to write.
     */
    private static function writeCSharpString(_output : BytesOutput, _string : String)
    {
        // Write the strings length as a 7 bit encoded UInt (1 byte every 127 chars)
        var num : UInt = cast _string.length;
        while (num >= 0x80)
        {
            _output.writeByte(num | 0x80);
            num = num >> 7;
        }
        _output.writeByte(num);

        // Then write the actual string
        _output.writeString(_string);
    }

    /**
     *  Reads a C# binary writer formatted string from the bytes stream.
     *  @param _input - The bytes stream to read from.
     *  @return String
     */
    private static function readCSharpString(_input : BytesInput) : String
    {
        var stringLength = 0;
        var lengthParsed = false;
        var step = 0;

        while (!lengthParsed)
        {
            var part = _input.readByte();
            lengthParsed = ((part >> 7) == 0);

            part = part & 127;
            stringLength += part << (step * 7);
            step++;
        }

        return _input.readString(stringLength);
    }
}
