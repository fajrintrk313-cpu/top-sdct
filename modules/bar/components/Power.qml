import qs.components
import qs.services
import qs.config
import Quickshell
import QtQuick

Item {
    id: root

    required property PersistentProperties visibilities

    implicitWidth: icon.implicitWidth + Appearance.padding.small * 2
    implicitHeight: icon.implicitHeight

<<<<<<< HEAD
    MouseArea {
=======
    StateLayer {
>>>>>>> origin/master
        anchors.fill: undefined
        anchors.centerIn: parent
        implicitWidth: icon.implicitWidth + Appearance.padding.small * 2
        implicitHeight: icon.implicitHeight
<<<<<<< HEAD
        
        cursorShape: Qt.PointingHandCursor
        
        onClicked: root.visibilities.session = !root.visibilities.session
=======

        radius: Appearance.rounding.full

        function onClicked(): void {
            root.visibilities.session = !root.visibilities.session;
        }
>>>>>>> origin/master
    }

    MaterialIcon {
        id: icon

        anchors.centerIn: parent

        text: "power_settings_new"
        color: Colours.palette.m3error
        font.bold: true
        font.pointSize: Appearance.font.size.normal
    }
}
