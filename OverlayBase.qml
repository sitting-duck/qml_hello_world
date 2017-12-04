import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {

    id: _top

    anchors.fill: parent

    //@ash: say what this does
    function cartesiantoPixelPoint(cartesianPoint) {
        var x = _top.convert(cartesianPoint.x, -1, 1, 0, canvas.width);
        // this might seem backwards, but we have to do this because positive y is down for pixel space in qml objects
        var y = _top.convert(cartesianPoint.y, -1, 1, canvas.height, 0);
        return Qt.point(x, y);
    }

    //@ash: say what this does
    function convert(valueToConvert, lowOld, HighOld, lowNew, highNew) {
        var returnValue = (valueToConvert-lowOld) / (HighOld-lowOld) * (highNew-lowNew) + lowNew;
        return returnValue;
    }   

    property var settings:  {
        "showAxes" : true,
                "axisColor" : "#FF0000",
                "axisPixelWidth" : 3,
                "axisOpacity" : 0.3,
                "showMetrics" : true,
                "metric" :  {
            "pixel" : true,
            "normalized_cartesian" : true
        },
        "grid" : {
            "visible" : true,
            "rows" : 8,
            "columns" : 8,
            "color" : "#00FF00",
            "ticks" : true,
            "tickLength" : 10
        }
    }

    property int centerX: _top.width/2
    property int centerY: _top.height/2

    ExclusiveGroup { id: buttonGroup }
    Item {
        id: buttonsRowContainerRect
        width: buttonsRowLayout.implicitWidth
        height: buttonsRowLayout.implicitHeight
        RowLayout {
            id: buttonsRowLayout

            Repeater {
                model: 4
                delegate: Button {
                    property var buttonIndex: index
                    property var textModel: ["cartesian_normal", "cartesian_pixel", "pixel", "normal"]
                    width: parent.width/4
                    height: 100
                    exclusiveGroup: buttonGroup
                    checkable: true
                    checked: index === 2 // pixel coordinates selected by default
                    text: textModel[index]
                }
            }
        }
    }

    Rectangle {
        id: xAxis
        visible: _top.settings.showAxes
        height:_top.settings.axisPixelWidth
        width: _top.width
        x: 0
        y: _top.centerY - _top.settings.axisPixelWidth/2
        color: _top.settings.axisColor
        opacity: _top.settings.axisOpacity
    }

    Rectangle {
        id: yAxis
        visible: _top.settings.showAxes
        height: _top.height
        width: _top.settings.axisPixelWidth
        x: _top.centerX - _top.settings.axisPixelWidth/2
        y: 0
        color: _top.settings.axisColor
        opacity: _top.settings.axisOpacity
    }

    Repeater {
        id: rowDividers
        property int rowHeight: _top.height/_top.settings.grid.rows
        model: _top.settings.grid.rows - 1
        delegate: Rectangle {
            id: rowGridline

            Text {
                id: labelText_row
                property var cartesian_pixel: _top.convert(rowGridline.y, 0, _top.height, -_top.height/2, _top.height/2)
                property var cartesian_normal: _top.convert(rowGridline.y, 0, _top.height, 1, -1).toFixed(2)
                property var normal: _top.convert(rowGridline.y, 0, _top.height, 1, 0).toFixed(2)
                property var output: [labelText_row.cartesian_normal, labelText_row.cartesian_pixel, rowGridline.y, labelText_row.normal]
                text: labelText_row.output[buttonGroup.current.buttonIndex]
                font.pixelSize: rowTextMa.containsMouse ? 15 : 5
                MouseArea {
                    id: rowTextMa
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }

            visible: _top.settings.grid.visible
            color: _top.settings.grid.color
            width: _top.settings.grid.ticks ? _top.settings.grid.tickLength : _top.width
            height: _top.settings.axisPixelWidth
            x: _top.settings.grid.ticks ? _top.width/2 - _top.settings.grid.tickLength/2 : 0
            y: (_top.height/_top.settings.grid.rows)*(index+1) - _top.settings.axisPixelWidth/2
        }
    }

    Repeater {
        id: columnDividers
        model: _top.settings.grid.columns - 1
        delegate: Rectangle {
            id: columnGridline

            Text {
                id: labelText_column
                property var cartesian_pixel: _top.convert(columnGridline.x, 0, _top.width, -_top.width/2, _top.width/2)
                property var cartesian_normal: _top.convert(columnGridline.x, 0, _top.width, 1, -1).toFixed(2)
                property var normal: _top.convert(columnGridline.x, 0, _top.width, 0, 1).toFixed(2)
                property var output: [labelText_column.normal, labelText_column.cartesian_pixel, columnGridline.x, labelText_column.normal]
                text: labelText_column.output[buttonGroup.current.buttonIndex]
                font.pixelSize: columnTextMa.containsMouse ? 15 : 5
                MouseArea {
                    id: columnTextMa
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }

            visible: _top.settings.grid.visible
            color: _top.settings.grid.color
            width: _top.settings.axisPixelWidth
            height:_top.settings.grid.ticks ? _top.settings.grid.tickLength : _top.height
            x: (_top.width/_top.settings.grid.columns)*(index+1) - _top.settings.axisPixelWidth/2
            y: _top.settings.grid.ticks ? _top.height/2 - _top.settings.grid.tickLength/2 : 0
        }
    }
}
