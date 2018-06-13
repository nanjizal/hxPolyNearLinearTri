package hxPolyNearLinearTri;

@:forward
abstract Triangle( Array<Int> ) from Array<Int> to Array<Int> {
    inline public function new( ?v: Array<Int> ) {
        if( v == null ) v = getEmpty();
        this = v;
    }
    /**
     * allow simple creation of empty Triangle
     * @return      Triangle
     **/
    public inline static 
    function getEmpty(){
        return new Triangle( new Array<Int>() );
    }
}