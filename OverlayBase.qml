import QtQuick 2.0

Item {

    id: _top

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
                                            "columns" : 8
                                         },
                            }

    anchors.fill: parent

    property int centerX: _top.width/2
    property int centerY: _top.height/2

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

    Rectangle {
        id: grid
        color: "transparent"
        anchors.fill: parent

        Repeater {
            id: rowDividers
            property int rowHeight: _top.height/_top.settings.grid.rows
            model: 5//_top.settings.grid.rows - 1
            delegate: Rectangle {
                width: _top.width
                height: 3//_top.settings.axisPixelWidth
            }
        }

        Repeater {
            id: columnDividers
            model: _top.settings.grid.columns - 1
            delegate: Rectangle {
                width: _top.settings.axisPixelWidth
                height:_top.height
            }
        }
    }
}
