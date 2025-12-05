import qs.components
<<<<<<< HEAD
=======
import qs.components.effects
>>>>>>> origin/master
import qs.services
import qs.config
import QtQuick

<<<<<<< HEAD
// END-4 style active indicator: slim pill background with subtle opacity
Item {
=======
StyledRect {
>>>>>>> origin/master
    id: root

    required property int activeWsId
    required property Repeater workspaces
    required property Item mask

    readonly property int currentWsIdx: {
        let i = activeWsId - 1;
        while (i < 0)
            i += Config.bar.workspaces.shown;
        return i % Config.bar.workspaces.shown;
    }

<<<<<<< HEAD
    readonly property Item currentWs: workspaces.itemAt(currentWsIdx)

    // Single sliding indicator instead of multiple fading indicators
    StyledRect {
        id: indicator

        // LOGIC: 
        // - No window: square (22x22)
        // - With window: Match workspace item exactly (workspace items have their own internal padding)
        readonly property bool hasWindows: (currentWs?.implicitWidth ?? 0) > 20
        readonly property real indicatorHeight: 26
        
        // Width: match workspace exactly (workspace has internal padding already)
        // Position: match workspace position exactly
        readonly property real targetWidth: hasWindows ? (currentWs?.implicitWidth ?? 0) : indicatorHeight
        readonly property real targetX: (currentWs?.x ?? 0)
        
        // Position and size
        x: targetX
        y: parent.height / 2 - height / 2
        implicitWidth: targetWidth
        implicitHeight: indicatorHeight
        radius: 14  // Match Hyprland window rounding

        // Solid color without opacity
        color: Colours.palette.m3primary
        opacity: currentWs ? 1 : 0

        // No border, no shadow - pure flat style
        border.width: 0

        // Smooth slide animation
        Behavior on x {
            enabled: opacity > 0  // Only animate when visible
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }
        
        Behavior on implicitWidth {
            enabled: opacity > 0
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }
        
        Behavior on opacity {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }
    }
=======
    property real leading: workspaces.itemAt(currentWsIdx)?.y ?? 0
    property real trailing: workspaces.itemAt(currentWsIdx)?.y ?? 0
    property real currentSize: workspaces.itemAt(currentWsIdx)?.size ?? 0
    property real offset: Math.min(leading, trailing)
    property real size: {
        const s = Math.abs(leading - trailing) + currentSize;
        if (Config.bar.workspaces.activeTrail && lastWs > currentWsIdx) {
            const ws = workspaces.itemAt(lastWs);
            // console.log(ws, lastWs);
            return ws ? Math.min(ws.y + ws.size - offset, s) : 0;
        }
        return s;
    }

    property int cWs
    property int lastWs

    onCurrentWsIdxChanged: {
        lastWs = cWs;
        cWs = currentWsIdx;
    }

    clip: true
    y: offset + mask.y
    implicitWidth: Config.bar.sizes.innerWidth - Appearance.padding.small * 2
    implicitHeight: size
    radius: Appearance.rounding.full
    color: Colours.palette.m3primary

    Colouriser {
        source: root.mask
        sourceColor: Colours.palette.m3onSurface
        colorizationColor: Colours.palette.m3onPrimary

        x: 0
        y: -parent.offset
        implicitWidth: root.mask.implicitWidth
        implicitHeight: root.mask.implicitHeight

        anchors.horizontalCenter: parent.horizontalCenter
    }

    Behavior on leading {
        enabled: Config.bar.workspaces.activeTrail

        EAnim {}
    }

    Behavior on trailing {
        enabled: Config.bar.workspaces.activeTrail

        EAnim {
            duration: Appearance.anim.durations.normal * 2
        }
    }

    Behavior on currentSize {
        enabled: Config.bar.workspaces.activeTrail

        EAnim {}
    }

    Behavior on offset {
        enabled: !Config.bar.workspaces.activeTrail

        EAnim {}
    }

    Behavior on size {
        enabled: !Config.bar.workspaces.activeTrail

        EAnim {}
    }

    component EAnim: Anim {
        easing.bezierCurve: Appearance.anim.curves.emphasized
    }
>>>>>>> origin/master
}
