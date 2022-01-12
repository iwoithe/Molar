import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    id: root
    width: root.ListView.view.width

    contentItem: RowLayout {
        spacing: 0

        CheckBox {
            Layout.fillWidth: true
            // TODO: Rename "name" to "column_name"?
            text: qsTr(name)
        }
    }    
}
