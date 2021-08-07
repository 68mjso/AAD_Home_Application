#include "song.h"
#include <QMediaService>
#include <QMediaPlaylist>
#include <QMediaMetaData>
#include <QObject>
#include <QFileInfo>
#include <QTime>
#include <QDir>
#include <QStandardPaths>
#include <QtMath>

Song::Song(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);
    m_player->setPlaylist(m_playlist);
    this->open();
    if (!m_playlist->isEmpty()) {
        m_playlist->setCurrentIndex(0);
    }
    this->isShuffle = false;
    this->isRepeat = false;
    m_player->setVolume(20);
    m_playlist->setPlaybackMode(QMediaPlaylist::Sequential);
}

void Song::open()
{
    QDir directory(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);
    QFileInfoList musics = directory.entryInfoList(QStringList() << "*.mp3",QDir::Files);
    QList<QUrl> urls;
    for (int i = 0; i < musics.length(); i++){
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }
    addToPlaylist(urls);
}

QMediaPlayer *Song::player() const
{
    return m_player;
}

void Song::setPlayer(QMediaPlayer *newPlayer)
{
    m_player = newPlayer;
}

QMediaPlaylist *Song::playlist() const
{
    return m_playlist;
}

void Song::setPlaylist(QMediaPlaylist *newPlaylist)
{
    m_playlist = newPlaylist;
}

bool Song::getIsRepeat() const
{
    return isRepeat;
}

void Song::setIsRepeat(bool newIsRepeat)
{
    isRepeat = newIsRepeat;
}

bool Song::getIsShuffle() const
{
    return isShuffle;
}

void Song::setIsShuffle(bool newIsSuffle)
{
    isShuffle = newIsSuffle;
}

void Song::play()
{
    if(m_player->state() == QMediaPlayer::PlayingState){
        m_player->pause();
    }else{
        m_player->play();
    }

}

void Song::next()
{
    if(m_playlist->currentIndex() < mItems.length()-1 || isShuffle){
        m_playlist->next();
//        this->playIndex(m_playlist->currentIndex());
    }

}

void Song::prev()
{
    if(m_playlist->currentIndex() > 0){
        m_playlist->previous();
//        this->playIndex(m_playlist->currentIndex());
    }

}

void Song::stop()
{
    m_player->stop();
}

void Song::playIndex(qint64 index)
{
    m_playlist->setCurrentIndex(index);
}

QString Song::convertTime(qint64 time)
{
    time = time/1000;
    int minute = qFloor(time/60);
    int second = qFloor(time - minute * 60);
    QString secondStr = second < 10 ? ("0" + QString::number(second,10)):QString::number(second,10);
    QString minuteStr = minute < 10 ? ("0" + QString::number(minute,10)):QString::number(minute,10);
    return minuteStr + ":" + secondStr;
}

int Song::getMediaIndex()
{
    return this->m_playlist->currentIndex();
}



void Song::switchRepeat()
{
    if(this->isRepeat){
        this->isRepeat = false;
        if(isShuffle){
            m_playlist->setPlaybackMode(QMediaPlaylist::Random);
        }else{
            m_playlist->setPlaybackMode(QMediaPlaylist::Sequential);
        }
    }else{
        this->isRepeat = true;
        m_playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
}

void Song::switchShuffle()
{
    if(this->isShuffle){
        this->isShuffle = false;
        if(this->isRepeat){
            m_playlist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        }else{
            m_playlist->setPlaybackMode(QMediaPlaylist::Sequential);
        }
    }else{
        this->isShuffle = true;
        if(!this->isRepeat){
            m_playlist->setPlaybackMode(QMediaPlaylist::Random);
        }
    }
}

void Song::addToPlaylist(const QList<QUrl> &urls)
{
    for (auto &url: urls) {
        m_playlist->addMedia(url);
        TagLib::FileRef f(url.path().toStdString().c_str());
        TagLib::Tag *tag = f.tag();
        this->addSong({QString::fromWCharArray(tag->title().toCWString()),
                       QString::fromWCharArray(tag->artist().toCWString()),url.toDisplayString(),
                       getAlbumArt(url)});
    }
}

void Song::addSong(SongItem item)
{
    this->mItems.append(item);
}

QVector<SongItem> Song::items() const
{
    return mItems;
}

QString Song::getAlbumArt(QUrl url)
{
    static const char *IdPicture = "APIC" ;
    TagLib::MPEG::File mpegFile(url.path().toStdString().c_str());
    TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList Frame ;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;

    FILE *jpegFile;
    jpegFile = fopen(QString(url.fileName()+".jpg").toStdString().c_str(),"wb");

    if ( id3v2tag )
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty() )
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
            {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(*it) ;
                //  if ( PicFrame->type() ==
                //TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if ( SrcImage )
                    {
                        memcpy ( SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, jpegFile);
                        fclose(jpegFile);
                        free( SrcImage ) ;
                        return QUrl::fromLocalFile(url.fileName()+".jpg").toDisplayString();
                    }

                }
            }
        }
    }
    else
    {
        qDebug() <<"id3v2 not present";
        return "qrc:/Img/Media/album_art.png";
    }
    return "qrc:/Img/Media/album_art.png";
}
