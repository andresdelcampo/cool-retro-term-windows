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
import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQml 2.0

import "Components"

ColumnLayout {
    GroupBox {
        Layout.fillWidth: true
        Layout.fillHeight: true
        title: qsTr("Miscellaneous")
        padding: appSettings.defaultMargin

        ColumnLayout {
            anchors.fill: parent
            RowLayout {
                visible: appSettings.isWindows
                Label { text: qsTr("Startup shell") }
                ComboBox {
                    Layout.fillWidth: true
                    enabled: !appSettings.useCustomCommand
                    model: [qsTr("PowerShell (automatic)"), qsTr("Command Prompt"), qsTr("WSL (default distribution)")]
                    currentIndex: appSettings.windowsShell === "cmd" ? 1 : appSettings.windowsShell === "wsl" ? 2 : 0
                    onActivated: appSettings.windowsShell = index === 1 ? "cmd" : index === 2 ? "wsl" : "default"
                }
            }
            Label {
                visible: appSettings.isWindows
                text: qsTr("Shell changes apply to new sessions. WSL requires an installed distribution.")
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }
            CheckBox {
                id: useCustomCommand
                text: qsTr("Use custom command instead of shell at startup")
                checked: appSettings.useCustomCommand
                onCheckedChanged: appSettings.useCustomCommand = checked
            }
            TextField {
                id: customCommand
                Layout.fillWidth: true
                text: appSettings.customCommand
                enabled: useCustomCommand.checked
                onEditingFinished: appSettings.customCommand = text

                // Save text even if user forgets to press enter or unfocus
                function saveSetting() {
                    appSettings.customCommand = text
                }
                Component.onCompleted: settings_window.closing.connect(
                                           saveSetting)
            }
            RowLayout {
                Layout.fillWidth: true
                Label { text: qsTr("Font scaling") }
                Slider {
                    id: fontScalingChanger
                    Layout.fillWidth: true
                    onValueChanged: appSettings.fontScaling = value
                    value: appSettings.fontScaling
                    stepSize: 0.05
                    from: appSettings.minimumFontScaling
                    to: appSettings.maximumFontScaling
                }
                SizedLabel { text: Math.round(fontScalingChanger.value * 100) + "%" }
            }
            CheckBox {
                id: showMenubar
                text: appSettings.isWindows && appSettings.borderlessWindow
                      ? qsTr("Show Menu Bar (hidden in borderless mode)")
                      : qsTr("Show Menu Bar")
                enabled: !appSettings.isMacOS && !(appSettings.isWindows && appSettings.borderlessWindow)
                checked: appSettings.isWindows ? appSettings.showWindowsMenubar : appSettings.showMenubar
                onClicked: {
                    if (appSettings.isWindows)
                        appSettings.showWindowsMenubar = checked
                    else
                        appSettings.showMenubar = checked
                }
            }
        }
    }

    GroupBox {
        title: qsTr("Performance")
        Layout.fillWidth: true
        Layout.fillHeight: true
        padding: appSettings.defaultMargin
        GridLayout {
            anchors.fill: parent
            columns: 4

            Label {
                text: qsTr("Effects FPS")
            }
            Slider {
                Layout.fillWidth: true
                Layout.columnSpan: 2
                id: effectsFpsSlider
                onValueChanged: appSettings.effectsFrameSkip = Math.round(value)
                stepSize: 1
                enabled: true
                from: 5
                to: 1
                value: appSettings.effectsFrameSkip
            }

            SizedLabel {
                text: Math.round(100 / Math.max(1, Math.round(effectsFpsSlider.value))) + "%"
            }
            Label {
                text: qsTr("Texture Quality")
            }
            Slider {
                id: txtslider
                Layout.fillWidth: true
                Layout.columnSpan: 2
                onValueChanged: appSettings.windowScaling = value
                stepSize: 0.05
                enabled: true
                from: 0.25
                value: appSettings.windowScaling
            }
            SizedLabel {
                text: Math.round(txtslider.value * 100) + "%"
            }

            Label {
                text: qsTr("Bloom Quality")
            }
            Slider {
                Layout.fillWidth: true
                Layout.columnSpan: 2
                id: bloomSlider
                onValueChanged: appSettings.bloomQuality = value
                stepSize: 0.05
                enabled: true
                from: 0.25
                value: appSettings.bloomQuality
            }
            SizedLabel {
                text: Math.round(bloomSlider.value * 100) + "%"
            }

            Label {
                text: qsTr("BurnIn Quality")
            }
            Slider {
                Layout.fillWidth: true
                id: burnInSlider
                Layout.columnSpan: 2
                onValueChanged: appSettings.burnInQuality = value
                stepSize: 0.05
                enabled: true
                from: 0.25
                value: appSettings.burnInQuality
            }
            SizedLabel {
                text: Math.round(burnInSlider.value * 100) + "%"
            }
        }
    }
}
