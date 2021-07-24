#include "menuitemmodel.h"
#include "menuitem.h"

MenuItemModel::MenuItemModel(QObject *parent)
    : QAbstractListModel(parent)
    ,mList(nullptr)
{
}

int MenuItemModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !mList)
        return 0;

    // FIXME: Implement me!
    return mList->getMenuItem().size();
}

bool MenuItemModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!mList){
        return false;
    }
    if(data(index,role)!=value){
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

QVariant MenuItemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    const Item item = mList->getMenuItem().at(index.row());
    switch (role) {
    case TitleRole:
        return QVariant(item.title);
    case NormalRole:
        return QVariant(item.img_normal);
    case FocusRole:
        return QVariant(item.img_focus);
    case PressRole:
        return QVariant(item.img_press);
    }
    // FIXME: Implement me!
    return QVariant();
}

QHash<int, QByteArray> MenuItemModel::roleNames() const
{
    QHash<int,QByteArray> names;
    names[TitleRole] = "title";
    names[NormalRole] = "normal_img";
    names[FocusRole] = "focus_img";
    names[PressRole]="press_img";
    return names;
}

MenuItem *MenuItemModel::list() const
{
    return mList;
}

void MenuItemModel::setList(MenuItem *list)
{
    beginResetModel();
    if(mList){
        mList->disconnect(this);
    }
    mList=list;
}
