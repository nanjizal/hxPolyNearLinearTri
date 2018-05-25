package hxPolyNearLinearTri;
import hxPolyNearLinearTri.Polygondata;
import hxPolyNearLinearTri.Point;
import hxPolyNearLinearTri.Epsilon;
/**
 *	Algorithm to triangulate uni-y-monotone polygons [FoM84]
 *	expects list of doubly linked monoChains, with Y-max as first vertex
 */
class MonoTriangulator {
    var polygonData: PolygonData;
    public function new MonoTriangulator( polygonData_: PolygonData ){
        polygonData = polygonData_;
    }
    // Pass each uni-y-monotone polygon with start at Y-max for greedy triangulation.
    public function triangulateAllPolygons(){
        var	normedMonoChains = polygonData.getMonoSubPolys();
        polyonData.clearTriangles();
        for( i in 0...normedMonoChains ) {
            // loop through uni-y-monotone chains
            // => monoPosmin is next to monoPosmax (left or right)
            var monoPosmax = normedMonoChains[ i ];
            var prev = monoPosmax.mprev;
            var next = monoPosmax.mnext;
            if( nextMono.mnext == prevMono ){ // already a triangle
                polygonData.addTriangle( monoPosmax.vFrom, next.vFrom, prev.vFrom );
            } else { // triangulate the polygon
                triangulateMonotonePolygon( monoPosmax );
            }
        }
    }
    function inline errorCleanup( vertBackLog: Array<Point>, vertBackLogIdx: Int ) {
        // Error in algorithm OR polygon is not uni-y-monotone
        #if debug
            trace( "ERR uni-y-monotone: only concave angles left " + vertBackLog );
        #end
        // push all "wrong" triangles => loop ends
        while (vertBackLogIdx > 1) {
            vertBackLogIdx--;
            polygotData.addTriangle(    vertBackLog[ vertBackLogIdx - 1 ],
                                        vertBackLog[ vertBackLogIdx ],
                                        vertBackLog[ vertBackLogIdx + 1 ] );
        }
    }
    //  algorithm to triangulate an uni-y-monotone polygon in O(n) time.[FoM84]
    function triangulateMonotonePolygon( monoPosmax ){
        //
        // Decisive for this algorithm to work correctly is to make sure
        //  the polygon stays uni-y-monotone when cutting off ears, i.e.
        //  to make sure the top-most and bottom-most vertices are removed last
        // Usually this is done by handling the LHS-case ("LeftHandSide is a single segment")
        //  and the RHS-case ("RightHandSide segment is a single segment")
        //  differently by starting at the bottom for LHS and at the top for RHS.
        // This is not necessary. It can be seen easily, that starting
        //  from the vertex next to top handles both cases correctly.
        //
        var frontMono = monoPosmax.mnext;		// == LHS: YminPoint; RHS: YmaxPoint.mnext
        var endVert = monoPosmax.vFrom;
        var vertBackLog = [ frontMono.vFrom ];
        var vertBackLogIdx = 0;
        frontMono = frontMono.mnext;
        var frontVert = frontMono.vFrom;
        // check for robustness // TODO
        if( frontVert == endVert ) return;		// Error: only 2 vertices
        while( (frontVert != endVert) || (vertBackLogIdx > 1) ){
            if ( vertBackLogIdx > 0 ) {
                // vertBackLog is not empty
                var insideAngleCCW = Point.crossProd( vertBackLog[ vertBackLogIdx ], frontVert, vertBackLog[vertBackLogIdx-1] );
                if ( Math.abs( insideAngleCCW ) <= EPSILON ) {
                    // co-linear
                    if(( frontVert == endVert) || // all remaining triangles are co-linear (180 degree)
                        ( Point.compare( vertBackLog[ vertBackLogIdx ], frontVert ) == // co-linear-reversal
                            Point.compare( vertBackLog[ vertBackLogIdx ], vertBackLog[ vertBackLogIdx - 1 ] ) ))
                    {
                        insideAngleCCW = 1;		// => create triangle
                    }
                }
                if( insideAngleCCW > 0 ){
                    // convex corner: cut if off
                    polygonData.addTriangle( vertBackLog[ vertBackLogIdx - 1 ], vertBackLog[ vertBackLogIdx ], frontVert );
                    vertBackLogIdx--;
                } else {
                    // non-convex: add frontVert to the vertBackLog
                    vertBackLog[ ++vertBackLogIdx ] = frontVert;
                    if(frontVert == endVert ){
                        error_cleanup( vertBackLog, vertBackLogIdx ); // should never happen !!
                    } else {
                        frontMono = frontMono.mnext;
                        frontVert = frontMono.vFrom;
                    }
                }
            } else {
                // vertBackLog contains only start vertex:
                //	add frontVert to the vertBackLog and advance frontVert
                vertBackLog[++vertBackLogIdx] = frontVert;
                frontMono = frontMono.mnext;
                frontVert = frontMono.vFrom;
            }
        }
        // reached the last vertex. Add in the triangle formed
        polygonData.addTriangle( vertBackLog[ vertBackLogIdx - 1 ], vertBackLog[ vertBackLogIdx ], frontVert );
    }
}