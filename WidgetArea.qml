import QtQuick 2.0
import QtQuick.Controls 2.5
import "./Component"
import "./Widget"

Item {
    width: 1920
    height: 570
    Widget{
        id:mapWidget
        anchors.left: parent.left
        anchors.topMargin: 12
        anchors.leftMargin: 12
        Map{}
    }
    Widget{
        id:climateWidget
        anchors.left: mapWidget.right
        anchors.topMargin: 12
        anchors.leftMargin: 12
        Climate{}
    }
    Widget{
        id:mediaWidget
        anchors.left: climateWidget.right
        anchors.topMargin: 12
        anchors.leftMargin: 12
        Media{}
    }
}
