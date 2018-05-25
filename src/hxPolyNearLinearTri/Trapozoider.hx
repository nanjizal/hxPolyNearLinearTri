package hxPolyNearLinearTri;
import hxPolyNearLinearTri.PolygonData;
import hxPolyNearLinearTri.QueryStructure;

class Trapozoider{
    var polygonData:    PolygonData;
    var queryStructure: QueryStructure;
    public function new( polygonData_: PolygonData )
        polygonData = polygonData_;
        queryStructure = new QueryStructure( polygonData );
    }
    // Mathematics helper method
    public inline function optimiseRandomList( segs: Array<Seg> ){
        var mainIdx = 0;
        var helpIdx = polygonData.nbPolyChains();
        return if( helpIdx == 1 ) {
        
        } else {
            var chainMarker = []; //new Array( helpIdx ); // ?
            var oldSegs = segs.concat();
            for( i in 0...oldSeg.length ){
                var chainId = oldSeg[ i ].chainId;
                if( chainMarker[ chainId ] ){
                    segs[ helpIdx++ ] = oldSegs[ i ];
                } else {
                    segs[ mainIdx++ ] = oldSegs[ i ];
                    chainMarker[ chainId ] = true;
                }
            }
    }
    // Creates the trapezoidation of the polygon
    //  and assigns a depth to all trapezoids (odd: inside, even: outside).
    function trapezoidePolygon() {							// <<<< public
        var randSegListArray = this.polyData.getSegments().concat();
        #if debug 
            trace( "Polygon Chains: " + dumpSegmentList( randSegListArray ) );
        #end
        FisherYates.shuffle( randSegListArray );
        optimiseRandomList( randSegListArray );
        #if debug
            trace( "Random Segment Sequence: " + dumpRandomSequence( randSegListArray ) );
        #end
        var nbSegs = randSegListArray.length;
        var myQs = queryStructure;
        var current = 0, 
        var logstar = nbSegs;
        while( current < nbSegs ) {
            // The CENTRAL mechanism for the near-linear performance:
            //	stratefies the loop through all segments into log* parts
            //	and computes new root-Nodes for the remaining segments in each
            //	partition.
            logstar = Math.log( logstar )/Math.LN2;		// == log2(logstar)
            var partEnd = ( logstar > 1 ) ? Math.floor( nbSegs / logstar ) : nbSegs;
            // Core: adds next partition of the segments
            for( current in current...partEnd ) myQs.addSegment( randSegListArray[ current ] );
            #if debug 
                trace( 'nbSegs ' + nbSegs + ', current ' + current );
            #end
            // To speed up the segment insertion into the trapezoidation
            // the endponts of those segments not yet inserted
            // are repeatedly pre-located,
            // thus their final location-query can start at the top of the
            // appropriate sub-tree instead of the root of the whole
            // query structure.
            for( i in current...nbSegs ) queryStructure.segNodes( randSegListArray[ i ] );
        }
        myQs.assignDepths( polygonData );
        // cleanup to support garbage collection
        for(i in 0...nbSegs ) randSegListArray[ i ].trLeft = randSegListArray[ i ].trRight = null;
    },
    /**
     *Creates a visibility map:
     *  for each vertex the list of all vertices in CW order which are directly
     *  visible through neighboring trapezoids and thus can be connected by a diagonal
    **/
    public function createVisibilityMap() {
        return  queryStructure.createVisibilityMap( polygonData );
    }
};

