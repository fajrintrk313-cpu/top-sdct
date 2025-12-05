pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Effects

Item {
    id: root

    required property Item bar
<<<<<<< HEAD
    required property var panels

    anchors.fill: parent

    // Border background disabled - panels provide their own backgrounds
    // StyledRect {
    //     anchors.fill: parent
    //     color: Colours.palette.m3surface

    //     layer.enabled: true
    //     layer.effect: MultiEffect {
    //         maskSource: mask
    //         maskEnabled: true
    //         maskInverted: true
    //         maskThresholdMin: 0.5
    //         maskSpreadAtMin: 1
    //     }
    // }
=======

    anchors.fill: parent

    StyledRect {
        anchors.fill: parent
        color: Colours.palette.m3surface

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }
>>>>>>> origin/master

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

<<<<<<< HEAD
        // Main content area cutout - this shows the background EVERYWHERE except here
        Rectangle {
            anchors.fill: parent
            anchors.margins: Config.border.thickness
            anchors.topMargin: root.bar.implicitHeight
            radius: Config.border.rounding
        }
        
        // Floating bar cutout (14px margin dari top bar)
        Rectangle {
            x: 14
            y: 14
            width: parent.width - 28
            height: root.bar.implicitHeight - 14
=======
        Rectangle {
            anchors.fill: parent
            anchors.margins: Config.border.thickness
            anchors.leftMargin: root.bar.implicitWidth
>>>>>>> origin/master
            radius: Config.border.rounding
        }
    }
}
