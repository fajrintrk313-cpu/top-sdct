pragma ComponentBehavior: Bound

import qs.components
import qs.config
import "popouts" as BarPopouts
import Quickshell
import QtQuick

Item {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property BarPopouts.Wrapper popouts

<<<<<<< HEAD
    readonly property int padding: 6  // Fixed 2px spacing from top bar
    readonly property int contentHeight: Config.bar.sizes.innerHeight + padding * 2
    readonly property int topMargin: Config.border.thickness
    readonly property int exclusiveZone: Config.bar.persistent || visibilities.bar ? (topMargin + contentHeight) : Config.border.thickness
=======
    readonly property int padding: Math.max(Appearance.padding.smaller, Config.border.thickness)
    readonly property int contentWidth: Config.bar.sizes.innerWidth + padding * 2
    readonly property int exclusiveZone: Config.bar.persistent || visibilities.bar ? contentWidth : Config.border.thickness
>>>>>>> origin/master
    readonly property bool shouldBeVisible: Config.bar.persistent || visibilities.bar || isHovered
    property bool isHovered

    function closeTray(): void {
        content.item?.closeTray();
    }

<<<<<<< HEAD
    function checkPopout(x: real): void {
        // Convert screen coordinates to Bar coordinates by subtracting leftMargin
        const barX = x - Config.border.thickness;
        content.item?.checkPopout(barX);
    }

    function handleWheel(x: real, angleDelta: point): void {
        // Convert screen coordinates to Bar coordinates by subtracting leftMargin
        const barX = x - Config.border.thickness;
        content.item?.handleWheel(barX, angleDelta);
    }

    visible: height > Config.border.thickness
    implicitHeight: Config.border.thickness
=======
    function checkPopout(y: real): void {
        content.item?.checkPopout(y);
    }

    function handleWheel(y: real, angleDelta: point): void {
        content.item?.handleWheel(y, angleDelta);
    }

    visible: width > Config.border.thickness
    implicitWidth: Config.border.thickness
>>>>>>> origin/master

    states: State {
        name: "visible"
        when: root.shouldBeVisible

        PropertyChanges {
<<<<<<< HEAD
            root.implicitHeight: root.contentHeight
=======
            root.implicitWidth: root.contentWidth
>>>>>>> origin/master
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "visible"

            Anim {
                target: root
<<<<<<< HEAD
                property: "implicitHeight"
=======
                property: "implicitWidth"
>>>>>>> origin/master
                duration: Appearance.anim.durations.expressiveDefaultSpatial
                easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
            }
        },
        Transition {
            from: "visible"
            to: ""

            Anim {
                target: root
<<<<<<< HEAD
                property: "implicitHeight"
=======
                property: "implicitWidth"
>>>>>>> origin/master
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    ]

    Loader {
        id: content

        anchors.top: parent.top
<<<<<<< HEAD
        anchors.topMargin: Config.border.thickness
        anchors.left: parent.left
        anchors.leftMargin: Config.border.thickness
        anchors.right: parent.right
        anchors.rightMargin: Config.border.thickness
=======
        anchors.bottom: parent.bottom
        anchors.right: parent.right
>>>>>>> origin/master

        active: root.shouldBeVisible || root.visible

        sourceComponent: Bar {
<<<<<<< HEAD
            width: parent.width
            height: root.contentHeight
=======
            width: root.contentWidth
>>>>>>> origin/master
            screen: root.screen
            visibilities: root.visibilities
            popouts: root.popouts
        }
    }
}
