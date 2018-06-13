package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Segment;

class PolygonData{
    // list of polygon vertices
    //	.x, .y: coordinates
    public var vertices = new Array<Int>;
    
    // list of polygon segments, original polygons ane holes
    //	and additional ones added during the subdivision into
    //	uni-y-monotone polygons (s. this.monoSubPolyChains)
    //	doubly linked by: snext, sprev
    public var segments = new Array<Segment>();
    public var diagonals = new Array<Diagonal>();
    
    // for the ORIGINAL polygon chains
    public var idNextPolyChain = 0;
    //	for each original chain: lies the polygon inside to the left?
    //	"true": winding order is CCW for a contour or CW for a hole
    //	"false": winding order is CW for a contour or CCW for a hole
    public var PolyLeftArr = new Array<Bool>();
    
    // indices into this.segments: at least one for each monoton chain for the polygon
    //  these subdivide the polygon into uni-y-monotone polygons, that is
    //  polygons that have only one segment between ymax and ymin on one side
    //  and the other side has monotone increasing y from ymin to ymax
    // the monoSubPolyChains are doubly linked by: mnext, mprev
    public var monoSubPolyChains = new Array<Segment>();
    
    // list of triangles: each 3 indices into this.vertices
    public var triangles = new Array<Triangle>;
    
    public function nbVertices(){
        return vertices.length;
    }
    public var firstSegment( get_firstSegment, null ): Segment;
    public function get_firstSegment(): Segment {
        return segments[ 0 ];
    }
    
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