import QtQuick
import QtQuick3D

Item {
    id: root

    width: 700
    height: 700

    property real rpm: 1800

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#080A12"
            backgroundMode: SceneEnvironment.Color
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, 800)
            clipFar: 2000
        }

        camera: camera

        DirectionalLight {
            eulerRotation.x: -35
            eulerRotation.y: -25
            brightness: 1.8
        }

        PointLight {
            position: Qt.vector3d(-180, 220, 200)
            brightness: 60
            color: "#00E6B2"
        }

        // Central metallic hub
        Model {
            source: "#Sphere"
            scale: Qt.vector3d(0.5, 0.5, 0.15)

            materials: PrincipledMaterial {
                baseColor: "#434851"
                metalness: 0.9
                roughness: 0.25
            }
        }

        // Initial 3D needle

        Node {
            id: needlePivot

            eulerRotation.z: 225 - (root.rpm / 9000) * 270 - 90

            Behavior on eulerRotation.z {
                NumberAnimation {
                    duration: 350
                    easing.type: Easing.OutCubic
                }
            }

            Model {
                source: "#Cube"

                position: Qt.vector3d(0, 110, 25)

                scale: Qt.vector3d(0.055, 2.2, 0.04)

                materials: PrincipledMaterial {
                    baseColor: "#FFFFFF"
                    metalness: 0.4
                    roughness: 0.2
                }
            }
        }

        MetallicRing {
            radius: 300
        }

        RpmMarkers {
            radius: 315
        }

        DirectionalLight {
            eulerRotation: Qt.vector3d(-35, -25, 0)
            brightness: 2.0
            color: "#FFFFFF"
        }

        DirectionalLight {
            eulerRotation: Qt.vector3d(25, 45, 0)
            brightness: 0.8
            color: "#8FA6C8"
        }

        PointLight {
            position: Qt.vector3d(-180, 220, 250)
            brightness: 35
            color: "#00E6B2"
        }
    }


    Repeater {
        model: 10

        delegate: Text {
            required property int index

            property real angle:
                (225 - index * 30) * Math.PI / 180

            property real radius: root.width * 0.285

            x: root.width / 2 +
               Math.cos(angle) * radius - width / 2

            y: root.height / 2 -
               Math.sin(angle) * radius - height / 2

            text: index
            color: "#FFFFFF"

            font.pixelSize: root.width * 0.045
            font.bold: true
        }
    }

}
