#ifndef MENUITEMMODEL_H
#define MENUITEMMODEL_H

#include <QAbstractListModel>

class MenuItem;

class MenuItemModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(MenuItem *list READ list WRITE setList);

public:
    explicit MenuItemModel(QObject *parent = nullptr);

    enum Roles {
        TitleRole = Qt::UserRole + 1,
        NormalRole,
        FocusRole,
        PressRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    virtual QHash<int,QByteArray> roleNames () const override;

    MenuItem *list() const;
    void setList(MenuItem *list);

private:
    MenuItem *mList;
};

#endif // MENUITEMMODEL_H
