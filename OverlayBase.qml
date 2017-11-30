import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {

    id: _top

    anchors.fill: parent

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
            "visible" : false,
            "rows" : 8,
            "columns" : 8,
            "color" : "#00FF00"
        },
    }

    property int centerX: _top.width/2
    property int centerY: _top.height/2

    ExclusiveGroup { id: buttonGroup }
    Rectangle {
        width: buttonsRowLayout.implicitWidth
        height: buttonsRowLayout.implicitHeight
        RowLayout {
            id: buttonsRowLayout
            Repeater {

                model: 4
                delegate: Button {
                    width: 20
                    height: 10
                    exclusiveGroup: buttonGroup
                    Text {
                        anchors.centerIn: parent
                        text: "" + index
                    }
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
            visible: _top.settings.grid.visible
            color: _top.settings.grid.color
            width: _top.width
            height: _top.settings.axisPixelWidth
            x: 0
            y: (_top.height/_top.settings.grid.rows)*(index+1) - _top.settings.axisPixelWidth/2
        }
    }

    Repeater {
        id: columnDividers
        model: _top.settings.grid.columns - 1
        delegate: Rectangle {
            visible: _top.settings.grid.visible
            color: _top.settings.grid.color
            width: _top.settings.axisPixelWidth
            height:_top.height
            x: (_top.width/_top.settings.grid.columns)*(index+1) - _top.settings.axisPixelWidth/2
            y: 0
        }
    }
}
