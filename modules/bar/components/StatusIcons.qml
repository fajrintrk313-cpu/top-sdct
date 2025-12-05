pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

StyledRect {
    id: root

    property color colour: Colours.palette.m3secondary
    readonly property alias items: iconColumn

    color: Colours.tPalette.m3surfaceContainer
<<<<<<< HEAD
    radius: 14

    clip: true
    implicitHeight: Config.bar.sizes.innerHeight
    implicitWidth: iconColumn.implicitWidth + Appearance.padding.normal * 2 - (Config.bar.status.showLockStatus && !Hypr.capsLock && !Hypr.numLock ? iconColumn.spacing : 0)

    RowLayout {
=======
    radius: Appearance.rounding.full

    clip: true
    implicitWidth: Config.bar.sizes.innerWidth
    implicitHeight: iconColumn.implicitHeight + Appearance.padding.normal * 2 - (Config.bar.status.showLockStatus && !Hypr.capsLock && !Hypr.numLock ? iconColumn.spacing : 0)

    ColumnLayout {
>>>>>>> origin/master
        id: iconColumn

        anchors.left: parent.left
        anchors.right: parent.right
<<<<<<< HEAD
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Appearance.padding.normal
        anchors.rightMargin: Appearance.padding.normal
=======
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Appearance.padding.normal
>>>>>>> origin/master

        spacing: Appearance.spacing.smaller / 2

        // Lock keys status
        WrappedLoader {
            name: "lockstatus"
            active: Config.bar.status.showLockStatus

            sourceComponent: ColumnLayout {
                spacing: 0

                Item {
<<<<<<< HEAD
                    implicitWidth: Hypr.capsLock ? capslockIcon.implicitWidth : 0
=======
                    implicitWidth: capslockIcon.implicitWidth
>>>>>>> origin/master
                    implicitHeight: Hypr.capsLock ? capslockIcon.implicitHeight : 0

                    MaterialIcon {
                        id: capslockIcon

                        anchors.centerIn: parent

                        scale: Hypr.capsLock ? 1 : 0.5
                        opacity: Hypr.capsLock ? 1 : 0

                        text: "keyboard_capslock_badge"
                        color: root.colour

                        Behavior on opacity {
                            Anim {}
                        }

                        Behavior on scale {
                            Anim {}
                        }
                    }

                    Behavior on implicitHeight {
                        Anim {}
                    }
<<<<<<< HEAD

                    Behavior on implicitWidth {
                        Anim {}
                    }
=======
>>>>>>> origin/master
                }

                Item {
                    Layout.topMargin: Hypr.capsLock && Hypr.numLock ? iconColumn.spacing : 0

<<<<<<< HEAD
                    implicitWidth: Hypr.numLock ? numlockIcon.implicitWidth : 0
=======
                    implicitWidth: numlockIcon.implicitWidth
>>>>>>> origin/master
                    implicitHeight: Hypr.numLock ? numlockIcon.implicitHeight : 0

                    MaterialIcon {
                        id: numlockIcon

                        anchors.centerIn: parent

                        scale: Hypr.numLock ? 1 : 0.5
                        opacity: Hypr.numLock ? 1 : 0

                        text: "looks_one"
                        color: root.colour

                        Behavior on opacity {
                            Anim {}
                        }

                        Behavior on scale {
                            Anim {}
                        }
                    }

                    Behavior on implicitHeight {
                        Anim {}
                    }
<<<<<<< HEAD

                    Behavior on implicitWidth {
                        Anim {}
                    }
=======
>>>>>>> origin/master
                }
            }
        }

        // Audio icon
        WrappedLoader {
            name: "audio"
            active: Config.bar.status.showAudio

            sourceComponent: MaterialIcon {
                animate: true
                text: Icons.getVolumeIcon(Audio.volume, Audio.muted)
<<<<<<< HEAD
                color: Colours.palette.term3
=======
                color: root.colour
>>>>>>> origin/master
            }
        }

        // Microphone icon
        WrappedLoader {
            name: "audio"
            active: Config.bar.status.showMicrophone

            sourceComponent: MaterialIcon {
                animate: true
                text: Icons.getMicVolumeIcon(Audio.sourceVolume, Audio.sourceMuted)
<<<<<<< HEAD
                color: Colours.palette.m3tertiary
=======
                color: root.colour
>>>>>>> origin/master
            }
        }

        // Keyboard layout icon
        WrappedLoader {
            name: "kblayout"
            active: Config.bar.status.showKbLayout

            sourceComponent: StyledText {
                animate: true
                text: Hypr.kbLayout
                color: root.colour
                font.family: Appearance.font.family.mono
            }
        }

<<<<<<< HEAD
=======
        // Network icon
        WrappedLoader {
            name: "network"
            active: Config.bar.status.showNetwork

            sourceComponent: MaterialIcon {
                animate: true
                text: Network.active ? Icons.getNetworkIcon(Network.active.strength ?? 0) : "wifi_off"
                color: root.colour
            }
        }

>>>>>>> origin/master
        // Bluetooth section
        WrappedLoader {
            Layout.preferredHeight: implicitHeight

            name: "bluetooth"
            active: Config.bar.status.showBluetooth

            sourceComponent: ColumnLayout {
                spacing: Appearance.spacing.smaller / 2

                // Bluetooth icon
                MaterialIcon {
                    animate: true
                    text: {
                        if (!Bluetooth.defaultAdapter?.enabled)
                            return "bluetooth_disabled";
                        if (Bluetooth.devices.values.some(d => d.connected))
                            return "bluetooth_connected";
                        return "bluetooth";
                    }
<<<<<<< HEAD
                    color: Colours.palette.m3primary
=======
                    color: root.colour
>>>>>>> origin/master
                }

                // Connected bluetooth devices
                Repeater {
                    model: ScriptModel {
                        values: Bluetooth.devices.values.filter(d => d.state !== BluetoothDeviceState.Disconnected)
                    }

                    MaterialIcon {
                        id: device

                        required property BluetoothDevice modelData

                        animate: true
                        text: Icons.getBluetoothIcon(modelData?.icon)
                        color: root.colour
                        fill: 1

                        SequentialAnimation on opacity {
                            running: device.modelData?.state !== BluetoothDeviceState.Connected
                            alwaysRunToEnd: true
                            loops: Animation.Infinite

                            Anim {
                                from: 1
                                to: 0
                                duration: Appearance.anim.durations.large
                                easing.bezierCurve: Appearance.anim.curves.standardAccel
                            }
                            Anim {
                                from: 0
                                to: 1
                                duration: Appearance.anim.durations.large
                                easing.bezierCurve: Appearance.anim.curves.standardDecel
                            }
                        }
                    }
                }
            }

            Behavior on Layout.preferredHeight {
                Anim {}
            }
        }

<<<<<<< HEAD
        // Battery icon - iOS 16 style with percentage inside (TRUE iOS shape)
=======
        // Battery icon
>>>>>>> origin/master
        WrappedLoader {
            name: "battery"
            active: Config.bar.status.showBattery

<<<<<<< HEAD
            sourceComponent: Item {
                id: batteryIOS
                implicitWidth: 42
                implicitHeight: Config.bar.sizes.innerHeight

                readonly property real level: UPower.displayDevice.percentage
                readonly property real pct: level * 100
                readonly property bool charging: [
                    UPowerDeviceState.Charging,
                    UPowerDeviceState.FullyCharged,
                    UPowerDeviceState.PendingCharge
                ].includes(UPower.displayDevice.state)

                readonly property color frameColor: pct <= 20 ? Colours.palette.m3error : Colours.palette.m3onSurface
                readonly property color fillColor: {
                    if (charging) return "#34C759";  // Green when charging
                    if (pct <= 20) return "#FF3B30";  // Red (critical)
                    if (pct <= 50) return "#FF9500";  // Orange (low)
                    if (pct <= 80) return "#FFCC00";  // Yellow (medium)
                    return "#34C759";  // Green (good)
                }

        // BODY tanpa outline (iOS Solid Capsule)
        Rectangle {
            id: body
            anchors.verticalCenter: parent.verticalCenter
            width: 32
            height: 16
            radius: height / 2
            color: batteryIOS.frameColor
            
            // isi fill
            Rectangle {
                id: fill
                // anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                // anchors.margins: 0
                width: (parent.width) * (pct / 100)
                height: parent.height
                radius: height / 2
                color: fillColor

                Behavior on width {
                    NumberAnimation {
                        duration: 220
                        easing.type: Easing.OutCubic
                    }
                }
            }

            // persentase di dalam
            Text {
                anchors.centerIn: parent
                text: Math.round(pct).toString()
                font.pixelSize: 10
                font.weight: Font.Bold
                color: pct <= 20 ? Colours.palette.m3surface : Colours.palette.m3surface
                renderType: Text.NativeRendering
            }
        }

        // PENTIL IOS — RUNCING TUMPUL
        Item {
            anchors.left: body.right
            anchors.leftMargin: 1
            anchors.verticalCenter: body.verticalCenter
            width: 5
            height: 8

            // bagian dasar (oval kecil)
            Rectangle {
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                radius: height / 2
                color: batteryIOS.frameColor
            }

                // overlay yang sedikit mengecil → bikin efek runcing
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width * 0.65
                    height: parent.height
                    radius: height / 2
                    color: batteryIOS.frameColor
                }
            }
        }
    }



        // Network icon + SSID - iOS WiFi style
        WrappedLoader {
            name: "network"
            active: Config.bar.status.showNetwork

            sourceComponent: Row {
                spacing: Appearance.spacing.small

                // iOS WiFi indicator (arc waves like real iOS)
                Item {
                    id: wifiIOS
                    implicitWidth: 18
                    implicitHeight: Config.bar.sizes.innerHeight
                    anchors.verticalCenter: parent.verticalCenter

                    readonly property bool connected: Network.active !== null
                    readonly property int strength: connected ? (Network.active.strength ?? 0) : 0
                    readonly property int bars: Math.ceil(strength / 34)  // 0-3 bars
                    readonly property color wifiColor: Colours.palette.term6

                    // Wrapper untuk center semua elements
                    Item {
                        anchors.centerIn: parent
                        width: 16
                        height: 19

                        // Base dot (always visible when connected)
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 3
                            height: 3
                            radius: 1.5
                            color: wifiIOS.connected ? wifiIOS.wifiColor : Qt.rgba(wifiIOS.wifiColor.r, wifiIOS.wifiColor.g, wifiIOS.wifiColor.b, 0.3)

                            Behavior on color {
                                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
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
                            border.color: wifiIOS.bars >= 1 ? wifiIOS.wifiColor : Qt.rgba(wifiIOS.wifiColor.r, wifiIOS.wifiColor.g, wifiIOS.wifiColor.b, 0.3)

                            Behavior on border.color {
                                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
                            }
                        }

                        // Arc 2 (medium)
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 12
                            height: 5
                            radius: 6
                            color: "transparent"
                            border.width: 2
                            border.color: wifiIOS.bars >= 2 ? wifiIOS.wifiColor : Qt.rgba(wifiIOS.wifiColor.r, wifiIOS.wifiColor.g, wifiIOS.wifiColor.b, 0.3)

                            Behavior on border.color {
                                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
                            }
                        }

                        // Arc 3 (large)
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 12
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 16
                            height: 7
                            radius: 8
                            color: "transparent"
                            border.width: 2
                            border.color: wifiIOS.bars >= 3 ? wifiIOS.wifiColor : Qt.rgba(wifiIOS.wifiColor.r, wifiIOS.wifiColor.g, wifiIOS.wifiColor.b, 0.3)

                            Behavior on border.color {
                                ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
                            }
                        }
                    }
                }

                StyledText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: Network.active ? Network.active.ssid : "Disconnected"
                    color: Colours.palette.term6
                    font.pointSize: Appearance.font.size.smaller
                    font.family: Appearance.font.family.sans
                    animate: true
                }
=======
            sourceComponent: MaterialIcon {
                animate: true
                text: {
                    if (!UPower.displayDevice.isLaptopBattery) {
                        if (PowerProfiles.profile === PowerProfile.PowerSaver)
                            return "energy_savings_leaf";
                        if (PowerProfiles.profile === PowerProfile.Performance)
                            return "rocket_launch";
                        return "balance";
                    }

                    const perc = UPower.displayDevice.percentage;
                    const charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(UPower.displayDevice.state);
                    if (perc === 1)
                        return charging ? "battery_charging_full" : "battery_full";
                    let level = Math.floor(perc * 7);
                    if (charging && (level === 4 || level === 1))
                        level--;
                    return charging ? `battery_charging_${(level + 3) * 10}` : `battery_${level}_bar`;
                }
                color: !UPower.onBattery || UPower.displayDevice.percentage > 0.2 ? root.colour : Colours.palette.m3error
                fill: 1
>>>>>>> origin/master
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
