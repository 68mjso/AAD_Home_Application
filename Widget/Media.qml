import QtQuick 2.0
import QtQuick.Controls 2.5

Item{
    z:0
    anchors.fill: parent
    Image{
        id:mediaBg
        source: "qrc:/Img/Media/cover_art.jpg"
        anchors.fill: parent
        opacity: 0.3
    }
    Text{
        id: deviceLabel
        anchors.topMargin: 42
        text: "USB Music"
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#fff"
    }
    Image{
        id:mediaImg
        anchors.top: deviceLabel.bottom
        anchors.topMargin: 40
        width: 250
        height: 250
        source: "qrc:/Img/Media/cover_art.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text{
        id:mediaArtist
        anchors.top: mediaImg.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
        color: "#fff"
        text:"Artist"
    }
    Text{
        id:mediaTitle
        anchors.top: mediaArtist.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 36
        color: "#fff"
        text:"Title"
    }
    ProgressBar{
        id:mediaSlider
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: mediaTitle.bottom
        width: 500
        value: 0.5
    }
}
