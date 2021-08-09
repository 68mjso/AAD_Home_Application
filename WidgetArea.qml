import QtQuick 2.0
import QtQuick.Controls 2.5
import "./Component"
import "./Widget"

Rectangle {
    width: 1920
    height: 570
    color: "#00000000"
    function openApplication(url){
        appWindow.displayBack = true;
        appStackView.push([url]);
    }
    Widget{
        id:mapWidget
        anchors.left: parent.left
        anchors.topMargin: 12
        anchors.leftMargin: 12
        isFocus: appWindow.focusItem == 1
        Map{}
        onClickedWidget:{
            openApplication("qrc:/App/AppMap.qml");
        }
    }
    Widget{
        id:climateWidget
        anchors.left: mapWidget.right
        anchors.topMargin: 12
        anchors.leftMargin: 12
        isFocus: appWindow.focusItem == 2
        Climate{}
        onClickedWidget:{
            openApplication("qrc:/App/AppClimate.qml");
        }
    }
    Widget{
        id:mediaWidget
        anchors.left: climateWidget.right
        anchors.topMargin: 12
        anchors.leftMargin: 12
        isFocus: appWindow.focusItem == 3
        Media{}
        onClickedWidget:{
            openApplication("qrc:/App/AppMedia.qml");
        }
    }
}
