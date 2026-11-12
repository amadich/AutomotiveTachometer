
import QtQuick
import QtQuick.Window

Window {
    id: window
    width: 1100
    height: 750
    visible: true
    color: "#080A12"
    title: "Automotive Tachometer"

    Item {
        id: gauge
        width: Math.min(window.width * 0.85,
                        window.height * 0.9)
        height: width
        anchors.centerIn: parent

        property real rpm: engineSimulator.rpm
        property real maxRpm: 9000
        property real startAngle: 135
        property real sweepAngle: 270

        function angleForRpm(value) {
            return startAngle +
                   (value / maxRpm) * sweepAngle
        }

        Canvas {
            id: dial
            anchors.fill: parent

            onPaint: {
                let ctx = getContext("2d")
                ctx.reset()

                let cx = width / 2
                let cy = height / 2
                let r = width * 0.40

                // Background
                ctx.beginPath()
                ctx.arc(cx, cy, r, 0, Math.PI * 2)
                ctx.fillStyle = "#030405"
                ctx.fill()

                // Outer metallic ring
                ctx.beginPath()
                ctx.arc(cx, cy, r, 0, Math.PI * 2)
                ctx.lineWidth = 18
                ctx.strokeStyle = "#30343D"
                ctx.stroke()

                // RPM ticks
                for (let i = 0; i <= 45; i++) {
                    let value = i * 200
                    let angle = (gauge.angleForRpm(value) - 90)
                                * Math.PI / 180

                    let major = i % 5 === 0
                    let inner = major ? r - 24 : r - 12
                    let outer = r + 9

                    ctx.beginPath()
                    ctx.moveTo(
                        cx + Math.cos(angle) * inner,
                        cy + Math.sin(angle) * inner
                    )
                    ctx.lineTo(
                        cx + Math.cos(angle) * outer,
                        cy + Math.sin(angle) * outer
                    )

                    ctx.lineWidth = major ? 6 : 3
                    ctx.strokeStyle = major
                                      ? "#FFFFFF"
                                      : "#00E6B2"
                    ctx.stroke()
                }

                // High RPM zone: 8000 - 9000
                let start = (gauge.angleForRpm(9000) - 90)
                            * Math.PI / 180

                let end = (gauge.angleForRpm(8000) - 90)
                          * Math.PI / 180

                ctx.beginPath()
                ctx.arc(cx, cy, r + 23, start, end, false)
                ctx.lineWidth = 12
                ctx.strokeStyle = "#FFFFFF"
                ctx.stroke()
            }

        }

        // Numbers 0 - 9
        Repeater {
            model: 10

            Text {
                required property int index

                property real angle:
                    (gauge.angleForRpm(index * 1000) - 90)
                    * Math.PI / 180

                property real radius: gauge.width * 0.32

                x: gauge.width / 2 +
                   Math.cos(angle) * radius - width / 2

                y: gauge.height / 2 +
                   Math.sin(angle) * radius - height / 2

                text: index
                color: "white"
                font.pixelSize: gauge.width * 0.052
                font.bold: true
            }
        }

        // Needle
        Item {
            id: needle
            anchors.centerIn: parent
            width: gauge.width * 0.68
            height: 12

            rotation: gauge.angleForRpm(gauge.rpm) - 180

            Behavior on rotation {
                NumberAnimation {
                    duration: 450
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                width: parent.width / 2
                height: 7
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                radius: 2
            }
        }

        // Center cap
        Rectangle {
            width: gauge.width * 0.11
            height: width
            radius: width / 2
            anchors.centerIn: parent
            color: "#292D33"
            border.color: "#777C85"
            border.width: 2
        }

        // Demo animation
        Timer {
            interval: 1500
            running: true
            repeat: true

            onTriggered: {
                gauge.rpm = Math.random() * 8500
            }
        }
    }

    Item {
        id: keyboardController

        anchors.fill: parent
        focus: true

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Space ||
                event.key === Qt.Key_Up) {

                engineSimulator.setAccelerating(true)
                event.accepted = true
            }
        }

        Keys.onReleased: function(event) {
            if (event.key === Qt.Key_Space ||
                event.key === Qt.Key_Up) {

                engineSimulator.setAccelerating(false)
                event.accepted = true
            }
        }
    }
}
