import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import MenuItemList 1.0
import "./JS/Utility.js" as Utility
import SongList 1.0

Window {
    id: appWindow
    width: 1920
    height: 1200
    visible: true
    title: qsTr("Home Application")

    property bool displayBack: false

    SonglistModel{
        id:songListModel
        list: songList
    }

    Image {
        anchors.fill: parent
        id: bg
        source: "qrc:/Img/bg_full.png"
    }
    Header{
        id:header
        anchors.left: parent.left
        anchors.right: parent.right
        isDisplay: displayBack
        onBackClicked:{
            appStackView.pop();
            displayBack = false;
        }
    }
    StackView{
        id:appStackView
        width: 1920
        height:1096
        anchors.top: header.bottom
        initialItem: Component{
            id:root
            Rectangle{
                width: 1920
                height:1096
                color: "#00000000"
                WidgetArea{
                    id:widgetArea
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
                MenuArea{
                    id:menuArea
                    anchors.top: widgetArea.bottom
                    anchors.left: widgetArea.left
                    anchors.right: widgetArea.right
                }
            }
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }


}
