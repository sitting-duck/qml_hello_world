import QtQuick 2.0

Item {
    id: _top
    anchors.fill: parent

    Item {
        id: _private
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            var lineWidth = 3;

            var x = canvas.width/2 - 4;
            var y = canvas.height/2 - 4;
            var height = 8;
            var width = 8;
            ctx.ellipse(x, y, width, height);
            ctx.stroke();


        }

    }
}
