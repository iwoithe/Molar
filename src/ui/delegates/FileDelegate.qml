import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import thirdparty.opendataio


ItemDelegate {
    id: root
    width: parent.width
    checkable: true

    property var model: root.ListView.view.model

    onClicked: ListView.view.currentIndex = index

    signal updateData
    onUpdateData: updateAxesModel()

    contentItem: ColumnLayout {
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            Label {
                text: path
            }

            Item {
                Layout.fillWidth: true
            }

            RoundButton {
                id: deleteFileButton
                width: 48
                height: 48
                text: qsTr("-")
                onClicked: root.model.remove(root.ListView.view.currentIndex, 1)
            }
        }

        Button {
            Layout.fillWidth: true
            enabled: false
            visible: root.checked
            text: qsTr("Graph type")
        }

        RowLayout {
            Layout.fillWidth: true
            visible: root.checked

            Label {
                text: qsTr("Skip rows:")
            }

            SpinBox {
                id: skipRowsSpin
                Layout.fillWidth: true
                from: 0
                value: 0
            }
        }

        RowLayout {
            Layout.fillWidth: true
            visible: root.checked

            Label {
                text: qsTr("Header rows:")
            }

            SpinBox {
                id: headerRowsSpin
                Layout.fillWidth: true
                from: 0
                value: 0
                onValueChanged: {
                    root.model.setProperty(index, "header_rows", headerRowsSpin.value)
                    root.updateData()
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            visible: root.checked
            
            Label {
                text: qsTr("Unit row:")
            }

            SpinBox {
                id: unitRowSpin
                Layout.fillWidth: true
                from: 0
                value: 0
            }
        }

        RowLayout {
            Layout.fillWidth: true
            visible: root.checked
            CheckBox {
                id: skipBlankLinesCheck
                Layout.fillWidth: true
                text: qsTr("Skip blank lines")
                checked: true
            }
        }

        Button {
            id: configXAxesButton
            Layout.fillWidth: true
            visible: root.checked
            text: qsTr("Configure X Axes")
            onClicked: xAxesPopup.opened ? xAxesPopup.close() : xAxesPopup.open()

            Popup {
                id: xAxesPopup
                y: parent.height
                width: parent.width
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                contentItem: ColumnLayout {
                    RowLayout {
                        Layout.fillWidth: true

                        TextField {
                            Layout.fillWidth: true
                            placeholderText: qsTr("Filter columns...")
                        }

                        Button {
                            text: qsTr("...")
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        ListView {
                            model: xAxesModel
                            delegate: AxisDelegate {}
                        }
                    }
                }
            }
        }

        Button {
            id: configYAxesButton
            Layout.fillWidth: true
            visible: root.checked
            text: qsTr("Configure Y Axes")
            onClicked: yAxesPopup.opened ? yAxesPopup.close() : yAxesPopup.open()

            Popup {
                id: yAxesPopup
                y: parent.height
                width: parent.width
                focus: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                contentItem: ColumnLayout {
                    RowLayout {
                        Layout.fillWidth: true

                        TextField {
                            Layout.fillWidth: true
                            placeholderText: qsTr("Filter columns...")
                        }

                        Button {
                            text: qsTr("...")
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        ListView {
                            model: yAxesModel
                            delegate: AxisDelegate {}
                        }
                    }
                }
            }
        }
    }

    function updateAxesModel() {
        // Get the data
        // var headers = CSV.parse(["headers", path, skip_rows, header_rows])
        var data = CSV.parse(["data", path, skip_rows, header_rows])
        for (var i = 0; i < data.length; i++) {
            console.log(data[i])
        }
        console.log("\n-------------------------------\n")
        // The x-axes model
        // The y-axes model
    }

    ListModel {
        id: xAxesModel
    }

    ListModel {
        id: yAxesModel

        ListElement {
            index: 0
            name: "Panel Power"
            unit: "Watts"
        }

        ListElement {
            index: 1
            name: "Motor Input"
            unit: "Watts"
        }
    }
}
