pragma ComponentBehavior: Bound

import qs.components.containers
import qs.config
import Quickshell
import QtQuick

Scope {
    id: root

    required property ShellScreen screen
    required property Item bar

    ExclusionZone {
<<<<<<< HEAD
        anchors.top: true
=======
        anchors.left: true
>>>>>>> origin/master
        exclusiveZone: root.bar.exclusiveZone
    }

    ExclusionZone {
<<<<<<< HEAD
        anchors.left: true
        exclusiveZone: 0  // Hover trigger area only, no spacing
=======
        anchors.top: true
>>>>>>> origin/master
    }

    ExclusionZone {
        anchors.right: true
<<<<<<< HEAD
        exclusiveZone: 0  // Hover trigger area only, no spacing
=======
>>>>>>> origin/master
    }

    ExclusionZone {
        anchors.bottom: true
<<<<<<< HEAD
        exclusiveZone: 0  // Hover trigger area only, no spacing
=======
>>>>>>> origin/master
    }

    component ExclusionZone: StyledWindow {
        screen: root.screen
        name: "border-exclusion"
        exclusiveZone: Config.border.thickness
        mask: Region {}
        implicitWidth: 1
        implicitHeight: 1
    }
}
