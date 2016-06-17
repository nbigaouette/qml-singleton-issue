# QML Singleton Issue

This repository contains a minimal working example tha tries to describe
an issue I have with QML Singletons.

See also: http://forum.qt.io/topic/68350/problem-with-singleton-why-isn-t-it-unique/2

## Problem Description

I would like to have a QML Singleton to dispatch signals to whoever is interested
in receiving them. This way, I can reduce the coupling between my QML components.

For example, I need to dynamically load different QML files to occupy a certain
region of the window. I have a button in the main window that I need to trigger
an action from _inside_ this dynamically loaded component. What could be done
is to pass information about the main window to the dynamically loaded component.
All components would need to agree on an API; adding a requirement to one component
might require adapting all others, which I want to avoid.

Instead, I want to go through the singleton which would act like a global variable,
dispatching signals. The button on the main page would call a function in the singleton.
If no component registered to the singleton (using `Connections`) then the signal is
ignored. In the different dynamically loaded components, I simply have to connect
to the singleton's signal to be able to "listen" to the signal and perform an action
specific to the dynamically loaded component:

```qml
Connections {
    target: MySingleton
    onFunc2: {
        console.log("# MyComponentOne.qml::onFunc2() - MySingleton:", MySingleton)
    }
}

```

While this works for the `simple` example, I have trouble getting a singleton behaviour
for `MySingleton` when I add this to an already existing code base.

I will attempt to reproduce the problem in this repository.


# Usage

Simply configure using `qmake` (Qt >5.6) and build:

```
cd build
qmake ../simple
make
./simple
```

# Example output

Build and run, then click on the blue rectangle, than the red rectangle, than
finally the cyan rectangle:

```
./simple
QML debugging is enabled. Only use this in a safe environment.
qml: # main.qml::rec1::onClicked() A - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec1::onClicked() B - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec2::onClicked() A - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MySingleton.qml::func1()      - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MySingleton.qml::onFunc2()    - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MyComponentOne.qml::onFunc2() - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec2::onClicked() B - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec3::onClicked() A - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec3::onClicked() B - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec2::onClicked() A - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MySingleton.qml::func1()      - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MySingleton.qml::onFunc2()    - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # MyComponentTwo.qml::onFunc2() - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
qml: # main.qml::rec2::onClicked() B - MySingleton: MySingleton_QMLTYPE_0(0x2d52e90)
```

Note how the `MySingleton` object is the same, whoever prints it, showing that it
is really a singleton.
