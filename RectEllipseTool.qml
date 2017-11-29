import QtQuick 2.0
import QtQuick.Layouts 1.3

OverlayBase {
    id: _top
    anchors.fill: parent

    Item {
        id: _private
    }

    Rectangle {
     ColumnLayout {
        anchors.fill: parent
        Text { text: "canvas w: " + canvas.width + "h: " + canvas.height }
     }

    }

    Canvas {
        id: canvas
        anchors.fill: parent
        property var controlPoints_cartesian: [Qt.point(1, 0), Qt.point(0, 0.5), Qt.point(-1, 0), Qt.point(0, -0.5)]

        //@ash: say what this does
        function cartesiantoPixelPoint(cartesianPoint) {
            var x = canvas.convertValueFromOldBoundariesToNewBoundarySpace(cartesianPoint.x, -1, 1, 0, canvas.width);
            // this might seem backwards, but we have to do this because positive y is down for pixel space in qml objects
            var y = canvas.convertValueFromOldBoundariesToNewBoundarySpace(cartesianPoint.y, -1, 1, canvas.height, 0);
            return Qt.point(x, y);
        }

        //@ash: say what this does
        function convertValueFromOldBoundariesToNewBoundarySpace(valueToConvert, lowOld, HighOld, lowNew, highNew) {
            var returnValue = (valueToConvert-lowOld) / (HighOld-lowOld) * (highNew-lowNew) + lowNew;
            return returnValue;
        }

        onPaint: {
            var ctx = getContext("2d");
            var lineWidth = 3;

            var x = canvas.width/2 - 4;
            var y = canvas.height/2 - 4;
            var height = 8;
            var width = 8;
//            ctx.ellipse(x, y, width, height);
//            ctx.stroke();

            ctx.beginPath();
            var firstPixelPoint = canvas.cartesiantoPixelPoint(canvas.controlPoints_cartesian[0]);
            var nextPixelPoint = canvas.cartesiantoPixelPoint(canvas.controlPoints_cartesian[1]);
            ctx.moveTo(firstPixelPoint.x, firstPixelPoint.y);
            ctx.lineTo(nextPixelPoint.x, nextPixelPoint.y);
            ctx.stroke();
            for(var i = 0; i < controlPoints_cartesian.length; i++) {
                nextPixelPoint = canvas.cartesiantoPixelPoint(canvas.controlPoints_cartesian[i]);
                ctx.lineTo(nextPixelPoint.x, nextPixelPoint.y);
                ctx.moveTo(nextPixelPoint.x, nextPixelPoint.y);
                ctx.stroke();

            }
        }

    }
}
