/*******************************************************************************
* Copyright (c) 2013-2021 "Filippo Scognamiglio"
* https://github.com/Swordfish90/cool-retro-term
*
* This file is part of cool-retro-term.
*
* cool-retro-term is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*******************************************************************************/
import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "menus"

ApplicationWindow {
    id: terminalWindow

    width: 1024
    height: 768

    property int normalWidth: 1024
    property int normalHeight: 768
    onWidthChanged: if (visibility === Window.Windowed) normalWidth = width
    onHeightChanged: if (visibility === Window.Windowed) normalHeight = height

    // Show the window once it is ready.
    Component.onCompleted: {
        width = normalWidth = appSettings.windowWidth
        height = normalHeight = appSettings.windowHeight
        visible = true
    }

    minimumWidth: 320
    minimumHeight: 240

    visible: false
    flags: Qt.Window | (appSettings.isWindows && appSettings.borderlessWindow ? Qt.FramelessWindowHint : 0)

    property bool fullscreen: false
    onFullscreenChanged: visibility = (fullscreen ? Window.FullScreen : Window.Windowed)

    menuBar: WindowMenu { }

    property real normalizedWindowScale: 1024 / ((0.5 * width + 0.5 * height))

    color: "#00000000"

    title: terminalTabs.currentTitle

    Action {
        id: fullscreenAction
        text: qsTr("Fullscreen")
        enabled: !appSettings.isMacOS
        shortcut: StandardKey.FullScreen
        onTriggered: fullscreen = !fullscreen
        checkable: true
        checked: fullscreen
    }
    Action {
        id: borderlessAction
        text: qsTr("Borderless Window")
        enabled: appSettings.isWindows
        checkable: true
        checked: appSettings.borderlessWindow
        onTriggered: appSettings.borderlessWindow = !appSettings.borderlessWindow
    }
    Action {
        id: newWindowAction
        text: qsTr("New Window")
        shortcut: appSettings.isMacOS ? "Meta+N" : "Ctrl+Shift+N"
        onTriggered: appRoot.createWindow()
    }
    Action {
        id: quitAction
        text: qsTr("Quit")
        shortcut: appSettings.isMacOS ? StandardKey.Close : "Ctrl+Shift+Q"
        onTriggered: terminalWindow.close()
    }
    Action {
        id: showsettingsAction
        text: qsTr("Settings")
        onTriggered: {
            settingsWindow.profileMode = false
            settingsWindow.show()
            settingsWindow.requestActivate()
            settingsWindow.raise()
        }
    }
    Action {
        id: showProfilesAction
        text: qsTr("Edit Profiles…")
        onTriggered: {
            settingsWindow.profileMode = true
            settingsWindow.show()
            settingsWindow.requestActivate()
            settingsWindow.raise()
        }
    }
    Action {
        id: copyAction
        text: qsTr("Copy")
        shortcut: appSettings.isMacOS ? StandardKey.Copy : "Ctrl+Shift+C"
    }
    Action {
        id: pasteAction
        text: qsTr("Paste")
        shortcut: appSettings.isMacOS ? StandardKey.Paste : "Ctrl+Shift+V"
    }
    Action {
        id: zoomIn
        text: qsTr("Zoom In")
        shortcut: StandardKey.ZoomIn
        onTriggered: appSettings.incrementScaling()
    }
    Action {
        id: zoomOut
        text: qsTr("Zoom Out")
        shortcut: StandardKey.ZoomOut
        onTriggered: appSettings.decrementScaling()
    }
    Action {
        id: showAboutAction
        text: qsTr("About")
        onTriggered: {
            aboutDialog.show()
            aboutDialog.requestActivate()
            aboutDialog.raise()
        }
    }
    Action {
        id: newTabAction
        text: qsTr("New Tab")
        shortcut: appSettings.isMacOS ? "Meta+T" : "Ctrl+Shift+T"
        onTriggered: terminalTabs.addTab()
    }
    Action {
        id: closeTabAction
        text: qsTr("Close Tab")
        shortcut: appSettings.isMacOS ? "Meta+W" : "Ctrl+Shift+W"
        onTriggered: terminalTabs.closeTab(terminalTabs.currentIndex)
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+1" : "Alt+1"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 0) terminalTabs.currentIndex = 0
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+2" : "Alt+2"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 1) terminalTabs.currentIndex = 1
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+3" : "Alt+3"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 2) terminalTabs.currentIndex = 2
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+4" : "Alt+4"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 3) terminalTabs.currentIndex = 3
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+5" : "Alt+5"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 4) terminalTabs.currentIndex = 4
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+6" : "Alt+6"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 5) terminalTabs.currentIndex = 5
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+7" : "Alt+7"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 6) terminalTabs.currentIndex = 6
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+8" : "Alt+8"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 7) terminalTabs.currentIndex = 7
    }
    Shortcut {
        sequence: appSettings.isMacOS ? "Meta+9" : "Alt+9"
        context: Qt.WindowShortcut
        onActivated: if (terminalTabs.count > 8) terminalTabs.currentIndex = 8
    }
    TerminalTabs {
        id: terminalTabs
        width: parent.width
        height: (parent.height + Math.abs(y))
    }
    // Frameless windows have no native resize border. Keep the hit area narrow
    // so terminal text selection and tab controls remain usable.
    Item {
        id: borderlessControls
        anchors.fill: parent
        z: 1000
        visible: appSettings.isWindows && appSettings.borderlessWindow
                 && terminalWindow.visibility === Window.Windowed

        readonly property int edgeSize: 7

        DragHandler {
            target: null
            acceptedButtons: Qt.LeftButton
            acceptedModifiers: Qt.AltModifier
            onActiveChanged: if (active) terminalWindow.startSystemMove()
        }

        Repeater {
            model: [
                { edges: Qt.TopEdge | Qt.LeftEdge, cursor: Qt.SizeFDiagCursor, x: 0, y: 0, w: 1, h: 1 },
                { edges: Qt.TopEdge | Qt.RightEdge, cursor: Qt.SizeBDiagCursor, x: 2, y: 0, w: 1, h: 1 },
                { edges: Qt.BottomEdge | Qt.LeftEdge, cursor: Qt.SizeBDiagCursor, x: 0, y: 2, w: 1, h: 1 },
                { edges: Qt.BottomEdge | Qt.RightEdge, cursor: Qt.SizeFDiagCursor, x: 2, y: 2, w: 1, h: 1 },
                { edges: Qt.TopEdge, cursor: Qt.SizeVerCursor, x: 1, y: 0, w: 2, h: 1 },
                { edges: Qt.BottomEdge, cursor: Qt.SizeVerCursor, x: 1, y: 2, w: 2, h: 1 },
                { edges: Qt.LeftEdge, cursor: Qt.SizeHorCursor, x: 0, y: 1, w: 1, h: 2 },
                { edges: Qt.RightEdge, cursor: Qt.SizeHorCursor, x: 2, y: 1, w: 1, h: 2 }
            ]
            delegate: MouseArea {
                required property var modelData
                readonly property int border: borderlessControls.edgeSize
                x: modelData.x === 0 ? 0 : modelData.x === 1 ? border : borderlessControls.width - border
                y: modelData.y === 0 ? 0 : modelData.y === 1 ? border : borderlessControls.height - border
                width: modelData.w === 1 ? border : borderlessControls.width - 2 * border
                height: modelData.h === 1 ? border : borderlessControls.height - 2 * border
                cursorShape: modelData.cursor
                onPressed: terminalWindow.startSystemResize(modelData.edges)
            }
        }
    }
    Loader {
        anchors.centerIn: parent
        active: appSettings.showTerminalSize
        sourceComponent: SizeOverlay {
            z: 3
            terminalSize: terminalTabs.terminalSize
        }
    }
    onClosing: {
        appSettings.windowWidth = normalWidth
        appSettings.windowHeight = normalHeight
        appRoot.closeWindow(terminalWindow)
    }
}
