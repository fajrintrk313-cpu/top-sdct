pragma ComponentBehavior: Bound

<<<<<<< HEAD
import qs.components
=======
>>>>>>> origin/master
import qs.services
import qs.config
import "popouts" as BarPopouts
import "components"
import "components/workspaces"
import Quickshell
import QtQuick
import QtQuick.Layouts

<<<<<<< HEAD
Item {
    id: root

    width: parent?.width ?? 0
    height: parent?.height ?? 0
    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property BarPopouts.Wrapper popouts
    readonly property int hPadding: 14
    
    // Floating bar background
    StyledRect {
        anchors.fill: parent
        color: Colours.palette.m3surface
        radius: 14  // Match Hyprland window rounding
        z: -1
    }

    // Delay penutupan popout agar tidak flicker saat keluar batas
    Timer {
        id: popoutCloseTimer
        interval: 120
        repeat: false
        onTriggered: root.popouts.hasCurrent = false
    }

    function checkPopout(x: real, y: real): void {

        // If detached mode active, don't change anything - it stays open
        if (popouts.isDetached) {
            return;
        }

        // For preview mode: keep open when hovering content
        if (popouts.hasCurrent) {
            const margin = 14;
            const px = (popouts.contentX ?? popouts.x) - margin;
            const py = (popouts.contentY ?? popouts.y) - margin;
            const pw = (popouts.contentW ?? popouts.nonAnimWidth) + margin * 2;
            const ph = (popouts.contentH ?? popouts.nonAnimHeight) + margin * 2;
            const overPopout = x >= px && x <= (px + pw) && y >= py && y <= (py + ph);
            if (overPopout) {
                popoutCloseTimer.stop();
                return;
            }
        }

        // Active window popout only when hovering its bounds
        if (Config.bar.popouts.activeWindow && activeWindowLoader) {
            const awX = activeWindowLoader.x;
            const awW = (activeWindowLoader.item?.implicitWidth ?? activeWindowLoader.item?.width ?? activeWindowLoader.width);
            const overActive = x >= awX && x <= (awX + awW);
            if (overActive) {
                const itemWidth = (activeWindowLoader.item?.implicitWidth ?? activeWindowLoader.item?.width ?? awW);
                const fallbackCenter = activeWindowLoader.x + (activeWindowLoader.width / 2);
                const itemCenter = activeWindowLoader.item ? activeWindowLoader.item.mapToItem(root, (itemWidth / 2) || 0, 0).x : fallbackCenter;
                popouts.currentName = "activewindow";
                popouts.currentCenter = itemCenter;
                popouts.hasCurrent = true;
                popoutCloseTimer.stop();
                return;
            }
        }

        // Status icons left popout
        if (Config.bar.popouts.statusIcons && statusLeftLoader.item) {
            const items = statusLeftLoader.item.items;
            if (items) {
                const localX = mapToItem(items, x, 0).x;
                const icon = items.childAt(localX, items.height / 2);
                if (icon) {
                    popouts.currentName = icon.name;
                    popouts.currentCenter = Qt.binding(() => icon.mapToItem(root, icon.implicitWidth / 2, 0).x);
                    popouts.hasCurrent = true;
                    popoutCloseTimer.stop();
                    return;
                }
            }
        }

        // Status icons right popout
        if (Config.bar.popouts.statusIcons && statusRightLoader.item) {
            const items = statusRightLoader.item.items;
            if (items) {
                const localX = mapToItem(items, x, 0).x;
                const icon = items.childAt(localX, items.height / 2);
                if (icon) {
                    popouts.currentName = icon.name;
                    popouts.currentCenter = Qt.binding(() => icon.mapToItem(root, icon.implicitWidth / 2, 0).x);
                    popouts.hasCurrent = true;
                    popoutCloseTimer.stop();
                    return;
                }
            }
        }

        // Fallthrough: if not over any target, clear current

        // Tidak berada di area target: jadwalkan tutup dengan delay kecil
        popoutCloseTimer.restart();
    }

    function handleWheel(x: real, angleDelta: point): void {
        // Workspace scroll when over workspaces area (including statusLeft and clock)
        const centerLeft = statusLeftLoader.x;
        const centerRight = clockLoader.x + clockLoader.width;
        const overCenter = x >= centerLeft && x <= centerRight;
        if (overCenter && Config.bar.scrollActions.workspaces) {
=======
ColumnLayout {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property BarPopouts.Wrapper popouts
    readonly property int vPadding: Appearance.padding.large

    function closeTray(): void {
        if (!Config.bar.tray.compact)
            return;

        for (let i = 0; i < repeater.count; i++) {
            const item = repeater.itemAt(i);
            if (item?.enabled && item.id === "tray") {
                item.item.expanded = false;
            }
        }
    }

    function checkPopout(y: real): void {
        const ch = childAt(width / 2, y) as WrappedLoader;

        if (ch?.id !== "tray")
            closeTray();

        if (!ch) {
            popouts.hasCurrent = false;
            return;
        }

        const id = ch.id;
        const top = ch.y;
        const item = ch.item;
        const itemHeight = item.implicitHeight;

        if (id === "statusIcons" && Config.bar.popouts.statusIcons) {
            const items = item.items;
            const icon = items.childAt(items.width / 2, mapToItem(items, 0, y).y);
            if (icon) {
                popouts.currentName = icon.name;
                popouts.currentCenter = Qt.binding(() => icon.mapToItem(root, 0, icon.implicitHeight / 2).y);
                popouts.hasCurrent = true;
            }
        } else if (id === "tray" && Config.bar.popouts.tray) {
            if (!Config.bar.tray.compact || (item.expanded && !item.expandIcon.contains(mapToItem(item.expandIcon, item.implicitWidth / 2, y)))) {
                const index = Math.floor(((y - top - item.padding * 2 + item.spacing) / item.layout.implicitHeight) * item.items.count);
                const trayItem = item.items.itemAt(index);
                if (trayItem) {
                    popouts.currentName = `traymenu${index}`;
                    popouts.currentCenter = Qt.binding(() => trayItem.mapToItem(root, 0, trayItem.implicitHeight / 2).y);
                    popouts.hasCurrent = true;
                } else {
                    popouts.hasCurrent = false;
                }
            } else {
                popouts.hasCurrent = false;
                item.expanded = true;
            }
        } else if (id === "activeWindow" && Config.bar.popouts.activeWindow) {
            popouts.currentName = id.toLowerCase();
            popouts.currentCenter = item.mapToItem(root, 0, itemHeight / 2).y;
            popouts.hasCurrent = true;
        }
    }

    function handleWheel(y: real, angleDelta: point): void {
        const ch = childAt(width / 2, y) as WrappedLoader;
        if (ch?.id === "workspaces" && Config.bar.scrollActions.workspaces) {
            // Workspace scroll
>>>>>>> origin/master
            const mon = (Config.bar.workspaces.perMonitorWorkspaces ? Hypr.monitorFor(screen) : Hypr.focusedMonitor);
            const specialWs = mon?.lastIpcObject.specialWorkspace.name;
            if (specialWs?.length > 0)
                Hypr.dispatch(`togglespecialworkspace ${specialWs.slice(8)}`);
            else if (angleDelta.y < 0 || (Config.bar.workspaces.perMonitorWorkspaces ? mon.activeWorkspace?.id : Hypr.activeWsId) > 1)
                Hypr.dispatch(`workspace r${angleDelta.y > 0 ? "-" : "+"}1`);
<<<<<<< HEAD
            return;
        }

        // Volume on left half
        if (x < width / 2 && Config.bar.scrollActions.volume) {
            if (angleDelta.y > 0) Audio.incrementVolume();
            else if (angleDelta.y < 0) Audio.decrementVolume();
            return;
        }

        // Brightness on right half
        if (Config.bar.scrollActions.brightness) {
            const monitor = Brightness.getMonitorForScreen(screen);
            if (angleDelta.y > 0) monitor.setBrightness(monitor.brightness + 0.1);
            else if (angleDelta.y < 0) monitor.setBrightness(monitor.brightness - 0.1);
        }
    }

    // Pointer tracking to drive hover-based popouts/expansions - invisible overlay
    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        z: 1000
        preventStealing: false
        propagateComposedEvents: true
        acceptedButtons: Qt.NoButton
        visible: false  // Make invisible - it's just for event tracking
        enabled: true   // But keep enabled for functionality
        onEntered: root.checkPopout(hoverArea.mouseX, hoverArea.mouseY)
        onPositionChanged: (mouse) => root.checkPopout(mouse.x, mouse.y)
        onExited: {
            // Only close preview mode with timer, detached stays open
            if (!root.popouts.isDetached) {
                popoutCloseTimer.restart();
            }
        }
        onWheel: (wheel) => root.handleWheel(hoverArea.mouseX, wheel.angleDelta)
    }

    // Three-section layout: Left (logo + activeWindow), Center (workspaces centered), Right (clock + tray + status + power)
    RowLayout {
        id: leftSection
        anchors.left: parent.left
        anchors.leftMargin: root.hPadding
        anchors.verticalCenter: parent.verticalCenter
        spacing: Appearance.spacing.small  // 7px spacing, consistent with right section

        Loader { id: osIconLoader; sourceComponent: OsIcon {} }
        Loader {
            id: activeWindowLoader
            asynchronous: false
            sourceComponent: ActiveWindow { bar: root; monitor: Brightness.getMonitorForScreen(root.screen) }
        }
    }

    // Workspaces centered independently
    Loader {
        id: workspacesLoader
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        asynchronous: false
        sourceComponent: Workspaces { screen: root.screen }
        active: true
    }

    // StatusIconsLeft positioned relative to Workspaces (left side)
    Loader {
        id: statusLeftLoader
        anchors.right: workspacesLoader.left
        anchors.rightMargin: Appearance.spacing.small
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: StatusIconsLeft {}
    }

    // Clock positioned relative to Workspaces (right side)
    Loader {
        id: clockLoader
        anchors.left: workspacesLoader.right
        anchors.leftMargin: Appearance.spacing.small
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: Clock {}
    }

    RowLayout {
        id: rightSection
        anchors.right: parent.right
        anchors.rightMargin: root.hPadding
        anchors.verticalCenter: parent.verticalCenter
        spacing: Appearance.spacing.small

        Loader { id: statusRightLoader; sourceComponent: StatusIconsRight {} }
        // Loader { id: powerLoader; sourceComponent: Power { visibilities: root.visibilities } }
    }

    // WrappedLoader no longer needed with three-section structure

    // Dengarkan sinyal dari popouts untuk kontrol timer close ketika hover konten
    Connections {
        target: popouts
        function onHoverContent(inside) {
            if (inside) {
                popoutCloseTimer.stop();
            } else if (!popouts.isDetached) {
                // Only restart timer for preview mode, not detached
                popoutCloseTimer.restart();
=======
        } else if (y < screen.height / 2 && Config.bar.scrollActions.volume) {
            // Volume scroll on top half
            if (angleDelta.y > 0)
                Audio.incrementVolume();
            else if (angleDelta.y < 0)
                Audio.decrementVolume();
        } else if (Config.bar.scrollActions.brightness) {
            // Brightness scroll on bottom half
            const monitor = Brightness.getMonitorForScreen(screen);
            if (angleDelta.y > 0)
                monitor.setBrightness(monitor.brightness + 0.1);
            else if (angleDelta.y < 0)
                monitor.setBrightness(monitor.brightness - 0.1);
        }
    }

    spacing: Appearance.spacing.normal

    Repeater {
        id: repeater

        model: Config.bar.entries

        DelegateChooser {
            role: "id"

            DelegateChoice {
                roleValue: "spacer"
                delegate: WrappedLoader {
                    Layout.fillHeight: enabled
                }
            }
            DelegateChoice {
                roleValue: "logo"
                delegate: WrappedLoader {
                    sourceComponent: OsIcon {}
                }
            }
            DelegateChoice {
                roleValue: "workspaces"
                delegate: WrappedLoader {
                    sourceComponent: Workspaces {
                        screen: root.screen
                    }
                }
            }
            DelegateChoice {
                roleValue: "activeWindow"
                delegate: WrappedLoader {
                    sourceComponent: ActiveWindow {
                        bar: root
                        monitor: Brightness.getMonitorForScreen(root.screen)
                    }
                }
            }
            DelegateChoice {
                roleValue: "tray"
                delegate: WrappedLoader {
                    sourceComponent: Tray {}
                }
            }
            DelegateChoice {
                roleValue: "clock"
                delegate: WrappedLoader {
                    sourceComponent: Clock {}
                }
            }
            DelegateChoice {
                roleValue: "statusIcons"
                delegate: WrappedLoader {
                    sourceComponent: StatusIcons {}
                }
            }
            DelegateChoice {
                roleValue: "power"
                delegate: WrappedLoader {
                    sourceComponent: Power {
                        visibilities: root.visibilities
                    }
                }
>>>>>>> origin/master
            }
        }
    }

<<<<<<< HEAD
    // Click anywhere outside detached content to close it
    MouseArea {
        anchors.fill: parent
        enabled: root.popouts.isDetached
        z: 999
        propagateComposedEvents: true
        onPressed: (mouse) => {
            // Check if click is outside the detached content bounds
            const x = mouse.x;
            const y = mouse.y;
            const margin = 0;
            const px = (popouts.contentX ?? popouts.x) - margin;
            const py = (popouts.contentY ?? popouts.y) - margin;
            const pw = (popouts.contentW ?? popouts.nonAnimWidth) + margin * 2;
            const ph = (popouts.contentH ?? popouts.nonAnimHeight) + margin * 2;
            const overPopout = x >= px && x <= (px + pw) && y >= py && y <= (py + ph);
            
            if (!overPopout) {
                popouts.close();
                mouse.accepted = true;
            } else {
                mouse.accepted = false;
            }
        }
=======
    component WrappedLoader: Loader {
        required property bool enabled
        required property string id
        required property int index

        function findFirstEnabled(): Item {
            const count = repeater.count;
            for (let i = 0; i < count; i++) {
                const item = repeater.itemAt(i);
                if (item?.enabled)
                    return item;
            }
            return null;
        }

        function findLastEnabled(): Item {
            for (let i = repeater.count - 1; i >= 0; i--) {
                const item = repeater.itemAt(i);
                if (item?.enabled)
                    return item;
            }
            return null;
        }

        Layout.alignment: Qt.AlignHCenter

        // Cursed ahh thing to add padding to first and last enabled components
        Layout.topMargin: findFirstEnabled() === this ? root.vPadding : 0
        Layout.bottomMargin: findLastEnabled() === this ? root.vPadding : 0

        visible: enabled
        active: enabled
>>>>>>> origin/master
    }
}
