package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Point;
/**
 *  Algorithm to create the trapezoidation of a polygon with holes
 *      according to Seidel's algorithm [Sei91]
 */
class Trapazoid {
    public var vHigh:       Point;
    public var vLow:        Point;
    public var lseg:        Float; //??
    public var rseg:        Float; //??
    public var depth:       Int;
    public var monoDone:    Bool;
    // Trapezoid: neighbors upper left, upper right, down left, down right.
    var uL:                 Trapazoider = null;
    var uR:                 Trapazoider = null;
    var dL:                 Trapazoider = null;
    var dR:                 Trapazoider = null;
    var sink                = null;    // link to corresponding SINK-Node in QueryStructure
    var usave               = null;   // temp: uL/uR, preserved for next step
    var uleft               = null;   // temp: from uL? (true) or uR (false)
    public function new( inHigh: Float, inLow: Float, inLeft: Float, inRight:Float ) {
        vHigh = inHigh ? inHigh : { x: Math.POSITIVE_INFINITY, y: Math.POSITIVE_INFINITY };
        vLow  = inLow  ? inLow  : { x: Math.NEGATIVE_INFINITY, y: Math.NEGATIVE_INFINITY };
        lseg = inLeft;
        rseg = inRight;
        depth = -1;             // no depth assigned yet
        monoDone = false;       // monotonization: done with trying to split this trapezoid ?
    }
    public function clone(): Trapazoider {
        var newTrap = new Trapezoider( vHigh, vLow, lseg, rseg );
        newTrap.uL = uL;
        newTrap.uR = uR;
        newTrap.dL = dL;
        newTrap.dR = dR;
        newTrap.sink = sink;
        return	newTrap;
    }
    public function splitOffLower( inSplitPt: Point ) {
        var trLower = clone();      // new lower trapezoid
        vLow        = trLower.vHigh = inSplitPt;
        // L/R unknown, anyway changed later
        dL          = trLower;      // setBelow
        trLower.uL  = this;         // setAbove
        dR          = trLower.uR = null;
        // setAbove
        if( trLower.dL ) trLower.dL.uL = trLower;	// dL always connects to uL
        if( trLower.dR ) trLower.dR.uR = trLower;	// dR always connects to uR
        return	trLower;
    }
}