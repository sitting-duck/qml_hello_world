import QtQuick 2.0
import QtQuick.Layouts 1.3

OverlayBase {
    id: _top
    anchors.fill: parent

    property point center: Qt.point(0, 0)

    Item {
        id: _private

        function get_y_cartesian_circle(x_pixel_cartesian, radius_pixel) {
            var r_squared = Math.pow(radius_pixel, 2);
            var x_squared_pixel_cartesian = Math.pow(x_pixel_cartesian, 2);
            if (r_squared >= x_squared_pixel_cartesian) {
                var square_difference = Math.sqrt(r_squared - x_squared_pixel_cartesian);
                return square_difference;
            } else {
                return undefined;
            }
        }

        function get_y_cartesian_rectellipse(x_pixel_cartesian, radius_pixel, nth_degree) {
            var r_to_the_n = Math.pow(radius_pixel, nth_degree);
            var x_to_the_n_pixel_cartesian = Math.pow(x_pixel_cartesian, nth_degree);
            if (r_to_the_n >= x_to_the_n_pixel_cartesian) {
                var n_root_difference = Math.pow(r_to_the_n - x_to_the_n_pixel_cartesian, 1/nth_degree);
                return n_root_difference;
            } else {
                return undefined;
            }
        }

        function test_get_y_cartesian() {

            // if x is 0, then we should get the radius back,
            var answer = _private.get_y_cartesian_circle(0, 80);
            if(answer === 80) {
                console.log("test passed!");
            } else {
                console.log("such fail. very fail. You should feel bad.");
                console.log("bad answer is very bad: ", answer);
            }
        }

        Component.onCompleted: {
            _private.test_get_y_cartesian()
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        property var bezierPoints_cartesian: [Qt.point(0.5, 0.25), Qt.point(-0.5, 0.25), Qt.point(-0.5, -0.25), Qt.point(0.5, -0.25)]
        property var controlPoints_cartesian: [Qt.point(1, 0), Qt.point(0, 0.5), Qt.point(-1, 0), Qt.point(0, -0.5)]
        property var controlPoints_pixel: [cartesiantoPixelPoint(Qt.point(1, 0)), cartesiantoPixelPoint(Qt.point(0, 0.5)), cartesiantoPixelPoint(Qt.point(-1, 0)), cartesiantoPixelPoint(Qt.point(0, -0.5))]



        onPaint: {

            var ctx = getContext("2d");
            ctx.lineWidth = 1;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";

            var x = canvas.width/2 - 4;
            var y = canvas.height/2 - 4;
            var height = 8;
            var width = 8;

            ctx.beginPath();

            var radius_pixel = 80;

            var x_start_pixel = _top.convert(-radius_pixel, -_top.width/2, _top.width/2, 0, _top.width);
            var x_end_pixel = _top.convert(radius_pixel, -_top.width/2, _top.width/2, 0, _top.width);

            var y_start_pixel = _top.convert(-radius_pixel, -_top.height/2, _top.height/2, 0, _top.height);
            var y_end_pixel = _top.convert(radius_pixel, -_top.height/2, _top.height/2, 0, _top.height);

            var y_pixel_cartesian = 0;
            var y_pixel = 0;
            for (var x_pixel = x_start_pixel; x_pixel < x_end_pixel; x_pixel++) {

                // BOTTOM HALF OF SHAPE
                var x_pixel_cartesian = _top.convert(x_pixel, 0, _top.width, -_top.width/2, _top.width/2);
                y_pixel_cartesian = _private.get_y_cartesian_rectellipse(x_pixel_cartesian, radius_pixel, 6); // calc y for x
                y_pixel = _top.convert(y_pixel_cartesian, -_top.height/2, _top.height/2, 0, _top.height);
                ctx.moveTo(x_pixel, y_pixel);
                y_pixel_cartesian = _private.get_y_cartesian_rectellipse(x_pixel_cartesian + 1, radius_pixel, 6); // calc y for x + 1
                y_pixel = _top.convert(y_pixel_cartesian, -_top.height/2, _top.height/2, 0, _top.height);
                ctx.lineTo(x_pixel + 1, y_pixel);
                ctx.stroke();

                // TOP HALF OF SHAPE
                x_pixel_cartesian = _top.convert(x_pixel, 0, _top.width, -_top.width/2, _top.width/2);
                y_pixel_cartesian = -_private.get_y_cartesian_rectellipse(x_pixel_cartesian, radius_pixel, 6); // calc y for x
                y_pixel = _top.convert(y_pixel_cartesian, -_top.height/2, _top.height/2, 0, _top.height);
                ctx.moveTo(x_pixel, y_pixel);
                y_pixel_cartesian = -_private.get_y_cartesian_rectellipse(x_pixel_cartesian + 1, radius_pixel, 6); // calc y for x + 1
                y_pixel = _top.convert(y_pixel_cartesian, -_top.height/2, _top.height/2, 0, _top.height);
                ctx.lineTo(x_pixel + 1, y_pixel);
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
