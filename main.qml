import QtQuick 2.14
import QtQuick.Window 2.14
import "./JS/Utility.js" as Utility

Window {
    width: 1920
    height: 1200
    visible: true
    title: qsTr("Home Application")
    Image {
        anchors.fill: parent
        id: bg
        source: "qrc:/Img/bg_full.png"
    }
    Header{
        id:header
        anchors.left: parent.left
        anchors.right: parent.right
    }
    WidgetArea{
        id:widgetArea
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
