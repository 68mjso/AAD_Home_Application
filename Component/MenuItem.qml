import QtQuick 2.0

MouseArea {
    width: 306
    height: 480
    property string img_normal: ""
    property string img_press: ""
    property string img_focus: ""
    Image{
        id:itemImg
        anchors.fill: parent
        source: img_normal
    }
    onPressed: {
        itemImg.source = img_press
    }
    onReleased: {
        itemImg.source = img_normal
    }
    onExited: {
        itemImg.source = img_normal
    }
    onCanceled: {
        itemImg.source = img_normal
    }
}
