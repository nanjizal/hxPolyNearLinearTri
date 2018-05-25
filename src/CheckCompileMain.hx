package;
import hxPolyNearLinearTri.*;
// checks classes compile even if functionality not fully ported.
class CheckCompileMain {
    public static function main(){
        new CheckCompileMain();
    }
    public function new(){
        trace( 'compiled hxPolyNearLinearTri' );
        trace( 'progress summary:' );
        trace( ' Epsilon looks ok' );
        trace( ' FisherYates looks ok' );
        trace( ' MonoSpliter incomplete' );
        trace( ' MonoTriangulator looks ok ' );
        trace( ' Point check if crossProduct suitable home' );
        trace( ' PolygonData incomplete' );
        trace( ' QsNode looks ok' );
        trace( ' QueryStructure needs lot more work ' );
        trace( ' Trapazoid and Trapzoider confused between not complete' );
        trace( ' Triangulator looks ok');
    }
}