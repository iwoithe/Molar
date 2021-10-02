import QtQuick
// TODO: Create my own widgets
import QtQuick.Controls
import QtQuick.Layouts

import com.kdab.dockwidgets 1.0 as KDDW

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: qsTr("Molar")

    KDDW.MainWindowLayout {
        anchors.fill: parent

        uniqueName: "molarLayout"

        KDDW.DockWidget {
            id: filesDock
            uniqueName: "filesDock"

            title: qsTr("Files")

            ColumnLayout {
                anchors.fill: parent

                TextField {
                    Layout.fillWidth: true
                    placeholderText: qsTr("Filter files...")
                }
            }
        }

        Component.onCompleted: {
            addDockWidget(filesDock, KDDW.KDDockWidgets.Location_OnLeft);
        }
    }
}
