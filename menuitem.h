#ifndef MENUITEM_H
#define MENUITEM_H

#include <QObject>
#include <QVector>

struct Item{
    QString title;
    QString img_normal;
    QString img_focus;
    QString img_press;
};

class MenuItem : public QObject
{
    Q_OBJECT
public:
    explicit MenuItem(QObject *parent = nullptr);
    void addItem(Item item);
    QVector<Item> getMenuItem();
signals:

private:
    QVector<Item> mItems;

};

#endif // MENUITEM_H
