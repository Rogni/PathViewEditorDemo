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
                value: 99
            }
        }
    }

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
                x: fp2.x_
                y: fp2.y_
                controlX: fp2Control.x_
                controlY: fp2Control.y_
            }

        }
    }

    Item {

        anchors.fill: parent
        EditPoint {
            id: startRect
        }
        EditPoint {
            id: fp
        }
        EditPoint {
            id: fpControl
        }
        EditPoint {
            id: fp2
        }
        EditPoint {
            id: fp2Control
        }


    }


}
