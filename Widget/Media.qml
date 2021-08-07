import QtQuick 2.0
import QtQuick.Controls 2.5
import SongList 1.0
import "../JS/Utility.js" as Utility

Item{
    id:widgetMedia
    z:0
    anchors.fill: parent
    Component.onCompleted: {
      console.log(songListModel.data(songPlayerList.currentIndex,0))
    }

    Image{
        id:mediaBg
        source: appMedia.album_art_view.source
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
        source: songList.getCurrentSong().albumCover
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text{
        id:mediaArtist
        anchors.top: mediaImg.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
        color: "#fff"
        text:songList.getCurrentSong().artist
    }
    Text{
        id:mediaTitle
        anchors.top: mediaArtist.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 36
        color: "#fff"
        text:songList.getCurrentSong().title
    }
    ProgressBar{
        id:mediaSlider
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: mediaTitle.bottom
        width: 500
        value: songPlayer.position / songPlayer.duration
    }
}
