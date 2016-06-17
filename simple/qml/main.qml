import QtQuick 2.6
import QtQuick.Window 2.2
import "."


Window {
    id: window1
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: rec1
        width: 0.33*parent.width
        height: 0.25*parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        color: "blue"
        opacity: 0.5
        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: {
                // console.log("# main.qml::rec1::onClicked() A - MySingleton:", MySingleton)
                loader.source = "qrc:/qml/MyComponentOne.qml";
                // console.log("# main.qml::rec1::onClicked() B - MySingleton:", MySingleton)
            }
        }
    }

    Rectangle {
        id: rec2
        width: rec1.width
        anchors.left: rec1.right
        anchors.top: parent.top
        anchors.bottom: rec1.bottom
        color: "#16ece9"
        opacity: 0.5
        MouseArea {
            id: mouseAreaGo
            anchors.fill: parent
            onClicked: {
                // console.log("# main.qml::rec2::onClicked() A - MySingleton:", MySingleton)
                MySingleton.func1();
                // console.log("# main.qml::rec2::onClicked() B - MySingleton:", MySingleton)
            }
        }
    }

    Rectangle {
        id: rec3
        anchors.left: rec2.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: rec1.bottom
        color: "red"
        opacity: 0.5
        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            onClicked: {
                // console.log("# main.qml::rec3::onClicked() A - MySingleton:", MySingleton)
                loader.source = "qrc:/qml/MyComponentTwo.qml";
                // console.log("# main.qml::rec3::onClicked() B - MySingleton:", MySingleton)
            }
        }
    }

    Rectangle {
        id: item1
        anchors.top: rec1.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        Loader {
            id: loader
            anchors.fill: parent
        }
    }
}
