package hxPolyNearLinearTri;

class PolygonData{
    // list of polygon vertices
    //	.x, .y: coordinates
    public var vertices = [];
    
    // list of polygon segments, original polygons ane holes
    //	and additional ones added during the subdivision into
    //	uni-y-monotone polygons (s. this.monoSubPolyChains)
    //	doubly linked by: snext, sprev
    public var segments = [];
    public var diagonals = [];
    
    // for the ORIGINAL polygon chains
    public var idNextPolyChain = 0;
    //	for each original chain: lies the polygon inside to the left?
    //	"true": winding order is CCW for a contour or CW for a hole
    //	"false": winding order is CW for a contour or CCW for a hole
    public var PolyLeftArr = [];
    
    // indices into this.segments: at least one for each monoton chain for the polygon
    //  these subdivide the polygon into uni-y-monotone polygons, that is
    //  polygons that have only one segment between ymax and ymin on one side
    //  and the other side has monotone increasing y from ymin to ymax
    // the monoSubPolyChains are doubly linked by: mnext, mprev
    public var monoSubPolyChains = [];
    
    // list of triangles: each 3 indices into this.vertices
    public var triangles = [];
    
    public function new( inPolygonChainList ) {
        // initialize optional polygon chains
        if( inPolygonChainList ) {
            for( i in 0...inPolygonChainList.length ){
                addPolygonChain( inPolygonChainList[ i ] );
            }
        }
    }
    public function addPolygonChain(){
        //??
    }

}