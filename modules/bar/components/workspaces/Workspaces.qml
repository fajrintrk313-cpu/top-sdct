pragma ComponentBehavior: Bound

import qs.services
import qs.config
import qs.components
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

StyledClippingRect {
    id: root

    required property ShellScreen screen

    readonly property bool onSpecial: (Config.bar.workspaces.perMonitorWorkspaces ? Hypr.monitorFor(screen) : Hypr.focusedMonitor)?.lastIpcObject.specialWorkspace.name !== ""
    readonly property int activeWsId: Config.bar.workspaces.perMonitorWorkspaces ? (Hypr.monitorFor(screen).activeWorkspace?.id ?? 1) : Hypr.activeWsId

    readonly property var occupied: Hypr.workspaces.values.reduce((acc, curr) => {
        acc[curr.id] = curr.lastIpcObject.windows > 0;
        return acc;
    }, {})
    readonly property int groupOffset: Math.floor((activeWsId - 1) / Config.bar.workspaces.shown) * Config.bar.workspaces.shown

    property real blur: onSpecial ? 1 : 0

<<<<<<< HEAD
    implicitWidth: layout.implicitWidth + 12  // Add 12px for 6px left + 6px right padding
    implicitHeight: Config.bar.sizes.innerHeight

    color: Colours.tPalette.m3surfaceContainer
    radius: 14

    Item {
        anchors.fill: parent
        clip: true
=======
    implicitWidth: Config.bar.sizes.innerWidth
    implicitHeight: layout.implicitHeight + Appearance.padding.small * 2

    color: Colours.tPalette.m3surfaceContainer
    radius: Appearance.rounding.full

    Item {
        anchors.fill: parent
>>>>>>> origin/master
        scale: root.onSpecial ? 0.8 : 1
        opacity: root.onSpecial ? 0.5 : 1

        layer.enabled: root.blur > 0
        layer.effect: MultiEffect {
<<<<<<< HEAD
            blurEnabled: false
=======
            blurEnabled: true
>>>>>>> origin/master
            blur: root.blur
            blurMax: 32
        }

        Loader {
            active: Config.bar.workspaces.occupiedBg
            asynchronous: true

            anchors.fill: parent
<<<<<<< HEAD
=======
            anchors.margins: Appearance.padding.small
>>>>>>> origin/master

            sourceComponent: OccupiedBg {
                workspaces: workspaces
                occupied: root.occupied
                groupOffset: root.groupOffset
            }
        }

<<<<<<< HEAD
        Item {
            // bg enable
            anchors.fill: parent
            anchors.leftMargin: 6
            anchors.rightMargin: 6

            Loader {
                anchors.fill: parent
                active: Config.bar.workspaces.activeIndicator
                asynchronous: true
                z: -1  // Behind content

                sourceComponent: ActiveIndicator {
                    activeWsId: root.activeWsId
                    workspaces: workspaces
                    mask: layout
                }
            }

            RowLayout {
                id: layout

                width: implicitWidth
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                spacing: 6  // Match vertical padding for consistency

                Repeater {
                    id: workspaces

                    model: Config.bar.workspaces.shown

                    Workspace {
                        activeWsId: root.activeWsId
                        occupied: root.occupied
                        groupOffset: root.groupOffset
                    }
=======
        ColumnLayout {
            id: layout

            anchors.centerIn: parent
            spacing: Math.floor(Appearance.spacing.small / 2)

            Repeater {
                id: workspaces

                model: Config.bar.workspaces.shown

                Workspace {
                    activeWsId: root.activeWsId
                    occupied: root.occupied
                    groupOffset: root.groupOffset
>>>>>>> origin/master
                }
            }
        }

<<<<<<< HEAD
        MouseArea {
            anchors.fill: parent  // Cover full area, not just layout!
            onClicked: event => {
                const child = layout.childAt(event.x - (parent.width - layout.width) / 2, event.y);
                if (!child) return;
                const ws = child.ws;
=======
        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            active: Config.bar.workspaces.activeIndicator
            asynchronous: true

            sourceComponent: ActiveIndicator {
                activeWsId: root.activeWsId
                workspaces: workspaces
                mask: layout
            }
        }

        MouseArea {
            anchors.fill: layout
            onClicked: event => {
                const ws = layout.childAt(event.x, event.y).ws;
>>>>>>> origin/master
                if (Hypr.activeWsId !== ws)
                    Hypr.dispatch(`workspace ${ws}`);
                else
                    Hypr.dispatch("togglespecialworkspace special");
            }
        }

        Behavior on scale {
            Anim {}
        }

        Behavior on opacity {
            Anim {}
        }
    }

    Loader {
        id: specialWs

        anchors.fill: parent
        anchors.margins: Appearance.padding.small

        active: opacity > 0
        asynchronous: true

        scale: root.onSpecial ? 1 : 0.5
        opacity: root.onSpecial ? 1 : 0

        sourceComponent: SpecialWorkspaces {
            screen: root.screen
        }

        Behavior on scale {
            Anim {}
        }

        Behavior on opacity {
            Anim {}
        }
    }

    Behavior on blur {
        Anim {
            duration: Appearance.anim.durations.small
        }
    }
}
