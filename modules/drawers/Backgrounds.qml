import qs.services
import qs.config
import qs.modules.osd as Osd
import qs.modules.notifications as Notifications
import qs.modules.session as Session
import qs.modules.launcher as Launcher
import qs.modules.dashboard as Dashboard
import qs.modules.bar.popouts as BarPopouts
import qs.modules.utilities as Utilities
import qs.modules.sidebar as Sidebar
import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    required property Panels panels
    required property Item bar

    anchors.fill: parent
    anchors.margins: Config.border.thickness
<<<<<<< HEAD
    anchors.topMargin: bar.implicitHeight
=======
    anchors.leftMargin: bar.implicitWidth
>>>>>>> origin/master
    preferredRendererType: Shape.CurveRenderer

    Osd.Background {
        wrapper: root.panels.osd

        startX: root.width - root.panels.session.width - root.panels.sidebar.width
<<<<<<< HEAD
        startY: (root.height - wrapper.height) / 2 - Config.border.rounding
=======
        startY: (root.height - wrapper.height) / 2 - rounding
>>>>>>> origin/master
    }

    Notifications.Background {
        wrapper: root.panels.notifications
        sidebar: sidebar

        startX: root.width
        startY: 0
    }

    Session.Background {
        wrapper: root.panels.session

        startX: root.width - root.panels.sidebar.width
<<<<<<< HEAD
        startY: (root.height - wrapper.height) / 2 - Config.border.rounding
=======
        startY: (root.height - wrapper.height) / 2 - rounding
>>>>>>> origin/master
    }

    Launcher.Background {
        wrapper: root.panels.launcher

<<<<<<< HEAD
        startX: (root.width - wrapper.width) / 2 - Config.border.rounding
=======
        startX: (root.width - wrapper.width) / 2 - rounding
>>>>>>> origin/master
        startY: root.height
    }

    Dashboard.Background {
        wrapper: root.panels.dashboard

<<<<<<< HEAD
        startX: 0
        startY: (root.height - wrapper.height) / 2
=======
        startX: (root.width - wrapper.width) / 2 - rounding
        startY: 0
>>>>>>> origin/master
    }

    BarPopouts.Background {
        wrapper: root.panels.popouts
        invertBottomRounding: wrapper.y + wrapper.height + 1 >= root.height

        startX: wrapper.x
<<<<<<< HEAD
        startY: wrapper.y - rounding * sideRounding + wrapper.bgOffset
=======
        startY: wrapper.y - rounding * sideRounding
>>>>>>> origin/master
    }

    Utilities.Background {
        wrapper: root.panels.utilities
        sidebar: sidebar

        startX: root.width
        startY: root.height
    }

    Sidebar.Background {
        id: sidebar

        wrapper: root.panels.sidebar
        panels: root.panels

        startX: root.width
        startY: root.panels.notifications.height
    }
}
