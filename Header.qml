import QtQuick 2.0
import QtQuick.Window 2.14
import "./JS/Utility.js" as Utility
Item {
    id:header
    width: 1920
    height: 104
    anchors.left: parent.left

    property string date: Utility.getDate()
    property string time: Utility.getTime()

    property alias isDisplay: firstArea.visible

    signal backClicked();

    //Timer for clock
    Timer{
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            date = Utility.getDate();
            time = Utility.getTime();
        }
    }
    Rectangle{
        id: firstArea
        width: 760
        height: parent.height
        anchors.left: parent.left
        color: "#00000000"
        Image{
            id: btnBack
            source: "qrc:/Img/StatusBar/btn_top_back_n.png"
            MouseArea{
                anchors.fill: parent;
                onPressed: {
                   btnBack.source = "qrc:/Img/StatusBar/btn_top_back_p.png"
                }
                onClicked: {
                    btnBack.source = "qrc:/Img/StatusBar/btn_top_back_n.png"
                    backClicked();
                }
                onCanceled: {
                    btnBack.source = "qrc:/Img/StatusBar/btn_top_back_p.png"
                }
                onReleased: {
                    btnBack.source = "qrc:/Img/StatusBar/btn_top_back_n.png"
                }

            }
        }
    }
    Image{
        id:headDivider
        anchors.left: firstArea.right
        source: "qrc:/Img/StatusBar/status_divider.png"
    }
    Rectangle{
        id: secondArea
        width: 200;
        height: parent.height
        anchors.left: headDivider.right
        color: "#00000000"
        Text{
            id:timeArea
            color: "#fff"
            anchors.centerIn: parent
            text: time
            font.pixelSize: 48
        }
    }
    Image{
        id:midDivider
        anchors.left: secondArea.right
        source: "qrc:/Img/StatusBar/status_divider.png"
    }
    Rectangle{
        id: thirdArea
        width: 200;
        height: parent.height
        anchors.left: midDivider.right
        color: "#00000000"
        Text{
            id:dateArea
            color: "#fff"
            anchors.centerIn: parent
            text: date
            font.pixelSize: 48
        }
    }
    Image{
        anchors.left: thirdArea.right
        id:endDivider
        source: "qrc:/Img/StatusBar/status_divider.png"
    }

}
