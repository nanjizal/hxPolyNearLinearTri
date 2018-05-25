package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Epsilon;
//typedef Point = { x: Float, y: Float }
class Point {
    public var x: Float;
    public var y: Float;
    public function new( x_: Float, y_: Float ){
        x = x_;
        y = y_;
    }
    // TODO: check if this is correct
    // TODO: shorten input names?
    static function inline crossProduct( inPtVertex: Point, inPtFrom: Point, inPtTo: Point ) {
        // two vectors: ( v0: inPtVertex -> inPtFrom ), ( v1: inPtVertex -> inPtTo )
        // CROSS_SINE: sin(theta) * len(v0) * len(v1)
        return	( inPtFrom.x - inPtVertex.x ) * ( inPtTo.y - inPtVertex.y ) -
            ( inPtFrom.y - inPtVertex.y ) * ( inPtTo.x - inPtVertex.x );
        // <=> crossProd( inPtFrom-inPtVertex, inPtTo-inPtVertex )
        // == 0: colinear (angle == 0 or 180 deg == PI rad)
        // > 0:  v1 lies left of v0, CCW angle from v0 to v1 is convex ( < 180 deg )
        // < 0:  v1 lies right of v0, CW angle from v0 to v1 is convex ( < 180 deg )
    }
    // like compare (<=>)
    // yA > yB resp. xA > xB: 1, equal: 0, otherwise: -1
    public static inline function compare( a: Point, b: Point ) {
        var dY = a.y - b.y;
        return if( dY < -EPSILON ) {
            return -1;
        } else if ( dY > EPSILON ) {
            1;
        } else {
            var dX = a.x - b.x;
            if( dX < -EPSILON ) {
                -1;
            } else if( dX > EPSILON ) {
                1;
            } else {
                0;
            }
        }
    }
}