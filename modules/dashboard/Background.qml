<<<<<<< HEAD
pragma ComponentBehavior: Bound

=======
>>>>>>> origin/master
import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Shapes

ShapePath {
    id: root

    required property Wrapper wrapper
<<<<<<< HEAD
    property real startX: 0
    property real startY: 0
    
    readonly property real rounding: Config.border.rounding
    readonly property bool flatten: wrapper.width < rounding * 2
    readonly property real roundingX: flatten ? wrapper.width / 2 : rounding
    readonly property bool shouldRender: wrapper.width > 0 && wrapper.height > 0

    strokeWidth: -1
    fillColor: shouldRender ? Colours.palette.m3surface : "transparent"

    PathMove {
        x: root.startX + root.roundingX
        y: root.startY
    }

    // Top edge
    PathLine {
        relativeX: root.wrapper.width - root.roundingX * 2
        relativeY: 0
    }

    // Top-right corner
    PathArc {
        relativeX: root.roundingX
        relativeY: root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
    }

    // Right edge
    PathLine {
        relativeX: 0
        relativeY: root.wrapper.height - root.rounding * 2
    }

    // Bottom-right corner
    PathArc {
        relativeX: -root.roundingX
        relativeY: root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
    }

    // Bottom edge
    PathLine {
        relativeX: -(root.wrapper.width - root.roundingX * 2)
        relativeY: 0
    }

    // Bottom-left corner
    PathArc {
        relativeX: -root.roundingX
        relativeY: -root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
    }

    // Left edge
    PathLine {
        relativeX: 0
        relativeY: -(root.wrapper.height - root.rounding * 2)
    }

    // Top-left corner
    PathArc {
        relativeX: root.roundingX
        relativeY: -root.rounding
        radiusX: root.rounding
        radiusY: root.rounding
=======
    readonly property real rounding: Config.border.rounding
    readonly property bool flatten: wrapper.height < rounding * 2
    readonly property real roundingY: flatten ? wrapper.height / 2 : rounding

    strokeWidth: -1
    fillColor: Colours.palette.m3surface

    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: Math.min(root.rounding, root.wrapper.height)
    }

    PathLine {
        relativeX: 0
        relativeY: root.wrapper.height - root.roundingY * 2
    }

    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: Math.min(root.rounding, root.wrapper.height)
        direction: PathArc.Counterclockwise
    }

    PathLine {
        relativeX: root.wrapper.width - root.rounding * 2
        relativeY: 0
    }

    PathArc {
        relativeX: root.rounding
        relativeY: -root.roundingY
        radiusX: root.rounding
        radiusY: Math.min(root.rounding, root.wrapper.height)
        direction: PathArc.Counterclockwise
    }

    PathLine {
        relativeX: 0
        relativeY: -(root.wrapper.height - root.roundingY * 2)
    }

    PathArc {
        relativeX: root.rounding
        relativeY: -root.roundingY
        radiusX: root.rounding
        radiusY: Math.min(root.rounding, root.wrapper.height)
>>>>>>> origin/master
    }

    Behavior on fillColor {
        CAnim {}
    }
}
