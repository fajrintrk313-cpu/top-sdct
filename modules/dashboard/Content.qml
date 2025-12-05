pragma ComponentBehavior: Bound

import qs.components
import qs.components.filedialog
import qs.config
<<<<<<< HEAD
import qs.utils
=======
>>>>>>> origin/master
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property PersistentProperties visibilities
    required property PersistentProperties state
    required property FileDialog facePicker
<<<<<<< HEAD

    // Dynamic sizing based on CURRENT displayed pane
    readonly property real tabsWidth: tabs.implicitWidth
    readonly property real contentPadding: 32
    readonly property real rowSpacing: 16
    
    // Calculate current tab index
    readonly property int currentTabIndex: root.state.currentTab ?? 0
    
    // Dimensions depend on which pane is currently shown
    // This will auto-update when the loaders' implicit sizes change
    readonly property real currentPaneWidth: {
        // When tab changes, this binding updates based on the loaded content
        const item = row.children[currentTabIndex];
        return item?.implicitWidth ?? 750;
    }
    readonly property real currentPaneHeight: {
        const item = row.children[currentTabIndex];
        return item?.implicitHeight ?? 700;
    }
    
    // Dashboard dimensions = tabs + spacing + current pane + padding
    readonly property real nonAnimWidth: tabsWidth + rowSpacing + currentPaneWidth + contentPadding
    readonly property real nonAnimHeight: currentPaneHeight + contentPadding
=======
    readonly property real nonAnimWidth: view.implicitWidth + viewWrapper.anchors.margins * 2
    readonly property real nonAnimHeight: tabs.implicitHeight + tabs.anchors.topMargin + view.implicitHeight + viewWrapper.anchors.margins * 2
>>>>>>> origin/master

    implicitWidth: nonAnimWidth
    implicitHeight: nonAnimHeight

<<<<<<< HEAD
    RowLayout {
        id: mainRow

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: Appearance.padding.large
        anchors.rightMargin: Appearance.padding.large
        anchors.topMargin: Appearance.padding.large
        anchors.bottomMargin: Appearance.padding.large
        spacing: Appearance.spacing.normal

        Tabs {
            id: tabs
            Layout.fillHeight: true
            state: root.state
        }

        ClippingRectangle {
            id: viewWrapper

            Layout.fillWidth: true
            Layout.fillHeight: true

            radius: Appearance.rounding.normal
            color: "transparent"

            Flickable {
                id: view

                readonly property int currentIndex: root.state.currentTab
                readonly property Item currentItem: row.children[currentIndex]

                anchors.fill: parent
                flickableDirection: Flickable.HorizontalFlick

                implicitWidth: currentItem?.implicitWidth ?? 400
                implicitHeight: currentItem?.implicitHeight ?? 300

                contentX: currentItem?.x ?? 0
                contentWidth: row.implicitWidth
                contentHeight: row.implicitHeight

                onContentXChanged: {
                    if (!moving) return;
                    const x = contentX - (currentItem?.x ?? 0);
                    if (x > (currentItem?.implicitWidth ?? 400) / 2)
                        root.state.currentTab = Math.min(root.state.currentTab + 1, tabs.count - 1);
                    else if (x < -(currentItem?.implicitWidth ?? 400) / 2)
                        root.state.currentTab = Math.max(root.state.currentTab - 1, 0);
                }

                onDragEnded: {
                    const x = contentX - (currentItem?.x ?? 0);
                    if (x > (currentItem?.implicitWidth ?? 400) / 10)
                        root.state.currentTab = Math.min(root.state.currentTab + 1, tabs.count - 1);
                    else if (x < -(currentItem?.implicitWidth ?? 400) / 10)
                        root.state.currentTab = Math.max(root.state.currentTab - 1, 0);
                    else
                        contentX = Qt.binding(() => currentItem?.x ?? 0);
                }

                RowLayout {
                    id: row

                    Pane { sourceComponent: Dash { visibilities: root.visibilities; state: root.state; facePicker: root.facePicker } }
                    Pane { sourceComponent: Media { visibilities: root.visibilities } }
                    Pane { sourceComponent: Performance {} }
                }

                Behavior on contentX { Anim {} }
            }
=======
    Tabs {
        id: tabs

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Appearance.padding.normal
        anchors.margins: Appearance.padding.large

        nonAnimWidth: root.nonAnimWidth - anchors.margins * 2
        state: root.state
    }

    ClippingRectangle {
        id: viewWrapper

        anchors.top: tabs.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Appearance.padding.large

        radius: Appearance.rounding.normal
        color: "transparent"

        Flickable {
            id: view

            readonly property int currentIndex: root.state.currentTab
            readonly property Item currentItem: row.children[currentIndex]

            anchors.fill: parent

            flickableDirection: Flickable.HorizontalFlick

            implicitWidth: currentItem.implicitWidth
            implicitHeight: currentItem.implicitHeight

            contentX: currentItem.x
            contentWidth: row.implicitWidth
            contentHeight: row.implicitHeight

            onContentXChanged: {
                if (!moving)
                    return;

                const x = contentX - currentItem.x;
                if (x > currentItem.implicitWidth / 2)
                    root.state.currentTab = Math.min(root.state.currentTab + 1, tabs.count - 1);
                else if (x < -currentItem.implicitWidth / 2)
                    root.state.currentTab = Math.max(root.state.currentTab - 1, 0);
            }

            onDragEnded: {
                const x = contentX - currentItem.x;
                if (x > currentItem.implicitWidth / 10)
                    root.state.currentTab = Math.min(root.state.currentTab + 1, tabs.count - 1);
                else if (x < -currentItem.implicitWidth / 10)
                    root.state.currentTab = Math.max(root.state.currentTab - 1, 0);
                else
                    contentX = Qt.binding(() => currentItem.x);
            }

            RowLayout {
                id: row

                Pane {
                    sourceComponent: Dash {
                        visibilities: root.visibilities
                        state: root.state
                        facePicker: root.facePicker
                    }
                }

                Pane {
                    sourceComponent: Media {
                        visibilities: root.visibilities
                    }
                }

                Pane {
                    sourceComponent: Performance {}
                }
            }

            Behavior on contentX {
                Anim {}
            }
        }
    }

    Behavior on implicitWidth {
        Anim {
            duration: Appearance.anim.durations.large
            easing.bezierCurve: Appearance.anim.curves.emphasized
        }
    }

    Behavior on implicitHeight {
        Anim {
            duration: Appearance.anim.durations.large
            easing.bezierCurve: Appearance.anim.curves.emphasized
>>>>>>> origin/master
        }
    }

    component Pane: Loader {
        Layout.alignment: Qt.AlignTop

        Component.onCompleted: active = Qt.binding(() => {
            const vx = Math.floor(view.visibleArea.xPosition * view.contentWidth);
            const vex = Math.floor(vx + view.visibleArea.widthRatio * view.contentWidth);
<<<<<<< HEAD
            return (vx >= x && vx <= x + (implicitWidth ?? 0)) || (vex >= x && vex <= x + (implicitWidth ?? 0));
=======
            return (vx >= x && vx <= x + implicitWidth) || (vex >= x && vex <= x + implicitWidth);
>>>>>>> origin/master
        })
    }
}
