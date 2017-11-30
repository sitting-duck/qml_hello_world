import QtQuick 2.0
import QtQuick.Layouts 1.3

OverlayBase {
    id: _top
    anchors.fill: parent

    property point center: Qt.point(0, 0)

    //@ash: say what this does
    function cartesiantoPixelPoint(cartesianPoint) {
        var x = _top.convertValueFromOldBoundariesToNewBoundarySpace(cartesianPoint.x, -1, 1, 0, canvas.width);
        // this might seem backwards, but we have to do this because positive y is down for pixel space in qml objects
        var y = _top.convertValueFromOldBoundariesToNewBoundarySpace(cartesianPoint.y, -1, 1, canvas.height, 0);
        return Qt.point(x, y);
    }

    //@ash: say what this does
    function convertValueFromOldBoundariesToNewBoundarySpace(valueToConvert, lowOld, HighOld, lowNew, highNew) {
        var returnValue = (valueToConvert-lowOld) / (HighOld-lowOld) * (highNew-lowNew) + lowNew;
        return returnValue;
    }

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


            var x_normal = 0; var y_normal = 0;
            var x_pixel = 0; var y_pixel = 0;
            while(x_normal < 1) {
                // 2 is the distance between -1 and 1, we want to eek across from -1 to some normalized amount, based on how many pixels wide our viewing window is
                var delta_normal = 2/canvas.width;

                x_normal = x_normal + delta_normal;

//                console.log("Math.pow(x_normal, 2): ", Math.pow(x_normal, 2));


                var x_normal_squared = Math.pow(x_normal, 2);
                if(x_normal_squared > 1) {
                   x_normal_squared = 1;
                }
//                console.log("x_normal_squared: ", x_normal_squared);
                y_normal = Math.sqrt(200 - x_normal_squared);
//                console.log("Math.sqrt(1 - x_normal_squared): ", Math.sqrt(1 - Math.pow(x_normal, 2)));
                x_pixel = x_pixel + _top.convertValueFromOldBoundariesToNewBoundarySpace(x_normal, -1, 1, 0, canvas.width);
                y_pixel = _top.convertValueFromOldBoundariesToNewBoundarySpace(y_normal, -1, 1, 0, canvas.height);

//                console.log("x_normal: ", x_normal, " y_normal: ", y_normal);
                ctx.ellipse(x_pixel, y_pixel, 1, 1);
                //ctx.moveTo(x_pixel, y_pixel);
                //ctx.lineTo(x_pixel + 1, y_pixel + 1);
                ctx.stroke();

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
