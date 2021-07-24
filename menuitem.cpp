#include "menuitem.h"
#include <QVector>

MenuItem::MenuItem(QObject *parent) : QObject(parent)
{
    this->addItem({"First","qrc:/Img/Menu/btn_home_menu_climate_n.png","qrc:/Img/Menu/btn_home_menu_climate_f.png","qrc:/Img/Menu/btn_home_menu_climate_p.png"});
    this->addItem({"Second","qrc:/Img/Menu/btn_home_menu_map_n.png","qrc:/Img/Menu/btn_home_menu_map_f.png","qrc:/Img/Menu/btn_home_menu_map_p.png"});
}

void MenuItem::addItem(Item item)
{
    this->mItems.append(item);
}

QVector<Item> MenuItem::getMenuItem()
{
    return this->mItems;
}
