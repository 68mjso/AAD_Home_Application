#ifndef MENUITEM_H
#define MENUITEM_H

#include <QObject>
#include <QVector>
#include <QtXml>

struct Item{
    QString title;
    QString img_normal;
    QString img_focus;
    QString img_press;
    QString app_url;
};

class MenuItem : public QObject
{
    Q_OBJECT
public:
    explicit MenuItem(QObject *parent = nullptr);
    void addItem(Item item);
    QVector<Item> getMenuItem();
    void setMenuItem(QVector<Item> list);
    Q_INVOKABLE void writeXml(QVariantList list);
    Q_INVOKABLE qint64 getItemCount();
signals:

private:
    QVector<Item> mItems;

};

#endif // MENUITEM_H
