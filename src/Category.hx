package;

class Category
{
    /**
     *  The name of this category.
     */
    public var name : String;

    /**
     *  The path to all of the ships in the category.
     */
    public var files : Array<String>;

    public function new(_name : String, _files : Array<String>)
    {
        name  = _name;
        files = _files;
    }
}
