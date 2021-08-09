import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Item{
    id:widgetMedia
    z:0
    anchors.fill: parent
    Image{
        id:mediaBg
        source: myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
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
        source: myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text{
        id:mediaArtist
        anchors.top: mediaImg.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
        color: "#fff"
        text:myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
    }
    Text{
        id:mediaTitle
        anchors.top: mediaArtist.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 36
        color: "#fff"
        text:myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
    }
    ProgressBar{
        id:mediaSlider
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: mediaTitle.bottom
        width: 500
        value: player.position / player.duration
        contentItem: Rectangle{
            color:'#34e8eb'
            width: mediaSlider.width * player.position / player.duration
        }
    }
}
