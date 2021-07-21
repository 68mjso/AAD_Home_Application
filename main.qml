import QtQuick 2.14
import QtQuick.Window 2.14

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
    Header{}
}
