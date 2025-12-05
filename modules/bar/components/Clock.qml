pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import QtQuick
<<<<<<< HEAD
import QtQuick.Layouts

StyledRect {
=======

Column {
>>>>>>> origin/master
    id: root

    property color colour: Colours.palette.m3tertiary

<<<<<<< HEAD
    color: Colours.tPalette.m3surfaceContainer
    radius: 14

    clip: true
    implicitHeight: Config.bar.sizes.innerHeight
    implicitWidth: clockRow.implicitWidth + Appearance.padding.normal * 2

    RowLayout {
        id: clockRow

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Appearance.padding.normal
        anchors.rightMargin: Appearance.padding.normal

        spacing: Appearance.spacing.small

        Loader {
            Layout.alignment: Qt.AlignVCenter
            active: Config.bar.clock.showIcon
            visible: active
            asynchronous: true

            sourceComponent: MaterialIcon {
                text: "calendar_month"
                color: root.colour
            }
        }

        StyledText {
            id: text
            Layout.alignment: Qt.AlignVCenter

            text: Time.format(Config.services.useTwelveHourClock ? "hh:mm A" : "hh:mm")
            font.pointSize: Appearance.font.size.smaller
            font.family: Appearance.font.family.mono
            color: root.colour
        }
    }
=======
    spacing: Appearance.spacing.small

    Loader {
        anchors.horizontalCenter: parent.horizontalCenter

        active: Config.bar.clock.showIcon
        visible: active
        asynchronous: true

        sourceComponent: MaterialIcon {
            text: "calendar_month"
            color: root.colour
        }
    }

    StyledText {
        id: text

        anchors.horizontalCenter: parent.horizontalCenter

        horizontalAlignment: StyledText.AlignHCenter
        text: Time.format(Config.services.useTwelveHourClock ? "hh\nmm\nA" : "hh\nmm")
        font.pointSize: Appearance.font.size.smaller
        font.family: Appearance.font.family.mono
        color: root.colour
    }
>>>>>>> origin/master
}
