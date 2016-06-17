import QtQuick 2.6
import "."


Rectangle {
    anchors.fill: parent
    color: "green"
    opacity: 0.5

    Connections {
        target: MySingleton
        onFunc2: {
            console.log("# MyComponentOne.qml::onFunc2() - MySingleton:", MySingleton)
        }
    }
}
