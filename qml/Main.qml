import QtQuick
import QtQuick.Window

Window {
    width: 1100
    height: 750
    visible: true
    color: "#080A12"
    title: "Automotive Tachometer 3D"

    Tachometer3D {
        anchors.centerIn: parent
        rpm: engineSimulator.rpm
    }
}