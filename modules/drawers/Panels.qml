import qs.config
import qs.modules.osd as Osd
import qs.modules.notifications as Notifications
import qs.modules.session as Session
import qs.modules.launcher as Launcher
import qs.modules.dashboard as Dashboard
import qs.modules.bar.popouts as BarPopouts
import qs.modules.utilities as Utilities
import qs.modules.utilities.toasts as Toasts
import qs.modules.sidebar as Sidebar
import Quickshell
import QtQuick

Item {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Item bar

    readonly property alias osd: osd
    readonly property alias notifications: notifications
    readonly property alias session: session
    readonly property alias launcher: launcher
    readonly property alias dashboard: dashboard
    readonly property alias popouts: popouts
    readonly property alias utilities: utilities
    readonly property alias toasts: toasts
    readonly property alias sidebar: sidebar

    anchors.fill: parent
    anchors.margins: Config.border.thickness
<<<<<<< HEAD
    anchors.topMargin: bar.implicitHeight
=======
    anchors.leftMargin: bar.implicitWidth
>>>>>>> origin/master

    Osd.Wrapper {
        id: osd

        clip: session.width > 0 || sidebar.width > 0
        screen: root.screen
        visibilities: root.visibilities

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: session.width + sidebar.width
    }

    Notifications.Wrapper {
        id: notifications

        visibilities: root.visibilities
        panels: root

        anchors.top: parent.top
        anchors.right: parent.right
    }

    Session.Wrapper {
        id: session

        clip: sidebar.width > 0
        visibilities: root.visibilities
        panels: root

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: sidebar.width
    }

    Launcher.Wrapper {
        id: launcher

        screen: root.screen
        visibilities: root.visibilities
        panels: root

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    Dashboard.Wrapper {
        id: dashboard

        visibilities: root.visibilities

<<<<<<< HEAD
        anchors.left: parent.left
        
        // Position based on parent's vertical center, accounting for our height
        // This is set explicitly to prevent flickering during animation
        y: {
            const center = parent.height / 2;
            return Math.max(0, center - (implicitHeight / 2));
        }
=======
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
>>>>>>> origin/master
    }

    BarPopouts.Wrapper {
        id: popouts

        screen: root.screen

<<<<<<< HEAD
        x: {
            if (isDetached)
                return (root.width - nonAnimWidth) / 2;

            const off = currentCenter - Config.border.thickness - nonAnimWidth / 2;
            const diff = root.width - Math.floor(off + nonAnimWidth);
=======
        x: isDetached ? (root.width - nonAnimWidth) / 2 : 0
        y: {
            if (isDetached)
                return (root.height - nonAnimHeight) / 2;

            const off = currentCenter - Config.border.thickness - nonAnimHeight / 2;
            const diff = root.height - Math.floor(off + nonAnimHeight);
>>>>>>> origin/master
            if (diff < 0)
                return off + diff;
            return Math.max(off, 0);
        }
<<<<<<< HEAD
        y: isDetached ? (root.height - nonAnimHeight) / 2 : 0
        
        // Explicitly disable position animation to prevent layout flicker
        Behavior on x { enabled: false }
        Behavior on y { enabled: false }
=======
>>>>>>> origin/master
    }

    Utilities.Wrapper {
        id: utilities

        visibilities: root.visibilities
        sidebar: sidebar

        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

    Toasts.Toasts {
        id: toasts

        anchors.bottom: sidebar.visible ? parent.bottom : utilities.top
        anchors.right: sidebar.left
        anchors.margins: Appearance.padding.normal
    }

    Sidebar.Wrapper {
        id: sidebar

        visibilities: root.visibilities
        panels: root

<<<<<<< HEAD
        anchors.top: parent.top
        anchors.bottom: parent.bottom
=======
        anchors.top: notifications.bottom
        anchors.bottom: utilities.top
>>>>>>> origin/master
        anchors.right: parent.right
    }
}
