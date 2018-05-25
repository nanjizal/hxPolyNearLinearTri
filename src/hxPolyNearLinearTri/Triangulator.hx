package hxPolyNearLinearTri;
import hxPolyNearLinearTri.PolygonData;
import hxPolyNearLinearTri.EarClipTriangulator;
import hxPolyNearLinearTri.MonoSplitter;
/*******************************************************************************
 *
 *	Triangulator for Simple Polygons with Holes
 *
 *  polygon with holes:
 *	- one closed contour polygon chain
 *  - zero or more closed hole polygon chains
 *
 *	polygon chain (closed):
 *	- Array of vertex Objects with attributes "x" and "y"
 *		- representing the sequence of line segments
 *		- closing line segment (last->first vertex) is implied
 *		- line segments are non-zero length and non-crossing
 *
 *	"global vertex index":
 *	- vertex number resulting from concatenation all polygon chains (starts with 0)
 *
 *
 *	Parameters (will not be changed):
 *		inPolygonChains:
 *		- Array of polygon chains
 *
 *	Results (are a fresh copy):
 *		triangulate_polygon:
 *		- Array of Triangles ( Array of 3 "global vertex index" values )
 *
 ******************************************************************************/
class Triangulator{
    var lastPolyData;
    public function new(){
        lastPolyData = null;		// for Debug purposes only
    }
    public clearLastData(){
        lastPolyData = null;
    }
    // for the polygon data AFTER triangulation
    //	returns an Array of flags, one flag for each polygon chain:
    //		lies the inside of the polygon to the left?
    //		"true" implies CCW for contours and CW for holes
    public function getPolyLeftArr() {
        if ( lastPolyData )	return lastPolyData.getPolyLeftArr();
        return null;
    }
    // collected conditions for selecting EarClipTriangulator over Seidel's algorithm
    function isBasicPolygon() {
        return ( inForceTrapezoidation )? false: ( myPolygonData.nbPolyChains() == 1 );
    }
    public function triangulatePolygon( inPolygonChains, inForceTrapezoidation ) {
        clearLastData();
        if( ( !inPolygonChains ) || ( inPolygonChains.length === 0 ) ) return [];
        // initializes general polygon data structure
        var polyData = new PolygonData( inPolygonChains );
        var basicPolygon = isBasicPolygon();
        if( basicPolygon ) basicPolygon = triangulateNoHoles( polyData );
        if( !basicPolygon ) { 
            splitPolygon( polyData )
            triangulatePolygon( polyData );
        }
        lastPolyData = myPolygonData;
        return	myPolygonData.getTriangles();	// copy of triangle list
    }
    // triangulates single polygon without holes
    inline function triangulateNoHoles( polyData: PolyData ): Bool {
        var triangulator = new EarClipTriangulator( polyData );
        return triangulator.triangulatePolygonNoHoles();
    }
    // splits polygon into uni-y-monotone sub-polygons
    inline function splitPolygon( polyData: PolyData ){
        var	splitter = new MonoSplitter( polyData );
        splitter.monotonateTrapezoids();
    }
    // triangulates all uni-y-monotone sub-polygons
    inline function triangulatePolygon( polyData: PolyData ){
        var triangulator = new MonoTriangulator( myPolygonData );
        triangulator.triangulateAllPolygons();
    }
}