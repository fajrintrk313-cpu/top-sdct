import qs.components
import qs.services
import qs.utils
import qs.config
import Quickshell
import QtQuick
import QtQuick.Layouts

<<<<<<< HEAD
Item {
=======
ColumnLayout {
>>>>>>> origin/master
    id: root

    required property int index
    required property int activeWsId
    required property var occupied
    required property int groupOffset

<<<<<<< HEAD
    readonly property int ws: groupOffset + index + 1
    readonly property bool isOccupied: occupied[ws] ?? false
    readonly property bool hasWindows: isOccupied && Config.bar.workspaces.showWindows
    readonly property bool isActive: activeWsId === ws
    readonly property int horizontalPadding: 6  // Padding inside each workspace item

    Layout.alignment: Qt.AlignVCenter
    Layout.fillHeight: true
    Layout.preferredWidth: implicitWidth

    implicitWidth: horizontalPadding + indicator.implicitWidth + (hasWindows ? windows.implicitWidth : 0) + horizontalPadding
    implicitHeight: Config.bar.sizes.innerHeight
=======
    readonly property bool isWorkspace: true // Flag for finding workspace children
    // Unanimated prop for others to use as reference
    readonly property int size: implicitHeight + (hasWindows ? Appearance.padding.small : 0)

    readonly property int ws: groupOffset + index + 1
    readonly property bool isOccupied: occupied[ws] ?? false
    readonly property bool hasWindows: isOccupied && Config.bar.workspaces.showWindows

    Layout.alignment: Qt.AlignHCenter
    Layout.preferredHeight: size

    spacing: 0
>>>>>>> origin/master

    StyledText {
        id: indicator

<<<<<<< HEAD
        anchors.left: parent.left
        anchors.leftMargin: horizontalPadding
        anchors.verticalCenter: parent.verticalCenter
=======
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Layout.preferredHeight: Config.bar.sizes.innerWidth - Appearance.padding.small * 2
>>>>>>> origin/master

        animate: true
        text: {
            const ws = Hypr.workspaces.values.find(w => w.id === root.ws);
            const wsName = !ws || ws.name == root.ws ? root.ws : ws.name[0];
            let displayName = wsName.toString();
            if (Config.bar.workspaces.capitalisation.toLowerCase() === "upper") {
                displayName = displayName.toUpperCase();
            } else if (Config.bar.workspaces.capitalisation.toLowerCase() === "lower") {
                displayName = displayName.toLowerCase();
            }
            const label = Config.bar.workspaces.label || displayName;
            const occupiedLabel = Config.bar.workspaces.occupiedLabel || label;
            const activeLabel = Config.bar.workspaces.activeLabel || (root.isOccupied ? occupiedLabel : label);
            return root.activeWsId === root.ws ? activeLabel : root.isOccupied ? occupiedLabel : label;
        }
<<<<<<< HEAD
        color: root.activeWsId === root.ws ? Colours.palette.m3surface : (Config.bar.workspaces.occupiedBg || root.isOccupied ? Colours.palette.m3onSurface : Colours.layer(Colours.palette.m3outlineVariant, 2))
=======
        color: Config.bar.workspaces.occupiedBg || root.isOccupied || root.activeWsId === root.ws ? Colours.palette.m3onSurface : Colours.layer(Colours.palette.m3outlineVariant, 2)
>>>>>>> origin/master
        verticalAlignment: Qt.AlignVCenter
    }

    Loader {
        id: windows

<<<<<<< HEAD
        anchors.left: indicator.right
        anchors.leftMargin: 4  // Space between indicator and window icons
        anchors.verticalCenter: parent.verticalCenter
=======
        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: true
        Layout.topMargin: -Config.bar.sizes.innerWidth / 10
>>>>>>> origin/master

        visible: active
        active: root.hasWindows
        asynchronous: true

<<<<<<< HEAD
        sourceComponent: Row {
            spacing: 0

=======
        sourceComponent: Column {
            spacing: 0

            add: Transition {
                Anim {
                    properties: "scale"
                    from: 0
                    to: 1
                    easing.bezierCurve: Appearance.anim.curves.standardDecel
                }
            }

            move: Transition {
                Anim {
                    properties: "scale"
                    to: 1
                    easing.bezierCurve: Appearance.anim.curves.standardDecel
                }
                Anim {
                    properties: "x,y"
                }
            }

>>>>>>> origin/master
            Repeater {
                model: ScriptModel {
                    values: Hypr.toplevels.values.filter(c => c.workspace?.id === root.ws)
                }

                MaterialIcon {
                    required property var modelData
<<<<<<< HEAD
                    
                    height: Config.bar.sizes.innerHeight
                    width: 20
                    
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    grade: 0
                    text: Icons.getAppCategoryIcon(modelData.lastIpcObject.class, "terminal")
                    color: root.activeWsId === root.ws ? Colours.palette.m3surface : Colours.palette.m3onSurfaceVariant
=======

                    grade: 0
                    text: Icons.getAppCategoryIcon(modelData.lastIpcObject.class, "terminal")
                    color: Colours.palette.m3onSurfaceVariant
>>>>>>> origin/master
                }
            }
        }
    }
<<<<<<< HEAD
=======

    Behavior on Layout.preferredHeight {
        Anim {}
    }
>>>>>>> origin/master
}
