package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Trapezoider;
import hxPolyNearLinearTri.PolygonData;
/**
 *	Algorithm to split a polygon into uni-y-monotone sub-polygons
 *
 *	1) creates a trapezoidation of the main polygon according to Seidel's
 *	   algorithm [Sei91]
 *	2) uses diagonals of the trapezoids as additional segments
 *		to split the main polygon into uni-y-monotone sub-polygons
 */
class MonoSplitter {
    public var polyData:        PolygonData;
    public var trapezoider:     Trapezoider;
    public function new( polygonData_: PolygonData ){
        polyData = polyData;
    }
    public function monotonateTrapezoids(){
        trapezoider = new Trapezoider( polygonData );   // Trapezoidation
        trapezoider.trapezoidePolygon();                //	=> one triangular trapezoid which lies inside the polygon
        trapezoider.createVisibilityMap();              // create segments for diagonals
        polygonData.createMonoChains();                 // create mono chains by inserting diagonals
        polygonData.uniqueMonotoneChainsMax();          // create UNIQUE monotone sub-polygons
    }
}