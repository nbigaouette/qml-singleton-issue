pragma Singleton
import QtQuick 2.0

Item {
    function func1() {
        console.log("# MySingleton.qml::func1()      - MySingleton:", this)
        func2()
    }

    signal func2();

    onFunc2: {
        console.log("# MySingleton.qml::onFunc2()    - MySingleton:", this)
    }
}
