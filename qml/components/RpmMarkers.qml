import QtQuick
import QtQuick3D

Node {
    id: markers

    property real radius: 315
    property int totalTicks: 46

    Repeater3D {
        model: markers.totalTicks

        delegate: Model {
            required property int index

            property bool major: index % 5 === 0

            // 0 at bottom-left, 9 at bottom-right
            property real angle: 225 - index * 6
            property real radians:
                angle * Math.PI / 180

            source: "#Cube"

            position: Qt.vector3d(
                Math.cos(radians) * markers.radius,
                Math.sin(radians) * markers.radius,
                18
            )

            scale: Qt.vector3d(
                major ? 0.07 : 0.035,
                major ? 0.32 : 0.18,
                0.025
            )

            eulerRotation.z: angle - 90

            materials: PrincipledMaterial {
                baseColor: major ? "#FFFFFF" : "#00E6B2"
                metalness: 0.1
                roughness: 0.25
            }
        }
    }
}
