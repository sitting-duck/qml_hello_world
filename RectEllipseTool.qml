import QtQuick 2.0
import QtQuick.Layouts 1.3

OverlayBase {
    id: _top
    anchors.fill: parent

    property point center: Qt.point(0, 0)

    Item {
        id: _private
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        property var bezierPoints_cartesian: [Qt.point(0.5, 0.25), Qt.point(-0.5, 0.25), Qt.point(-0.5, -0.25), Qt.point(0.5, -0.25)]
        property var controlPoints_cartesian: [Qt.point(1, 0), Qt.point(0, 0.5), Qt.point(-1, 0), Qt.point(0, -0.5)]
        property var controlPoints_pixel: [cartesiantoPixelPoint(Qt.point(1, 0)), cartesiantoPixelPoint(Qt.point(0, 0.5)), cartesiantoPixelPoint(Qt.point(-1, 0)), cartesiantoPixelPoint(Qt.point(0, -0.5))]



        onPaint: {

            var ctx = getContext("2d");
            ctx.lineWidth = 5;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";


            var x = canvas.width/2 - 4;
            var y = canvas.height/2 - 4;
            var height = 8;
            var width = 8;


            ctx.beginPath();


//            ctx.moveTo(canvas.controlPoints_pixel[0].x, canvas.controlPoints_pixel[0].y);
//            ctx.quadraticCurveTo(canvas.bezierPoints_cartesian[0].x, canvas.bezierPoints_cartesian[0].y, canvas.controlPoints_pixel[1].x, canvas.controlPoints_pixel[1].y);
//            ctx.stroke();

//            ctx.moveTo(canvas.controlPoints_pixel[1].x, canvas.controlPoints_pixel[1].y);
//            ctx.quadraticCurveTo(canvas.bezierPoints_cartesian[1].x, canvas.bezierPoints_cartesian[1].y, canvas.controlPoints_pixel[2].x, canvas.controlPoints_pixel[2].y);
//            ctx.stroke();

//            ctx.moveTo(canvas.controlPoints_pixel[2].x, canvas.controlPoints_pixel[2].y);
//            ctx.quadraticCurveTo(canvas.bezierPoints_cartesian[2].x, canvas.bezierPoints_cartesian[2].y, canvas.controlPoints_pixel[3].x, canvas.controlPoints_pixel[3].y);
//            ctx.stroke();

//            ctx.moveTo(canvas.controlPoints_pixel[3].x, canvas.controlPoints_pixel[3].y);
//            ctx.quadraticCurveTo(canvas.bezierPoints_cartesian[3].x, canvas.bezierPoints_cartesian[3].y, canvas.controlPoints_pixel[0].x, canvas.controlPoints_pixel[0].y);
//            ctx.stroke();


//            var x_normal = 0; var y_normal = 0;
//            var x_pixel = 0; var y_pixel = 0;

//            while(x_normal < 1) {

//                var radius = 0.5; //_top.width/2;

//                // 2 is the distance between -1 and 1, we want to eek across from -1 to some normalized amount, based on how many pixels wide our viewing window is
//                var delta_normal = 2/canvas.width;

//                x_normal = x_normal + delta_normal;

////                console.log("Math.pow(x_normal, 2): ", Math.pow(x_normal, 2));


//                var x_normal_squared = Math.pow(x_normal, 2);
//                if(x_normal_squared > 1) {
//                   x_normal_squared = 1;
//                }
////                console.log("x_normal_squared: ", x_normal_squared);
//                y_normal = Math.sqrt(radius - x_normal_squared);
////                console.log("Math.sqrt(1 - x_normal_squared): ", Math.sqrt(1 - Math.pow(x_normal, 2)));
//                x_pixel = x_pixel + _top.convert(x_normal, -1, 1, 0, canvas.width);
//                y_pixel = _top.convert(y_normal, -1, 1, 0, canvas.height);

////                console.log("x_normal: ", x_normal, " y_normal: ", y_normal);
//                ctx.ellipse(x_pixel, y_pixel, 1, 1);
//                //ctx.moveTo(x_pixel, y_pixel);
//                //ctx.lineTo(x_pixel + 1, y_pixel + 1);
//                ctx.stroke();

//            }

//            var x_normal = 0; var y_normal = 0;
//            var x_pixel = 0; var y_pixel = 0;
//            //var x_pixel_cartesian = 0; var y_pixel_cartesian = 0;

//            var radius = 40;

//            //var radius_normal = radius/_top.width;
            
            
//            var center_pixel = Qt.point(_top.width/2, _top.height/2);
//            var center_cartesian_pixel = Qt.point(0, 0);

//            x_pixel = 0;//center_pixel.x - radius;
//            var h_pixel = _top.width/2;
//            var k_pixel = _top.height/2;

//            var h_cartesian_pixel = 0;
//            var k_cartesian_pixel = 0;

//            while(x_pixel < _top.width) {

//                var r_squared = Math.pow(radius, 2);
//                var x_squared = Math.pow(x_pixel - h_pixel, 2);

//                if (r_squared > x_squared) {
//                    y_pixel = Math.sqrt(r_squared - x_squared) + k_pixel;
//                    y_pixel = Math.round(y_pixel);

//                    y_pixel_cartesian =

//                    ctx.moveTo(x_pixel, y_pixel);
//                    ctx.lineTo(x_pixel + 1, y_pixel + 1);
//                    ctx.stroke();

//                    var top_y_pixel = y_pixel - 2*radius;
//                    ctx.moveTo(x_pixel, top_y_pixel);
//                    ctx.lineTo(x_pixel, top_y_pixel + 1);
//                    ctx.stroke();
//                }

//                x_pixel = x_pixel + 1;
//            }

            var radius_pixel = 80;
            var x_start = _top.convert(-radius_pixel, -_top.width/2, _top.width/2, 0, _top.width);
            var x_end = _top.convert(radius_pixel, -_top.width/2, _top.width/2, 0, _top.width);

            console.log("_top.width: ", _top.width);
            console.log("x_start: ", x_start, " x_end: ", x_end);
            var y_pixel_cartesian = 0;
            for (var x_pixel = x_start; x_pixel < x_end; x_pixel++) {

                var x_pixel_cartesian = _top.convert(x_pixel, 0, _top.width, -_top.width/2, _top.width/2);

                var r_squared = Math.pow(radius_pixel, 2);
                var x_squared_pixel_cartesian = Math.pow(x_pixel_cartesian, 2);
                if(r_squared > x_squared_pixel_cartesian) {
                    console.log("r_squared: ", r_squared, " x_squared: ", x_squared_pixel_cartesian);
                    var square_difference = Math.sqrt(r_squared - x_squared_pixel_cartesian);
                    y_pixel_cartesian = _top.convert(square_difference, 0, _top.height, _top.height/2, -_top.height/2);
                    console.log("y_pixel_cartesian: ", y_pixel_cartesian);
    //                ctx.moveTo(x_pixel_cartesian, _top.height/2);
    //                ctx.lineTo(x_pixel_cartesian + 1, _top.height/2);
                    ctx.moveTo(x_pixel, y_pixel_cartesian);
                    ctx.lineTo(x_pixel + 1, y_pixel_cartesian + 1);
                    ctx.stroke();
                }
            }



//            for(var x_pixel = 0; x_pixel < canvas.width - 1; x_pixel++) {
//                var y_pixel = Math.sqrt(1 - Math.pow(x_pixel, 2));
//                var next_y_pixel = Math.sqrt(1 - Math.pow(x_pixel + 1, 2));

//                ctx.moveTo(x_pixel, y_pixel);
//                ctx.lineTo(x_pixel + 1, 20);
//                ctx.stroke();
//            }

        }

    }
}
