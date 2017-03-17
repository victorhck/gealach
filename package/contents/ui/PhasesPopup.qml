/*
 * Copyright 2017  koffeinfriedhof <koffeinfriedhof@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import "../code/phases.js" as Phases
import "../code/lunacalc.js" as LunaCalc

ColumnLayout {
    id: fullRoot
    Layout.minimumWidth: coll.width
    Layout.minimumHeight: wolf.height + coll.height + btr.height + units.smallSpacing * 2

    /** PROPERTIES **/
    property var displayPhase: LunaCalc.getTodayPhases()

    /** FUNCTIONS **/
    function formatDate(str) {
        if( dateFormat==99 )
            return Qt.formatDateTime(str, dateFormatString)

            return Qt.formatDateTime(str, dateFormat)
    }


    /** ACTIONS **/
    Action {
        id: actionPrev
        text: buttonTextVisible ? i18n("Back") : ""
        shortcut: "Left"
        onTriggered: { displayPhase=LunaCalc.getPreviousPhases() }
        tooltip: i18n("Show previous moon phase. (Key:Left)")
    }
    Action {
        id: actionNext
        text: buttonTextVisible ? i18n("Next") : ""
        shortcut: "Right"
        onTriggered: { displayPhase=LunaCalc.getNextPhases() }
        tooltip: i18n("Show next moon phase. (Key:Right)")
    }
    Action {
        id: actionCurrent
        text: buttonTextVisible ? i18n("Current Phase") : ""
        shortcut: "Up"
        onTriggered: { displayPhase=LunaCalc.getTodayPhases() }
        tooltip: i18n("Show previous phases. (Key:Up)")
    }

    /** CONTENT **/
    Row {
        id: wolf

        visible: currentPhase.number == 14

        height: visible ? coll.height*0.75 : 0
        width: visible ? fullRoot.width : 0

        PlasmaComponents.Label {
            height: wolf.height
            text: i18n("TODAY IS FULL-MOON!");
            color: primaryFontColor
            font.pointSize: theme.defaultFont.pointSize*1.5
        }
        PlasmaCore.IconItem {
            height: wolf.height
            width: height
            source: plasmoid.file("data", "werewolf.png")
        }
    }
    RowLayout {
        id: coll

        Column {
            spacing: units.smallSpacing
            Layout.margins: spacing*2
            PlasmaCore.IconItem { source: plasmoid.file("data", "luna-gskbyte0.svg") }
            PlasmaCore.IconItem { source: plasmoid.file("data", "luna-gskbyte7.svg") }
            PlasmaCore.IconItem { source: plasmoid.file("data", "luna-gskbyte14.svg") }
            PlasmaCore.IconItem { source: plasmoid.file("data", "luna-gskbyte21.svg") }
            PlasmaCore.IconItem { source: plasmoid.file("data", "luna-gskbyte0.svg") }
        }
        Column {
            spacing: units.smallSpacing
            Layout.margins: spacing*2
            PlasmaComponents.Label { text: formatDate(displayPhase[0]); color: primaryFontColor }
            PlasmaComponents.Label { text: formatDate(displayPhase[1]); color: primaryFontColor }
            PlasmaComponents.Label { text: formatDate(displayPhase[2]); color: primaryFontColor }
            PlasmaComponents.Label { text: formatDate(displayPhase[3]); color: primaryFontColor }
            PlasmaComponents.Label { text: formatDate(displayPhase[4]); color: primaryFontColor }
        }
        Column {
            spacing: units.smallSpacing
            Layout.margins: spacing*2
            PlasmaComponents.Label { text: phaseNames[0]; color: secondaryFontColor }
            PlasmaComponents.Label { text: phaseNames[1]; color: secondaryFontColor }
            PlasmaComponents.Label { text: phaseNames[2]; color: secondaryFontColor }
            PlasmaComponents.Label { text: phaseNames[3]; color: secondaryFontColor }
            PlasmaComponents.Label { text: phaseNames[4]; color: secondaryFontColor }
        }
    }
    PlasmaComponents.ButtonRow {
        id: btr

        Layout.alignment: Qt.AlignHCenter
        Layout.margins: units.smallSpacing * 2

        exclusive: false

        PlasmaComponents.Button {
            iconSource: "draw-arrow-back.png"
            action: actionPrev
        }
        PlasmaComponents.Button {
            iconSource: "draw-arrow-up.png"
            action: actionCurrent
        }
        PlasmaComponents.Button {
            iconSource: "draw-arrow-forward.png"
            action: actionNext
        }
    }
}