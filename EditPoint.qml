import QtQuick 2.12

Rectangle {
    property int x_: x+width/2
    property int y_: y+height/2

    color: "red"
    width: 10
    height: width
    radius: height/2
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: width
    Drag.hotSpot.y: height
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
    }
}
