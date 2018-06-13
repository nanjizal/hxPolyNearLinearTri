package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Point;
typedef Diagonal = {
    public var vFrom:   Point;
    public var vTo:     Point;
    public var mprev:   Int;
    public var mnext:   Int;
    public var marked:  Bool;
}