import Quickshell.Io

JsonObject {
    property bool persistent: true
    property bool showOnHover: true
    property int dragThreshold: 20
    property ScrollActions scrollActions: ScrollActions {}
    property Popouts popouts: Popouts {}
    property Workspaces workspaces: Workspaces {}
    property Tray tray: Tray {}
    property Status status: Status {}
    property Clock clock: Clock {}
    property Sizes sizes: Sizes {}

    property list<var> entries: [
        {
            id: "logo",
            enabled: true
        },
        {
<<<<<<< HEAD
            id: "activeWindow",
=======
            id: "workspaces",
>>>>>>> origin/master
            enabled: true
        },
        {
            id: "spacer",
            enabled: true
        },
        {
<<<<<<< HEAD
            id: "workspaces",
            enabled: true
        },
        {
            id: "clock",
            enabled: false
        },
        {
=======
            id: "activeWindow",
            enabled: true
        },
        {
>>>>>>> origin/master
            id: "spacer",
            enabled: true
        },
        {
            id: "tray",
            enabled: true
        },
        {
<<<<<<< HEAD
=======
            id: "clock",
            enabled: true
        },
        {
>>>>>>> origin/master
            id: "statusIcons",
            enabled: true
        },
        {
            id: "power",
<<<<<<< HEAD
            enabled: false
=======
            enabled: true
>>>>>>> origin/master
        }
    ]

    component ScrollActions: JsonObject {
        property bool workspaces: true
        property bool volume: true
        property bool brightness: true
    }

    component Popouts: JsonObject {
        property bool activeWindow: true
        property bool tray: true
        property bool statusIcons: true
    }

    component Workspaces: JsonObject {
        property int shown: 5
        property bool activeIndicator: true
        property bool occupiedBg: false
        property bool showWindows: true
        property bool showWindowsOnSpecialWorkspaces: showWindows
        property bool activeTrail: false
        property bool perMonitorWorkspaces: true
<<<<<<< HEAD
        property string label: "" // if empty, will show workspace name's first letter
=======
        property string label: "  " // if empty, will show workspace name's first letter
>>>>>>> origin/master
        property string occupiedLabel: "󰮯"
        property string activeLabel: "󰮯"
        property string capitalisation: "preserve" // upper, lower, or preserve - relevant only if label is empty
        property list<var> specialWorkspaceIcons: []
    }

    component Tray: JsonObject {
        property bool background: false
        property bool recolour: false
        property bool compact: false
        property list<var> iconSubs: []
    }

    component Status: JsonObject {
        property bool showAudio: false
        property bool showMicrophone: false
        property bool showKbLayout: false
        property bool showNetwork: true
        property bool showBluetooth: true
        property bool showBattery: true
        property bool showLockStatus: true
    }

    component Clock: JsonObject {
        property bool showIcon: true
    }

    component Sizes: JsonObject {
<<<<<<< HEAD
        property int innerHeight: 34
        property int maxWidth: 1920
=======
        property int innerWidth: 40
>>>>>>> origin/master
        property int windowPreviewSize: 400
        property int trayMenuWidth: 300
        property int batteryWidth: 250
        property int networkWidth: 320
    }
}
