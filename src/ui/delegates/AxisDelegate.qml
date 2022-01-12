import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    id: root
    width: root.ListView.view.width

    signal toggled

    property var model: root.ListView.view.model
    
    contentItem: RowLayout {
        spacing: 0

        CheckBox {
            id: checkBox
            Layout.fillWidth: true
            // TODO: Rename "name" to "column_name"?
            text: qsTr(name)
            onCheckedChanged: {
                root.model.setProperty(index, "checked", checkBox.checked)
                root.toggled()
            }
        }
    }    
}
