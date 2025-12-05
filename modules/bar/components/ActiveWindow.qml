pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import QtQuick

Item {
    id: root

    required property var bar
    required property Brightness.Monitor monitor
    property color colour: Colours.palette.m3primary

    readonly property int maxHeight: {
        const otherModules = bar.children.filter(c => c.id && c.item !== this && c.id !== "spacer");
        const otherHeight = otherModules.reduce((acc, curr) => acc + (curr.item.nonAnimHeight ?? curr.height), 0);
        // Length - 2 cause repeater counts as a child
<<<<<<< HEAD
        return bar.height - otherHeight - bar.spacing * (bar.children.length - 1) - bar.hPadding * 2;
    }

    clip: true
    implicitWidth: textColumn.implicitWidth
    implicitHeight: textColumn.implicitHeight

    Loader {
        id: icon
        active: false  // Set to false to hide icon completely
        
        sourceComponent: MaterialIcon {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            animate: true
            text: Icons.getAppCategoryIcon(Hypr.activeToplevel?.lastIpcObject.class, "desktop_windows")
            color: root.colour
        }
    }

    // TextMetrics for app name (bottom row - bold sans)
    TextMetrics {
        id: appNameMetrics
        text: {
            const className = Hypr.activeToplevel?.lastIpcObject.class ?? "Desktop";
            return className.charAt(0).toUpperCase() + className.slice(1);
        }
        font.pointSize: Appearance.font.size.smaller * 0.85
        font.family: Appearance.font.family.sans
        font.weight: Font.DemiBold
        elide: Qt.ElideRight
        elideWidth: 300
    }

    // TextMetrics for window title (top row - smaller mono)
    TextMetrics {
        id: windowTitleMetrics
        text: Hypr.activeToplevel?.title ?? qsTr("Desktop")
        font.pointSize: Appearance.font.size.smaller * 0.8
        font.family: Appearance.font.family.mono
        elide: Qt.ElideRight
        elideWidth: 300
    }

    Column {
        id: textColumn

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: -2

        // App Name (bottom row) - bold sans style
        StyledText {
            id: windowTitleText

            text: appNameMetrics.elidedText
            color: root.colour
            font.pointSize: Appearance.font.size.smaller * 0.8
            font.family: Appearance.font.family.sans
            font.weight: Font.DemiBold
            animate: true
        }
        // Window Title (top row) - smaller mono style
        StyledText {
            id: appNameText

            text: windowTitleMetrics.elidedText
            color: Qt.rgba(root.colour.r, root.colour.g, root.colour.b, 0.7)  // Slightly transparent
            font.pointSize: Appearance.font.size.smaller * 0.85
            font.family: Appearance.font.family.mono
            animate: true
        }

=======
        return bar.height - otherHeight - bar.spacing * (bar.children.length - 1) - bar.vPadding * 2;
    }
    property Title current: text1

    clip: true
    implicitWidth: Math.max(icon.implicitWidth, current.implicitHeight)
    implicitHeight: icon.implicitHeight + current.implicitWidth + current.anchors.topMargin

    MaterialIcon {
        id: icon

        anchors.horizontalCenter: parent.horizontalCenter

        animate: true
        text: Icons.getAppCategoryIcon(Hypr.activeToplevel?.lastIpcObject.class, "desktop_windows")
        color: root.colour
    }

    Title {
        id: text1
    }

    Title {
        id: text2
    }

    TextMetrics {
        id: metrics

        text: Hypr.activeToplevel?.title ?? qsTr("Desktop")
        font.pointSize: Appearance.font.size.smaller
        font.family: Appearance.font.family.mono
        elide: Qt.ElideRight
        elideWidth: root.maxHeight - icon.height

        onTextChanged: {
            const next = root.current === text1 ? text2 : text1;
            next.text = elidedText;
            root.current = next;
        }
        onElideWidthChanged: root.current.text = elidedText
>>>>>>> origin/master
    }

    Behavior on implicitHeight {
        Anim {
            duration: Appearance.anim.durations.expressiveDefaultSpatial
            easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
        }
    }
<<<<<<< HEAD
=======

    component Title: StyledText {
        id: text

        anchors.horizontalCenter: icon.horizontalCenter
        anchors.top: icon.bottom
        anchors.topMargin: Appearance.spacing.small

        font.pointSize: metrics.font.pointSize
        font.family: metrics.font.family
        color: root.colour
        opacity: root.current === this ? 1 : 0

        transform: Rotation {
            angle: 90
            origin.x: text.implicitHeight / 2
            origin.y: text.implicitHeight / 2
        }

        width: implicitHeight
        height: implicitWidth

        Behavior on opacity {
            Anim {}
        }
    }
>>>>>>> origin/master
}
