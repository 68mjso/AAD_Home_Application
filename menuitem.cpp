#include "menuitem.h"
#include <QVector>
#include "xmlreader.h"

MenuItem::MenuItem(QObject *parent) : QObject(parent)
{
    XMLReader reader("config.xml");
    QVector<Item> list = reader.ParseXml();
    setMenuItem(list);
}

void MenuItem::addItem(Item item)
{
    this->mItems.append(item);
}

QVector<Item> MenuItem::getMenuItem()
{
    return this->mItems;
}

void MenuItem::setMenuItem(QVector<Item> list)
{
    this->mItems = list;
}

void MenuItem::writeXml(QVariantList list)
{
    QFile file("config.xml");
    if(!file.open(QIODevice::WriteOnly| QIODevice::Text)){
        qDebug() << "Error write XML File";
        file.close();
        return;
    }
    QDomDocument xml("APPLICATIONS");
    QDomElement root = xml.createElement("APPLICATIONS");
    xml.appendChild(root);

    for(int i=0;i<list.length();i++){
        QVariantList item = qvariant_cast<QVariantList>(list[i]);
        QDomElement tagApp = xml.createElement("APP");
        root.appendChild(tagApp);
        //title
        QDomElement tagTitle = xml.createElement("TITLE");
        tagApp.appendChild(tagTitle);
        QDomText title = xml.createTextNode(qvariant_cast<QString>(item[0]));
        tagTitle.appendChild(title);
        //url
        QDomElement tagURL = xml.createElement("URL");
        tagApp.appendChild(tagURL);
        QDomText URL = xml.createTextNode(qvariant_cast<QString>(item[1]));
        tagURL.appendChild(URL);
        //icon
        QDomElement tagIcon = xml.createElement("ICON");
        tagApp.appendChild(tagIcon);
        QDomText icon = xml.createTextNode(qvariant_cast<QString>(item[2]));
        tagIcon.appendChild(icon);
    }
    QTextStream output(&file);
    output << xml.toString()<<endl;
    if (output.status() == QTextStream::Ok)
    {
        qDebug() << "Success";
        // succeeded
    }
    else
    {
          qDebug() << "fail";
        // failed
    }
    file.flush();
    file.close();
}

qint64 MenuItem::getItemCount()
{
    return this->mItems.count();
}

QString MenuItem::getURL(qint64 index)
{
    return this->mItems.at(index).app_url;
}
