#ifndef SONG_H
#define SONG_H

#include <QObject>
#include <QVector>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <taglib/tag.h>
#include <taglib/fileref.h>
#include <taglib/id3v2tag.h>
#include <taglib/mpegfile.h>
#include <taglib/id3v2frame.h>
#include <taglib/id3v2header.h>
#include <taglib/attachedpictureframe.h>


struct SongItem
{
    QString title;
    QString artist;
    QString source;
    QString albumCover;
};


class Song : public QObject
{
    Q_OBJECT
public:
    explicit Song(QObject *parent = nullptr);

    void addSong(SongItem item);

    QVector<SongItem> items() const;

    QString getAlbumArt(QUrl url);

    void addToPlaylist(const QList<QUrl> &urls);

    void open();

    QMediaPlayer *player() const;
    void setPlayer(QMediaPlayer *newPlayer);

    QMediaPlaylist *playlist() const;
    void setPlaylist(QMediaPlaylist *newPlaylist);

    Q_INVOKABLE bool getIsRepeat() const;
    void setIsRepeat(bool newIsRepeat);

    Q_INVOKABLE bool getIsShuffle() const;
    void setIsShuffle(bool newIsSuffle);

    Q_INVOKABLE void play();
    Q_INVOKABLE void next();
    Q_INVOKABLE void prev();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void playIndex(qint64 index);
    Q_INVOKABLE QString convertTime(qint64 time);

public slots:
    void switchRepeat();
    void switchShuffle();
private:
    QVector<SongItem> mItems;
    QMediaPlayer *m_player = nullptr;
    QMediaPlaylist *m_playlist = nullptr;
    bool isRepeat;
    bool isShuffle;
};

#endif // SONG_H
