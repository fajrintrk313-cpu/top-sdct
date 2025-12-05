pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

StyledRect {
    id: root

    // property color colour: Colours.palette.m3secondary
    readonly property alias items: iconColumn

    // color: Colours.tPalette.m3surfaceContainer
    // radius: 14

    clip: true
    implicitHeight: Config.bar.sizes.innerHeight
    implicitWidth: iconColumn.implicitWidth

    RowLayout {
        id: iconColumn

        // anchors.left: parent.left
        anchors.right: parent.right
        // anchors.verticalCenter: parent.verticalCenter
        // anchors.leftMargin: Appearance.padding.normal
        // anchors.rightMargin: Appearance.padding.normal

        spacing: Appearance.spacing.small

        // Network icon - iOS WiFi style with IP address
        WrappedLoader {
            name: "network"
            active: Config.bar.status.showNetwork

            sourceComponent: Item {
                id: wifiIOS
                implicitWidth: ssidText.width + Appearance.spacing.small + 22
                implicitHeight: Config.bar.sizes.innerHeight

                readonly property bool connected: Network.active !== null
                readonly property int strength: connected ? (Network.active.strength ?? 0) : 0
                readonly property int bars: Math.ceil(strength / 34)  // 0-3 bars
                readonly property color activeColor: Colours.palette.m3onSurface
                readonly property color inactiveColor: Colours.palette.m3outline
                readonly property string ssid: connected ? (Network.active.ssid ?? "") : ""

                // SSID text with container
                Rectangle {
                    id: ssidText
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    visible: wifiIOS.ssid !== ""
                    
                    color: Colours.palette.m3surfaceContainer
                    radius: 14
                    
                    width: ssidLabel.implicitWidth + Appearance.padding.normal * 2
                    height: Config.bar.sizes.innerHeight
                    
                    Text {
                        id: ssidLabel
                        anchors.centerIn: parent
                        text: wifiIOS.ssid
                        font.pixelSize: Appearance.fontSize.smaller
                        font.family: Appearance.font.family.mono
                        color: Colours.palette.m3onSurface
                    }
                }

                // Wrapper untuk center semua elements
                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    width: 20
                    height: 16

                    // Base dot (always visible when connected)
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 3
                        height: 3
                        radius: 1.5
                        color: wifiIOS.connected ? wifiIOS.activeColor : wifiIOS.inactiveColor

                        // Breathing animation when connecting (weak signal)
                        SequentialAnimation on opacity {
                            running: wifiIOS.connected && wifiIOS.bars < 3
                            loops: Animation.Infinite
                            NumberAnimation { from: 1; to: 0.4; duration: 1200; easing.type: Easing.InOutQuad }
                            NumberAnimation { from: 0.4; to: 1; duration: 1200; easing.type: Easing.InOutQuad }
                        }

                        Behavior on color {
                            ColorAnimation { duration: 300; easing.type: Easing.OutBack }
                        }
                    }

                    // Arc 1 (small)
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 8
                        height: 3
                        radius: 4
                        color: "transparent"
                        border.width: 2
                        border.color: wifiIOS.bars >= 1 ? wifiIOS.activeColor : wifiIOS.inactiveColor

                        Behavior on border.color {
                            ColorAnimation { duration: 400; easing.type: Easing.OutBack; easing.overshoot: 1.2 }
                        }
                    }

                    // Arc 2 (medium)
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 7
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 13
                        height: 5
                        radius: 6.5
                        color: "transparent"
                        border.width: 2
                        border.color: wifiIOS.bars >= 2 ? wifiIOS.activeColor : wifiIOS.inactiveColor

                        Behavior on border.color {
                            ColorAnimation { duration: 450; easing.type: Easing.OutBack; easing.overshoot: 1.2 }
                        }
                    }

                    // Arc 3 (large)
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 18
                        height: 7
                        radius: 9
                        color: "transparent"
                        border.width: 2
                        border.color: wifiIOS.bars >= 3 ? wifiIOS.activeColor : wifiIOS.inactiveColor

                        Behavior on border.color {
                            ColorAnimation { duration: 500; easing.type: Easing.OutBack; easing.overshoot: 1.2 }
                        }
                    }
                }
            }
        }

        // Battery icon - iOS 16 style with percentage inside (TRUE iOS shape)
        WrappedLoader {
            name: "battery"
            active: Config.bar.status.showBattery

            sourceComponent: Item {
                id: batteryIOS
                implicitWidth: 35
                implicitHeight: Config.bar.sizes.innerHeight

                readonly property real level: UPower.displayDevice.percentage
                readonly property real pct: level * 100
                readonly property bool charging: [
                    UPowerDeviceState.Charging,
                    UPowerDeviceState.FullyCharged,
                    UPowerDeviceState.PendingCharge
                ].includes(UPower.displayDevice.state)

                readonly property color frameColor: Colours.palette.m3outline
                readonly property color fillColor: {
                    if (charging) return "#34C759";  // Green when charging
                    if (pct <= 20) return "#FF3B30";  // Red (critical)
                    if (pct <= 50) return "#FF9500";  // Orange (low)
                    // if (pct <= 80) return "#FFCC00";  // Yellow (medium)
                    return Colours.palette.m3onSurface;  // Neutral white/gray (discharge normal)
                }

        // BODY tanpa outline (iOS Solid Capsule)
        Rectangle {
            id: body
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 16
            radius: 6
            color: batteryIOS.frameColor
            clip: true
            
            // isi fill dengan radius per-corner
            Rectangle {
                id: fill
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                // Width: maksimal sampai (body.width - margin) untuk avoid area rounded body di kanan
                // Ketika 100%, boleh full width untuk merge dengan body rounding
                readonly property real maxFillWidth: pct >= 99 ? parent.width : parent.width - 6
                width: Math.max(0, Math.min((maxFillWidth) * (pct / 100), maxFillWidth))
                height: parent.height
                color: fillColor
                
                // Left side always rounded
                topLeftRadius: 6
                bottomLeftRadius: 6
                // Right side: flat (fill never reaches the rounded corner area of body)
                topRightRadius: 0
                bottomRightRadius: 0

                // Breathing animation when charging
                SequentialAnimation on opacity {
                    running: batteryIOS.charging
                    loops: Animation.Infinite
                    NumberAnimation { from: 1; to: 0.7; duration: 1500; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 0.7; to: 1; duration: 1500; easing.type: Easing.InOutQuad }
                }

                // Pulse animation when low battery (not charging)
                SequentialAnimation on scale {
                    running: !batteryIOS.charging && batteryIOS.pct <= 20
                    loops: Animation.Infinite
                    NumberAnimation { from: 1; to: 1.08; duration: 800; easing.type: Easing.OutQuad }
                    NumberAnimation { from: 1.08; to: 1; duration: 800; easing.type: Easing.InQuad }
                    PauseAnimation { duration: 2000 }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.1
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 500
                        easing.type: Easing.OutQuad
                    }
                }
            }

            // persentase di dalam
            // Text (percentage)
            Text {
                anchors.centerIn: parent
                text: Math.round(batteryIOS.pct).toString()
                font.pixelSize: 10
                font.bold: true
                color: batteryIOS.pct <= 20 ? Colours.palette.m3surface : Colours.palette.m3surface
            }
        }

        // Pentil (tip) iOS - rounded trapezoid (segitiga tumpul)
        Canvas {
            anchors.left: body.right
            anchors.leftMargin: 0.5
            anchors.verticalCenter: parent.verticalCenter
            width: 2
            height: 7
            
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                
                ctx.fillStyle = batteryIOS.frameColor
                ctx.beginPath()
                
                // Start from left side (wider)
                ctx.moveTo(0, height * 0.2) // Top left (20% from top)
                
                // Top line going right and inward
                ctx.lineTo(width, height * 0.35) // Top right (35% from top, narrower)
                
                // Right side (rounded tip)
                ctx.arcTo(width + 1, height * 0.5, width, height * 0.65, 1.5) // Rounded corner
                
                // Bottom line going left
                ctx.lineTo(0, height * 0.8) // Bottom left (80% from top)
                
                // Left side (connect back with slight curve)
                ctx.arcTo(-0.5, height * 0.5, 0, height * 0.2, 1) // Rounded corner
                
                ctx.closePath()
                ctx.fill()
            }
            
            Connections {
                target: batteryIOS
                function onFrameColorChanged() { parent.requestPaint() }
            }
        }
            }
        }
    }

    component WrappedLoader: Loader {
        required property string name

        Layout.alignment: Qt.AlignHCenter
        asynchronous: true
        visible: active
    }
}
