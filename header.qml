import QtQuick 2.0

Item {
    property string date: ""
    property string time: ""
    function getTime(){
        var currentTime = Date.now();
    }

    MouseArea{
        Image{
            id: btnBack
            source: "qrc:/Img/StatusBar/btn_top_back_n.png"
        }
    }
    Rectangle{
        Text{
            text: date
        }
        Text{
            text: time
        }
    }
}
