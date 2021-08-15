import QtQuick 2.0

Item {
    width: 1920
    height: 1096
    Rectangle{
        width: 500
        height: 500
        color: "#FFF"
        anchors.centerIn: parent
        Image{
            anchors.fill: parent
            source: 'qrc:/Img/clock-png.png'

        }
    }
}
