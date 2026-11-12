
import QtQuick
import QtQuick3D

Node {
    id: ring

    property real radius: 300
    property int segments: 180

    // Outer metallic bezel
    Repeater3D {
        model: ring.segments

        delegate: Model {
            required property int index

            property real angle: index * 360 / ring.segments
            property real rad: angle * Math.PI / 180

            source: "#Cube"

            position: Qt.vector3d(
                Math.sin(rad) * ring.radius,
                Math.cos(rad) * ring.radius,
                -5
            )

            scale: Qt.vector3d(0.16, 0.22, 0.18)

            eulerRotation.z: -angle

            materials: PrincipledMaterial {
                baseColor: "#454C58"
                metalness: 0.95
                roughness: 0.22
            }
        }
    }

    // Inner dark bevel
    Repeater3D {
        model: ring.segments

        delegate: Model {
            required property int index

            property real angle: index * 360 / ring.segments
            property real rad: angle * Math.PI / 180

            source: "#Cube"

            position: Qt.vector3d(
                Math.sin(rad) * (ring.radius - 14),
                Math.cos(rad) * (ring.radius - 14),
                8
            )

            scale: Qt.vector3d(0.12, 0.14, 0.10)

            eulerRotation.z: -angle

            materials: PrincipledMaterial {
                baseColor: "#343A44"
                metalness: 0.95
                roughness: 0.18
            }

            Model {
                source: "#Sphere"
                position: Qt.vector3d(0, 0, 30)
                scale: Qt.vector3d(0.28, 0.28, 0.08)

                materials: PrincipledMaterial {
                    baseColor: "#59616D"
                    metalness: 0.9
                    roughness: 0.2
                }
            }
        }
    }

    // Thin highlight ring
    Repeater3D {
        model: ring.segments

        delegate: Model {
            required property int index

            property real angle: index * 360 / ring.segments
            property real rad: angle * Math.PI / 180

            source: "#Cube"

            position: Qt.vector3d(
                Math.sin(rad) * (ring.radius + 5),
                Math.cos(rad) * (ring.radius + 5),
                13
            )

            scale: Qt.vector3d(0.035, 0.10, 0.025)

            eulerRotation.z: -angle

            materials: PrincipledMaterial {
                baseColor: "#7D8794"
                metalness: 0.95
                roughness: 0.15
            }
        }
    }
}
