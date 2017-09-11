package;

import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
using TxtTools;

class TxtTools
{
    public static function readCategoriesTxt(_path : String) : Array<Category>
    {
        var file = File.read(_path, false);

        var categories = new Array<Category>();

        for (i in 0...file.readCategoriesNumber())
        {
            categories.push(file.readCategory());
        }

        return categories;
    }

    private static function readCategoriesNumber(_input : FileInput) : Int
    {
        var split = _input.readLine().split(" = ");
        return Std.parseInt(split[1]);
    }

    private static function readCategory(_input : FileInput) : Category
    {
        // First two lines for each category are visual / whitespace.
        _input.readLine();
        _input.readLine();

        var files = new Array<String>();
        var name  = _input.readLine();
        name = name.substring(1, name.length);

        for (i in 0..._input.readCategoriesNumber())
        {
            files.push(_input.readLine());
        }

        // Last line is more whitespace.
        _input.readLine();

        return new Category(name, files);
    }

    public static function writeCategoriesTxt(_categories : Array<Category>, _path : String)
    {
        var file = File.write(_path, false);
        file.writeLine('numCategories = ${_categories.length}');

        for (category in _categories)
        {
            file.writeCategory(category);
        }
    }

    private static function writeCategory(_output : FileOutput, _category : Category)
    {
        _output.writeLine('#---------------------------CATEGORY---------------------------');
        _output.writeLine('');

        _output.writeLine('>${_category.name}');
        _output.writeLine('numShips = ${_category.files.length}');

        for (file in _category.files)
        {
            _output.writeLine(file);
        }

        _output.writeLine('');
    }

    private static function writeLine(_output : FileOutput, _string : String)
    {
        _output.writeString(_string + '\n');
    }
}
