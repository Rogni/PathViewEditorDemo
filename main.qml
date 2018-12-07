import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Path editor")

    property int elementsCount: elementsCountSpinBox.value
    onElementsCountChanged: {
        updatePath()
    }
    Component.onCompleted: updatePath()
    property var elements: []

    function updatePath() {
        elements = []
        for (var i = 0; i < elementsCount; ++i) {
            elements.push(Qt.rgba(i/(elementsCount+1),(i-elementsCount)/(elementsCount+1),1, 1))
        }
        pathView.model = elements
    }

    header: ToolBar {
        Row {
            SpinBox {
                id: elementsCountSpinBox
                value: 10
                editable: true
            }
        }
    }

    Item {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.left: leftMenu.right
        PathView {
            id: pathView
            anchors.fill: parent
            model: elements

            delegate: Rectangle {
                color: modelData
                width: 6
                height: width
                radius: width/2
            }

            path: Path {
                startX: startRect.x_
                startY: startRect.y_

                PathQuad {
                    x: fp.x_
                    y: fp.y_
                    controlX: fpControl.x_
                    controlY: fpControl.y_
                }
                PathQuad {
                    x: sp.x_
                    y: sp.y_
                    controlX: spControl.x_
                    controlY: spControl.y_
                }

            }
        }

        Item {

            anchors.fill: parent
            EditPoint {
                id: startRect
            }
            EditPoint {
                id: fpControl
                x: 60
                y: 60
            }
            EditPoint {
                id: fp
                x: 40
                y: 40
            }

            EditPoint {
                id: sp
                x: 80
                y: 40
            }
            EditPoint {
                id: spControl
                x: 100
                y: 100
            }
        }

    }

    Page {
        id: leftMenu
        width: 200
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        Column {
            Label {
                text: "start: (%1, %2)".arg(startRect.x_).arg(startRect.y_)
            }
            Label {
                text: "First Point controll: (%1, %2)".arg(fpControl.x_).arg(fpControl.y_)
            }
            Label {
                text: "First Point end: (%1, %2)".arg(fp.x_).arg(fp.y_)
            }
            Label {
                text: "Second Point controll: (%1, %2)".arg(spControl.x_).arg(spControl.y_)
            }
            Label {
                text: "Second Point end: (%1, %2)".arg(sp.x_).arg(sp.y_)
            }
        }
    }

}
