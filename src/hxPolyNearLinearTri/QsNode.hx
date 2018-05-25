package hxPolyNearLinearTri;
// Only SINK-nodes are created directly.
// The others originate from splitting trapezoids
// - by a horizontal line: SINK-Node -> Y-Node
// - by a segment: SINK-Node -> X-Node
class QsNode {
    #if debug
    public static var counter = 0;
    #end
    public var trap: Trapezoid;
    public function new( trap_: Trapezoid ){
        #if debug 
            counter++;
        #end
        trap = trap_;
    }
}