import QtQuick 2.0
Item {
    id: root
    property string img_normal: ""
    property string name: ""
    property alias img_source: itemImg.source
    Image{
        id:itemImg
        anchors.fill: parent
        source: img_normal
        z:0
    }
    Text{
        id:itemName
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: name
        color: "#fff"
        font.pixelSize: 36
        anchors.topMargin: 380
        z:1
    }
}
