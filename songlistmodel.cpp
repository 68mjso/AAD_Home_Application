#include "songlistmodel.h"

#include "song.h"

SonglistModel::SonglistModel(QObject *parent)
    : QAbstractListModel(parent)
    ,mList(nullptr)
{
}

int SonglistModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mList)
        return 0;

    // FIXME: Implement me!
    return mList->items().size();
}

QVariant SonglistModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()|| !mList){
        return QVariant();
    }
    const SongItem item = mList->items().at(index.row());
    switch(role){
    case TitleRole:
        return QVariant(item.title);
    case ArtistRole:
        return QVariant(item.artist);
    case SourceRole:
        return QVariant(item.source);
    case AlbumCoverRole:
        return QVariant(item.albumCover);
    }

    // FIXME: Implement me!
    return QVariant();
}

bool SonglistModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mList){
        return false;
    }
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SonglistModel::flags(const QModelIndex &index) const
{
    if (!index.isValid() || !mList)
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> SonglistModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names[ArtistRole] = "artist";
    names[TitleRole] = "title";
    names[SourceRole] = "source";
    names[AlbumCoverRole] = "albumCover";
    return names;
}

Song *SonglistModel::list() const
{
    return mList;
}

void SonglistModel::setList(Song *newSong)
{
    beginResetModel();
    if(mList){
        mList->disconnect(this);
    }
    mList = newSong;
}
