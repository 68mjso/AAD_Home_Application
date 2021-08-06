#ifndef SONGLISTMODEL_H
#define SONGLISTMODEL_H

#include <QAbstractListModel>

class Song;

class SonglistModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(Song *list READ list WRITE setList)

public:
    explicit SonglistModel(QObject *parent = nullptr);

    enum Roles {
        TitleRole = Qt::UserRole + 1,
        ArtistRole,
        SourceRole,
        AlbumCoverRole
    };
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int,QByteArray> roleNames () const override;

    Song *list() const;
    void setList(Song *newSong);

private:
    Song *mList;
};

#endif // SONGLISTMODEL_H
