import QtQuick
// TODO: Create my own widgets
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCharts

// TODO: Why does this not work?
// import ui.delegates

import com.kdab.dockwidgets 1.0 as KDDW

// TODO: Use node-csv (https://github.com/adaltas/node-csv) as it has more features
// This requires compiling to single .min.js file (see https://www.librehat.com/use-npm-packages-in-qml/)
// TODO: Actually be able to use JS libraries
// import "qrc:/ui/thirdparty/PapaParse/papaparse.js" as PapaLib

import thirdparty.opendataio


ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: qsTr("Molar")

    FileDialog {
        id: filesDialog
        fileMode: FileDialog.OpenFiles
        selectedNameFilter.index: 0
        nameFilters: ["Comma Separated Value files (*.csv *.CSV *.dat *.DAT)"]
        onAccepted: {
            for (var i = 0; i < filesDialog.selectedFiles.length; i++){
                var filePath = filesDialog.selectedFiles[i].toString().replace("file:///", "/");
                
                var data = CSV.parse(["data", filePath]);
                // console.log(data.length);

                filesModel.append({"path": filePath,
                                   "graph_type": "Line Chart",
                                   "skip_rows": 0,
                                   "header_rows": 0});
            }
        }
    }

    KDDW.MainWindowLayout {
        anchors.fill: parent

        uniqueName: "molarLayout"

        KDDW.DockWidget {
            id: filesDock
            uniqueName: "filesDock"

            title: qsTr("Files")

            Pane {
                anchors.fill: parent
                ColumnLayout {
                    anchors.fill: parent
                    Layout.margins: 8

                    TextField {
                        Layout.fillWidth: true
                        placeholderText: qsTr("Filter files...")
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: filesModel
                        delegate: FileDelegate {}
                    }
                }

                RoundButton {
                    id: addFileButton
                    width: 48
                    height: 48
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    text: qsTr("+")
                    onClicked: filesDialog.open()
                }
            }
        }

        KDDW.DockWidget {
            id: graphDock
            uniqueName: "graphDock"

            title: qsTr("Graph")

            Pane {
                anchors.fill: parent
                
                ColumnLayout {
                    anchors.fill: parent
                    Layout.margins: 8

                    RowLayout {
                        Layout.fillWidth: true
                        
                        Label {
                            text: qsTr("File:")
                        }

                        ComboBox {
                            id: currentFileCombo
                            Layout.fillWidth: true
                            model: filesModel
                            textRole: "path"
                        }
                    }

                    Label {
                        visible: currentFileCombo.currentText === "" ? true : false
                        Layout.alignment: Qt.AlignHCenter
                        text: qsTr("To view a graph select a file in the drop down")
                        font.italic: true
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        visible: currentFileCombo.currentText === "" ? true : false
                    }

                    ChartView {
                        title: "Graph"

                        visible: currentFileCombo.currentText === "" ? false : true
                        
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        antialiasing: true

                        LineSeries {
                            name: "LineSeries"
                            XYPoint { x: 0; y: 0 }
                            XYPoint { x: 1.1; y: 2.1 }
                            XYPoint { x: 1.9; y: 3.3 }
                            XYPoint { x: 2.1; y: 2.1 }
                            XYPoint { x: 2.9; y: 4.9 }
                            XYPoint { x: 3.4; y: 3.0 }
                            XYPoint { x: 4.1; y: 3.3 }
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            addDockWidget(filesDock, KDDW.KDDockWidgets.Location_OnLeft);
            addDockWidget(graphDock, KDDW.KDDockWidgets.Location_OnRight);
        }
    }

    ListModel {
        id: filesModel
    }
}
