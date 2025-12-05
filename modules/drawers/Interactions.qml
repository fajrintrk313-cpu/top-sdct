import qs.components.controls
import qs.config
import qs.modules.bar.popouts as BarPopouts
import Quickshell
import QtQuick

CustomMouseArea {
    id: root

    required property ShellScreen screen
    required property BarPopouts.Wrapper popouts
    required property PersistentProperties visibilities
    required property Panels panels
    required property Item bar

    property point dragStart
    property bool dashboardShortcutActive
    property bool osdShortcutActive
    property bool utilitiesShortcutActive

    function withinPanelHeight(panel: Item, x: real, y: real): bool {
<<<<<<< HEAD
        // Calculate panel's absolute Y position accounting for vertical centering
        // Panel is centered within Panels area, which is inset by bar.implicitHeight at top
        const panelsHeight = root.height - bar.implicitHeight - Config.border.thickness;
        const panelsOffsetY = bar.implicitHeight;
        const panelsCenterY = panelsOffsetY + panelsHeight / 2;
        const panelVisualY = panelsCenterY - panel.height / 2;
        return y >= panelVisualY - Config.border.rounding && y <= panelVisualY + panel.height + Config.border.rounding;
    }

    function withinPanelWidth(panel: Item, x: real, y: real): bool {
        const panelX = Config.border.thickness + panel.x;
        return x >= panelX - Config.border.rounding && x <= panelX + panel.width + Config.border.rounding;
    }

    function inTopPanel(panel: Item, x: real, y: real): bool {
        return y < bar.implicitHeight + panel.y + panel.height && withinPanelWidth(panel, x, y);
    }

    function inLeftPanel(panel: Item, x: real, y: real): bool {
        // Trigger area is ONLY the narrow strip on the left edge for hover detection
        // NOT the entire dashboard width
        const triggerWidth = Config.dashboard.hoverWidth;
        return x < triggerWidth && withinPanelHeight(panel, x, y);
    }

    function inDashboardFullArea(panel: Item, x: real, y: real): bool {
        // Check if cursor is within the ENTIRE dashboard area (trigger + content)
        // This keeps the dashboard open when cursor is inside the content
        // Need to account for Panels offset from window edges
        const panelsOffsetX = Config.border.thickness;
        const panelsOffsetY = bar.implicitHeight;
        
        // Convert panel coordinates from Panels space to window space
        const panelX = panelsOffsetX + panel.x;
        const panelY = panelsOffsetY + panel.y;
        
        return x >= panelX && x <= panelX + panel.width && 
               y >= panelY && y <= panelY + panel.height;
    }

    function inRightPanel(panel: Item, x: real, y: real): bool {
        return x > root.width - Config.border.thickness - panel.width - Config.border.rounding && withinPanelHeight(panel, x, y);
    }

    function inBottomPanel(panel: Item, x: real, y: real): bool {
        return y > bar.implicitHeight + panel.y && withinPanelWidth(panel, x, y);
    }

    function onWheel(event: WheelEvent): void {
        if (event.y < bar.implicitHeight) {
            bar.handleWheel(event.x, event.angleDelta);
=======
        const panelY = Config.border.thickness + panel.y;
        return y >= panelY - Config.border.rounding && y <= panelY + panel.height + Config.border.rounding;
    }

    function withinPanelWidth(panel: Item, x: real, y: real): bool {
        const panelX = bar.implicitWidth + panel.x;
        return x >= panelX - Config.border.rounding && x <= panelX + panel.width + Config.border.rounding;
    }

    function inLeftPanel(panel: Item, x: real, y: real): bool {
        return x < bar.implicitWidth + panel.x + panel.width && withinPanelHeight(panel, x, y);
    }

    function inRightPanel(panel: Item, x: real, y: real): bool {
        return x > bar.implicitWidth + panel.x && withinPanelHeight(panel, x, y);
    }

    function inTopPanel(panel: Item, x: real, y: real): bool {
        return y < Config.border.thickness + panel.y + panel.height && withinPanelWidth(panel, x, y);
    }

    function inBottomPanel(panel: Item, x: real, y: real): bool {
        return y > root.height - Config.border.thickness - panel.height - Config.border.rounding && withinPanelWidth(panel, x, y);
    }

    function onWheel(event: WheelEvent): void {
        if (event.x < bar.implicitWidth) {
            bar.handleWheel(event.y, event.angleDelta);
>>>>>>> origin/master
        }
    }

    anchors.fill: parent
    hoverEnabled: true

    onPressed: event => dragStart = Qt.point(event.x, event.y)
    onContainsMouseChanged: {
        if (!containsMouse) {
            // Only hide if not activated by shortcut
            if (!osdShortcutActive) {
                visibilities.osd = false;
                root.panels.osd.hovered = false;
            }

            if (!dashboardShortcutActive)
                visibilities.dashboard = false;

            if (!utilitiesShortcutActive)
                visibilities.utilities = false;

            if (!popouts.currentName.startsWith("traymenu") || (popouts.current?.depth ?? 0) <= 1) {
                popouts.hasCurrent = false;
<<<<<<< HEAD
                popouts.close();  // ← PERBAIKAN: Explicitly close popouts/backdrop
=======
>>>>>>> origin/master
                bar.closeTray();
            }

            if (Config.bar.showOnHover)
                bar.isHovered = false;
        }
    }

    onPositionChanged: event => {
        if (popouts.isDetached)
            return;

        const x = event.x;
        const y = event.y;
        const dragX = x - dragStart.x;
        const dragY = y - dragStart.y;

        // Show bar in non-exclusive mode on hover
<<<<<<< HEAD
        if (!visibilities.bar && Config.bar.showOnHover && y < bar.implicitHeight)
            bar.isHovered = true;

        // Show/hide bar on drag
        if (pressed && dragStart.y < bar.implicitHeight) {
            if (dragY > Config.bar.dragThreshold)
                visibilities.bar = true;
            else if (dragY < -Config.bar.dragThreshold)
=======
        if (!visibilities.bar && Config.bar.showOnHover && x < bar.implicitWidth)
            bar.isHovered = true;

        // Show/hide bar on drag
        if (pressed && dragStart.x < bar.implicitWidth) {
            if (dragX > Config.bar.dragThreshold)
                visibilities.bar = true;
            else if (dragX < -Config.bar.dragThreshold)
>>>>>>> origin/master
                visibilities.bar = false;
        }

        if (panels.sidebar.width === 0) {
            // Show osd on hover
            const showOsd = inRightPanel(panels.osd, x, y);

            // Always update visibility based on hover if not in shortcut mode
            if (!osdShortcutActive) {
                visibilities.osd = showOsd;
                root.panels.osd.hovered = showOsd;
            } else if (showOsd) {
                // If hovering over OSD area while in shortcut mode, transition to hover control
                osdShortcutActive = false;
                root.panels.osd.hovered = true;
            }

<<<<<<< HEAD
            const showSidebar = pressed && dragStart.y > bar.implicitHeight;

            // Show/hide session on drag
            if (pressed && inBottomPanel(panels.session, dragStart.x, dragStart.y) && withinPanelWidth(panels.session, x, y)) {
                if (dragY < -Config.session.dragThreshold)
                    visibilities.session = true;
                else if (dragY > Config.session.dragThreshold)
                    visibilities.session = false;

                // Show sidebar on drag if in session area
                if (showSidebar && dragY < -Config.sidebar.dragThreshold)
                    visibilities.sidebar = true;
            } else if (showSidebar && dragY < -Config.sidebar.dragThreshold) {
=======
            const showSidebar = pressed && dragStart.x > bar.implicitWidth + panels.sidebar.x;

            // Show/hide session on drag
            if (pressed && inRightPanel(panels.session, dragStart.x, dragStart.y) && withinPanelHeight(panels.session, x, y)) {
                if (dragX < -Config.session.dragThreshold)
                    visibilities.session = true;
                else if (dragX > Config.session.dragThreshold)
                    visibilities.session = false;

                // Show sidebar on drag if in session area and session is nearly fully visible
                if (showSidebar && panels.session.width >= panels.session.nonAnimWidth && dragX < -Config.sidebar.dragThreshold)
                    visibilities.sidebar = true;
            } else if (showSidebar && dragX < -Config.sidebar.dragThreshold) {
>>>>>>> origin/master
                // Show sidebar on drag if not in session area
                visibilities.sidebar = true;
            }
        } else {
<<<<<<< HEAD
            // Show osd on hover
            const showOsd = inRightPanel(panels.osd, x, y);
=======
            const outOfSidebar = x < width - panels.sidebar.width;
            // Show osd on hover
            const showOsd = outOfSidebar && inRightPanel(panels.osd, x, y);
>>>>>>> origin/master

            // Always update visibility based on hover if not in shortcut mode
            if (!osdShortcutActive) {
                visibilities.osd = showOsd;
                root.panels.osd.hovered = showOsd;
            } else if (showOsd) {
                // If hovering over OSD area while in shortcut mode, transition to hover control
                osdShortcutActive = false;
                root.panels.osd.hovered = true;
            }

            // Show/hide session on drag
<<<<<<< HEAD
            if (pressed && inBottomPanel(panels.session, dragStart.x, dragStart.y) && withinPanelWidth(panels.session, x, y)) {
                if (dragY < -Config.session.dragThreshold)
                    visibilities.session = true;
                else if (dragY > Config.session.dragThreshold)
=======
            if (pressed && outOfSidebar && inRightPanel(panels.session, dragStart.x, dragStart.y) && withinPanelHeight(panels.session, x, y)) {
                if (dragX < -Config.session.dragThreshold)
                    visibilities.session = true;
                else if (dragX > Config.session.dragThreshold)
>>>>>>> origin/master
                    visibilities.session = false;
            }

            // Hide sidebar on drag
<<<<<<< HEAD
            if (pressed && inBottomPanel(panels.sidebar, dragStart.x, dragStart.y) && dragY > Config.sidebar.dragThreshold)
=======
            if (pressed && inRightPanel(panels.sidebar, dragStart.x, 0) && dragX > Config.sidebar.dragThreshold)
>>>>>>> origin/master
                visibilities.sidebar = false;
        }

        // Show launcher on hover, or show/hide on drag if hover is disabled
        if (Config.launcher.showOnHover) {
            if (!visibilities.launcher && inBottomPanel(panels.launcher, x, y))
                visibilities.launcher = true;
        } else if (pressed && inBottomPanel(panels.launcher, dragStart.x, dragStart.y) && withinPanelWidth(panels.launcher, x, y)) {
            if (dragY < -Config.launcher.dragThreshold)
                visibilities.launcher = true;
            else if (dragY > Config.launcher.dragThreshold)
                visibilities.launcher = false;
        }

        // Show dashboard on hover
<<<<<<< HEAD
        // Check ENTIRE dashboard area (trigger + content) to keep it open while cursor is inside
        const inDashboard = inDashboardFullArea(panels.dashboard, x, y);
        const showDashboard = Config.dashboard.showOnHover && (inLeftPanel(panels.dashboard, x, y) || inDashboard);

        // Always update visibility based on hover if not in shortcut mode
        if (!dashboardShortcutActive) {
            visibilities.dashboard = showDashboard;  // ← IMPORTANT: Set to false only when COMPLETELY outside dashboard area
        } else if (inDashboard) {
            // If cursor is anywhere in dashboard area while in shortcut mode, transition to hover control
=======
        const showDashboard = Config.dashboard.showOnHover && inTopPanel(panels.dashboard, x, y);

        // Always update visibility based on hover if not in shortcut mode
        if (!dashboardShortcutActive) {
            visibilities.dashboard = showDashboard;
        } else if (showDashboard) {
            // If hovering over dashboard area while in shortcut mode, transition to hover control
>>>>>>> origin/master
            dashboardShortcutActive = false;
        }

        // Show/hide dashboard on drag (for touchscreen devices)
<<<<<<< HEAD
        if (pressed && inLeftPanel(panels.dashboard, dragStart.x, dragStart.y) && withinPanelHeight(panels.dashboard, x, y)) {
=======
        if (pressed && inTopPanel(panels.dashboard, dragStart.x, dragStart.y) && withinPanelWidth(panels.dashboard, x, y)) {
>>>>>>> origin/master
            if (dragY > Config.dashboard.dragThreshold)
                visibilities.dashboard = true;
            else if (dragY < -Config.dashboard.dragThreshold)
                visibilities.dashboard = false;
        }

        // Show utilities on hover
        const showUtilities = inBottomPanel(panels.utilities, x, y);

        // Always update visibility based on hover if not in shortcut mode
        if (!utilitiesShortcutActive) {
            visibilities.utilities = showUtilities;
        } else if (showUtilities) {
            // If hovering over utilities area while in shortcut mode, transition to hover control
            utilitiesShortcutActive = false;
        }

        // Show popouts on hover
<<<<<<< HEAD
        if (y < bar.implicitHeight) {
            bar.checkPopout(x);
        } else if ((!popouts.currentName.startsWith("traymenu") || (popouts.current?.depth ?? 0) <= 1) && !inTopPanel(panels.popouts, x, y)) {
=======
        if (x < bar.implicitWidth) {
            bar.checkPopout(y);
        } else if ((!popouts.currentName.startsWith("traymenu") || (popouts.current?.depth ?? 0) <= 1) && !inLeftPanel(panels.popouts, x, y)) {
>>>>>>> origin/master
            popouts.hasCurrent = false;
            bar.closeTray();
        }
    }

    // Monitor individual visibility changes
    Connections {
        target: root.visibilities

        function onLauncherChanged() {
            // If launcher is hidden, clear shortcut flags for dashboard and OSD
            if (!root.visibilities.launcher) {
                root.dashboardShortcutActive = false;
                root.osdShortcutActive = false;
                root.utilitiesShortcutActive = false;

                // Also hide dashboard and OSD if they're not being hovered
<<<<<<< HEAD
                // Use full area check to allow hovering in content
                const inDashboardArea = root.inDashboardFullArea(root.panels.dashboard, root.mouseX, root.mouseY);
=======
                const inDashboardArea = root.inTopPanel(root.panels.dashboard, root.mouseX, root.mouseY);
>>>>>>> origin/master
                const inOsdArea = root.inRightPanel(root.panels.osd, root.mouseX, root.mouseY);

                if (!inDashboardArea) {
                    root.visibilities.dashboard = false;
                }
                if (!inOsdArea) {
                    root.visibilities.osd = false;
                    root.panels.osd.hovered = false;
                }
            }
        }

        function onDashboardChanged() {
            if (root.visibilities.dashboard) {
                // Dashboard became visible, immediately check if this should be shortcut mode
<<<<<<< HEAD
                // Use full area check to allow hovering in content
                const inDashboardArea = root.inDashboardFullArea(root.panels.dashboard, root.mouseX, root.mouseY);
=======
                const inDashboardArea = root.inTopPanel(root.panels.dashboard, root.mouseX, root.mouseY);
>>>>>>> origin/master
                if (!inDashboardArea) {
                    root.dashboardShortcutActive = true;
                }
            } else {
                // Dashboard hidden, clear shortcut flag
                root.dashboardShortcutActive = false;
            }
        }

        function onOsdChanged() {
            if (root.visibilities.osd) {
                // OSD became visible, immediately check if this should be shortcut mode
                const inOsdArea = root.inRightPanel(root.panels.osd, root.mouseX, root.mouseY);
                if (!inOsdArea) {
                    root.osdShortcutActive = true;
                }
            } else {
                // OSD hidden, clear shortcut flag
                root.osdShortcutActive = false;
            }
        }

        function onUtilitiesChanged() {
            if (root.visibilities.utilities) {
                // Utilities became visible, immediately check if this should be shortcut mode
                const inUtilitiesArea = root.inBottomPanel(root.panels.utilities, root.mouseX, root.mouseY);
                if (!inUtilitiesArea) {
                    root.utilitiesShortcutActive = true;
                }
            } else {
                // Utilities hidden, clear shortcut flag
                root.utilitiesShortcutActive = false;
            }
        }
    }
}
