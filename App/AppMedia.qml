import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.8
import SongList 1.0
import '../Component'
import '../JS/Utility.js' as Utility
Item {
    id: appMedia
    width: 1920
    height: 1096
    signal onClickRepeat();
    signal onClickShuffle();

    function changeIndex(index){
        if(mediaPlaylist.currentIndex <= mediaPlaylist.count-1){
            mediaPlaylist.currentIndex = index;
        }else{
            songList.stop();
        }
    }

//    Component.onCompleted: {
//        songPlayerList.currentIndexChanged.connect(changeIndex);
//        songPlayer.play();
//    }


    //Backgroud of Application
    Image {
        id: backgroud
        anchors.fill: parent
        source: "qrc:/Img/Media/background.png"
    }
    //Header
    Image {
        id: headerItem
        source: "qrc:/Img/Media/title.png"
        Text {
            id: headerTitleText
            text: qsTr("Media Player")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }
    }
    //Playlist
    Image {
        id: playList_bg
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        source: "qrc:/Img/Media/playlist.png"
        opacity: 0.2
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: playList_bg
        model: SonglistModel{
            list: songList
        }
        clip: true
        spacing: 2
        currentIndex: 0
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 675
                height: 193
                source: "qrc:/Img/Media/playlist.png"
                opacity: 0.5
            }
            Text {
                text: model.title
                anchors.fill: parent
                anchors.leftMargin: 70
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pixelSize: 32
            }
            onClicked: {
                mediaPlaylist.currentIndex = index;
                songList.playIndex(mediaPlaylist.currentIndex);
            }
            onPressed: {
                playlistItem.source = "qrc:/Img/Media/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Img/Media/playlist.png";
            }
            onExited: {
                playlistItem.source = "qrc:/Img/Media/playlist.png";
            }
            onCanceled: {
                playlistItem.source = "qrc:/Img/Media/playlist.png";
            }
        }
        highlight: Image {
            source:"qrc:/Img/Media/playlist_item.png"
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Img/Media/playing.png"
            }
        }
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            anchors.top: mediaPlaylist.top
            anchors.left: mediaPlaylist.right
            anchors.bottom: mediaPlaylist.bottom
        }
        onCurrentItemChanged: {
            album_art_view.currentIndex = currentIndex;
        }
    }
    //Media Info
    Text {
        id: audioTitle
        anchors.top: headerItem.bottom
        anchors.topMargin: 20
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
        text: mediaPlaylist.currentItem !=null ?mediaPlaylist.currentItem.myData.title:""
        color: "white"
        font.pixelSize: 36
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 20
        text: mediaPlaylist.currentItem !=null ?mediaPlaylist.currentItem.myData.artist:""
        color: "white"
        font.pixelSize: 32
    }
    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
    Text {
        id: audioCount
        anchors.top: headerItem.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: mediaPlaylist.count
        color: "white"
        font.pixelSize: 36
    }
    Image {
        anchors.top: headerItem.bottom
        anchors.topMargin: 23
        anchors.right: audioCount.left
        anchors.rightMargin: 10
        source: "qrc:/Img/Media/music.png"
    }

    Component {
        id: appDelegate
        Item {
            width: 400; height: 400
            scale: PathView.iconScale

            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20; anchors.horizontalCenter: parent.horizontalCenter
                source: albumCover
            }

            MouseArea {
                anchors.fill: parent
                onClicked: album_art_view.currentIndex = index
            }
        }
    }

    PathView {
        id: album_art_view
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 50
        anchors.top: headerItem.bottom
        anchors.topMargin: 300
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: songListModel
        delegate: appDelegate
        pathItemCount: 3
        path: Path {
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 550; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 1100; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex = currentIndex
        }
    }
    //Progress
    function str_pad_left(string,pad,length) {
        return (new Array(length+1).join(pad)+string).slice(-length);
    }

    function getTime(time){
        time = time/1000
        var minutes = Math.floor(time / 60);
        var seconds = Math.floor(time - minutes * 60);

        return str_pad_left(minutes,'0',2)+':'+str_pad_left(seconds,'0',2);
    }

    Text {
        id: currentTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 250
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 120
        text: songList.convertTime(songPlayer.position)
        color: "white"
        font.pixelSize: 24
    }
    Slider{
        id: progressBar
        width: 816
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 245
        anchors.left: currentTime.right
        anchors.leftMargin: 20
        from: 0
        to: 1
        value: songPlayer.position / songPlayer.duration
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            source: "qrc:/Img/Media/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/Img/Media/center_point.png"
            }
        }
        onMoved: {
            if (songPlayer.seekable){
                songPlayer.setPosition(value * songPlayer.duration)
            }
        }
    }
    Text {
        id: totalTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 250
        anchors.left: progressBar.right
        anchors.leftMargin: 20
        text: songList.convertTime(songPlayer.duration)
        color: "white"
        font.pixelSize: 24
    }
    //Media control
    SwitchButton {
        id: shuffer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.left: mediaPlaylist.right
        anchors.leftMargin: 120
        icon_off: "qrc:/Img/Media/shuffle.png"
        icon_on: "qrc:/Img/Media/shuffle-1.png"
        status: songList.getIsShuffle()
        onClicked: {
            root.onClickShuffle();
            shuffer.status = songList.getIsShuffle();
        }
    }
    ButtonControl {
        id: prev
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.left: shuffer.right
        anchors.leftMargin: 220
        icon_default: "qrc:/Img/Media/prev.png"
        icon_pressed: "qrc:/Img/Media/hold-prev.png"
        icon_released: "qrc:/Img/Media/prev.png"
        onClicked: {
            songList.prev();
            mediaPlaylist.currentIndex = songList.getMediaIndex();
        }
    }
    ButtonControl {
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.left: prev.right
        icon_default: songPlayer.state === MediaPlayer.PlayingState  ?  "qrc:/Img/Media/pause.png" : "qrc:/Img/Media/play.png"
        icon_pressed: songPlayer.state === MediaPlayer.PlayingState ?  "qrc:/Img/Media/hold-pause.png" : "qrc:/Img/Media/hold-play.png"
        icon_released: songPlayer.state === MediaPlayer.PlayingState ?  "qrc:/Img/Media/pause.png" : "qrc:/Img/Media/play.png"
        onHandlePress: {
            songList.play();
        }
    }
    ButtonControl {
        id: next
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.left: play.right
        icon_default: "qrc:/Img/Media/next.png"
        icon_pressed: "qrc:/Img/Media/hold-next.png"
        icon_released: "qrc:/Img/Media/next.png"
        onClicked: {
            songList.next();
            mediaPlaylist.currentIndex = songList.getMediaIndex();
        }
    }
    SwitchButton {
        id: repeater
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.right: totalTime.right
        icon_on: "qrc:/Img/Media/repeat1_hold.png"
        icon_off: "qrc:/Img/Media/repeat.png"
        status: songList.getIsRepeat()
        onClicked: {
            root.onClickRepeat();
            repeater.status = songList.getIsRepeat();
        }
    }
}
