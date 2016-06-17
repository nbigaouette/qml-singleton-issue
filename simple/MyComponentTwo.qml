import QtQuick 2.6
import "."


Rectangle {
    anchors.fill: parent
    color: "yellow"
    opacity: 0.5

    Connections {
        target: MySingleton
        onFunc2: {
            console.log("# MyComponentTwo.qml::onFunc2() - MySingleton:", MySingleton)
        }
    }
}
