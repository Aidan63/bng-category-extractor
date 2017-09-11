
class Main
{
    public static function main()
    {
        var args = Sys.args();
        if (args.length == 0) printHelp();

        switch (args.shift())
        {
            case 'txt-to-bin': doTxtToBin(args);
            case 'bin-to-txt': doBinToTxt(args);
        }
    }

    private static function doTxtToBin(_args : Array<String>)
    {
        if (_args.length < 2) printHelpTxtToBin();
        BinTools.writeCategoriesBin(TxtTools.readCategoriesTxt(_args[0]), _args[1]);
    }

    private static function doBinToTxt(_args : Array<String>)
    {
        if (_args.length < 2) printHelpBinToTxt();
        TxtTools.writeCategoriesTxt(BinTools.readCategoriesBin(_args[0]), _args[1]);
    }

    private static function printHelp()
    {
        Log.info ('BallisticNG Category Extractor');
        Log.print('Small util for converting the ShipCategories.bin file to and from a human readable format');
        Log.print('The following commands are available:');
        Log.print('  txt-to-bin');
        Log.print('  bin-to-txt');
        Log.print('Run this program with one of these options to view more details');
        Sys.exit(0);
    }

    private static function printHelpTxtToBin()
    {
        Log.error('Not enough arguments provided');
        Log.print('txt-to-bin expects two arguments:');
        Log.print('  text file location      The location of the text file to convert');
        Log.print('  binary file location    File path with file name for where to store the generated file (does not have to already exist)');
        Log.print('Example:');
        Log.print('  cat-extractor txt-to-bin /path/to/categories.txt /path/to/store/ShipCategories.bin');
        Sys.exit(0);
    }

    private static function printHelpBinToTxt()
    {
        Log.error('Not enough arguments provided');
        Log.print('bin-to-txt expects two arguments:');
        Log.print('  binary file location    The location of the ShipCategories.bin file to convert');
        Log.print('  text file location      File path with file name for where to store the generated file (does not have to already exist)');
        Log.print('Example:');
        Log.print('  cat-extractor bin-to-txt /path/to/ShipCategories.bin /path/to/store/categories.txt');
        Sys.exit(0);
    }
}
