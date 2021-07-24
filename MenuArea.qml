import QtQuick 2.0
import MenuItemList 1.0
import "./Component"

Rectangle {
    width: 1920
    height:526
    color: "#00000000"
    ListView{
        anchors.leftMargin: 12
        anchors.fill: parent
        model: MenuItemModel{
            list: menuItem
        }
        orientation: Qt.Horizontal
        spacing:12
        delegate: MenuItem{
            img_normal:normal_img
            img_focus:focus_img
            img_press:press_img
        }
    }
}
