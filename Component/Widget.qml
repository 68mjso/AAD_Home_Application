import QtQuick 2.0

MouseArea {
    id:widget
    width: 624
    height: 546
    property string imgSrc: ""
    property bool isFocus: false
    signal clickedWidget();
    Image{
        z:1
        id:widget_n
        anchors.fill: parent
        source: isFocus?"qrc:/Img/Widget/bg_widget_f.png" :imgSrc
    }

    onPressed: {
        imgSrc = "qrc:/Img/Widget/bg_widget_p.png"
    }

    onReleased:{
        imgSrc = ""
    }

    onClicked: {
        clickedWidget();
    }
}
