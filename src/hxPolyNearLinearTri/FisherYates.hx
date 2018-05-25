package hxPolyNearLinearTri;
class FisherYates {
    // generate random ordering in place:
    //	Fisher-Yates shuffle
    public static inline function shuffle<T>( arr: Array<T> ){
        var i = arr.length;
        while( i > 0 ){
            var j = Math.floor( Math.random() * ( i + 1 ) );
            var tmp = arr[ i ];
            arr[ i ] = arr[ j ];
            arr[ j ] = tmp;
            i--;
        }
        return arr;
    }
}