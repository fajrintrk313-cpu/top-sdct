pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import qs.modules.windowinfo
import qs.modules.controlcenter
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

Item {
    id: root

    required property ShellScreen screen

<<<<<<< HEAD
    // Cache dimensions to prevent jump to 0 when content unloads
    property real _cachedWidth: 0
    property real _cachedHeight: 0
    
    readonly property real nonAnimWidth: {
        const w = hasCurrent ? (children.find(c => c.shouldBeActive)?.implicitWidth ?? content.implicitWidth) : 0;
        if (w > 0) _cachedWidth = w;
        return w > 0 ? w : _cachedWidth;
    }
    readonly property real nonAnimHeight: {
        const h = hasCurrent ? (children.find(c => c.shouldBeActive)?.implicitHeight ?? content.implicitHeight) : 0;
        if (h > 0) _cachedHeight = h;
        return h > 0 ? h : _cachedHeight;
    }
    readonly property Item current: content.item?.current ?? null
    
    // Expose content bounds for hover persistence logic - handle both preview and detached modes
    readonly property real contentX: {
        if (detachedMode === "winfo" && winfoComp.item) {
            return winfoComp.x;
        } else if (detachedMode === "any" && ccComp.item) {
            return ccComp.x;
        }
        return content.x;
    }
    readonly property real contentY: {
        if (detachedMode === "winfo" && winfoComp.item) {
            return winfoComp.y;
        } else if (detachedMode === "any" && ccComp.item) {
            return ccComp.y;
        }
        return content.y;
    }
    readonly property real contentW: {
        if (detachedMode === "winfo" && winfoComp.item) {
            return winfoComp.item.implicitWidth;
        } else if (detachedMode === "any" && ccComp.item) {
            return ccComp.item.implicitWidth;
        }
        return content.item ? content.item.implicitWidth : content.implicitWidth;
    }
    readonly property real contentH: {
        if (detachedMode === "winfo" && winfoComp.item) {
            return winfoComp.item.implicitHeight;
        } else if (detachedMode === "any" && ccComp.item) {
            return ccComp.item.implicitHeight;
        }
        return content.item ? content.item.implicitHeight : content.implicitHeight;
    }
=======
    readonly property real nonAnimWidth: x > 0 || hasCurrent ? children.find(c => c.shouldBeActive)?.implicitWidth ?? content.implicitWidth : 0
    readonly property real nonAnimHeight: children.find(c => c.shouldBeActive)?.implicitHeight ?? content.implicitHeight
    readonly property Item current: content.item?.current ?? null
>>>>>>> origin/master

    property string currentName
    property real currentCenter
    property bool hasCurrent

    property string detachedMode
    property string queuedMode
    readonly property bool isDetached: detachedMode.length > 0
<<<<<<< HEAD
    
    // Background offset for pulling shape up during close animation
    property real bgOffset: 0

    // Sinyal untuk memberi tahu Bar saat kursor berada di konten popout
    signal hoverContent(bool inside)
=======
>>>>>>> origin/master

    property int animLength: Appearance.anim.durations.normal
    property list<real> animCurve: Appearance.anim.curves.emphasized

    function detach(mode: string): void {
        animLength = Appearance.anim.durations.large;
        if (mode === "winfo") {
            detachedMode = mode;
        } else {
            detachedMode = "any";
            queuedMode = mode;
        }
        focus = true;
    }

    function close(): void {
        hasCurrent = false;
<<<<<<< HEAD
        bgOffset = -nonAnimHeight; // Pull background arch up to remove leftover corners
=======
>>>>>>> origin/master
        animCurve = Appearance.anim.curves.emphasizedAccel;
        animLength = Appearance.anim.durations.normal;
        detachedMode = "";
        animCurve = Appearance.anim.curves.emphasized;
    }

<<<<<<< HEAD
    visible: height > 0
    clip: true

    width: nonAnimWidth
    implicitHeight: 0
    
    states: State {
        name: "visible"
        when: root.hasCurrent || root.isDetached
        
        PropertyChanges {
            root.implicitHeight: root.nonAnimHeight
            root.bgOffset: 0
        }
    }
    
    transitions: [
        Transition {
            from: ""
            to: "visible"
            
            Anim {
                target: root
                property: "implicitHeight"
                duration: Appearance.anim.durations.expressiveDefaultSpatial
                easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
            }
        },
        Transition {
            from: "visible"
            to: ""
            
            Anim {
                target: root
                property: "implicitHeight"
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    ]
=======
    visible: width > 0 && height > 0
    clip: true

    implicitWidth: nonAnimWidth
    implicitHeight: nonAnimHeight
>>>>>>> origin/master

    Keys.onEscapePressed: close()

    HyprlandFocusGrab {
        active: root.isDetached
        windows: [QsWindow.window]
<<<<<<< HEAD
=======
        onCleared: root.close()
>>>>>>> origin/master
    }

    Binding {
        when: root.isDetached

        target: QsWindow.window
        property: "WlrLayershell.keyboardFocus"
        value: WlrKeyboardFocus.OnDemand
    }

    Comp {
        id: content

<<<<<<< HEAD
        shouldBeActive: (root.hasCurrent || root.visible) && !root.detachedMode
        asynchronous: false

        // Center horizontally around currentCenter
        x: Math.max(0, Math.min(parent.width - content.implicitWidth, (root.currentCenter ?? parent.width / 2) - content.implicitWidth / 2))
        
        // Anchor to bottom so content slides down as wrapper grows
        anchors.bottom: parent.bottom
        
        // Disable x animation
        Behavior on x { enabled: false }
=======
        shouldBeActive: root.hasCurrent && !root.detachedMode
        asynchronous: true
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
>>>>>>> origin/master

        sourceComponent: Content {
            wrapper: root
        }
    }

<<<<<<< HEAD
    // MouseArea untuk mempertahankan popout saat kursor berada di atas konten
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        propagateComposedEvents: true
        onEntered: root.hoverContent(true)
        onExited: root.hoverContent(false)
    }

    Comp {
        id: winfoComp
=======
    Comp {
>>>>>>> origin/master
        shouldBeActive: root.detachedMode === "winfo"
        asynchronous: true
        anchors.centerIn: parent

        sourceComponent: WindowInfo {
            screen: root.screen
            client: Hypr.activeToplevel
        }
    }

    Comp {
<<<<<<< HEAD
        id: ccComp
=======
>>>>>>> origin/master
        shouldBeActive: root.detachedMode === "any"
        asynchronous: true
        anchors.centerIn: parent

        sourceComponent: ControlCenter {
            screen: root.screen
            active: root.queuedMode

            function close(): void {
                root.close();
            }
        }
    }

<<<<<<< HEAD




    Behavior on implicitWidth {
        enabled: root.isDetached && root.implicitWidth > 0
        NumberAnimation { duration: root.animLength; easing.type: Easing.OutCubic }
    }

    Behavior on implicitHeight {
        enabled: root.isDetached && root.implicitWidth > 0
        NumberAnimation { duration: root.animLength; easing.type: Easing.OutCubic }
    }
    
    Behavior on bgOffset {
        enabled: !root.isDetached
        NumberAnimation {
            duration: Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.emphasized
=======
    Behavior on x {
        Anim {
            duration: root.animLength
            easing.bezierCurve: root.animCurve
        }
    }

    Behavior on y {
        enabled: root.implicitWidth > 0

        Anim {
            duration: root.animLength
            easing.bezierCurve: root.animCurve
        }
    }

    Behavior on implicitWidth {
        Anim {
            duration: root.animLength
            easing.bezierCurve: root.animCurve
        }
    }

    Behavior on implicitHeight {
        enabled: root.implicitWidth > 0

        Anim {
            duration: root.animLength
            easing.bezierCurve: root.animCurve
>>>>>>> origin/master
        }
    }

    component Comp: Loader {
        id: comp

        property bool shouldBeActive

        asynchronous: true
        active: false
        opacity: 0

        states: State {
            name: "active"
            when: comp.shouldBeActive

            PropertyChanges {
                comp.opacity: 1
                comp.active: true
            }
        }

        transitions: [
            Transition {
                from: ""
                to: "active"

                SequentialAnimation {
<<<<<<< HEAD
                    PropertyAction { property: "x" }
                    PropertyAction { property: "y" }
                    PropertyAction { property: "active" }
                    PropertyAction { property: "opacity"; value: 0 }
                    NumberAnimation { 
                        property: "opacity"
                        duration: Appearance.anim.durations.expressiveDefaultSpatial
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
=======
                    PropertyAction {
                        property: "active"
                    }
                    Anim {
                        property: "opacity"
>>>>>>> origin/master
                    }
                }
            },
            Transition {
                from: "active"
                to: ""

                SequentialAnimation {
<<<<<<< HEAD
                    NumberAnimation { 
                        property: "opacity"
                        duration: Appearance.anim.durations.normal
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Appearance.anim.curves.emphasized
                    }
                    PropertyAction { property: "active" }
=======
                    Anim {
                        property: "opacity"
                    }
                    PropertyAction {
                        property: "active"
                    }
>>>>>>> origin/master
                }
            }
        ]
    }
}
