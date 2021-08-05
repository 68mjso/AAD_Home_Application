#ifndef XMLREADER_H
#define XMLREADER_H

#include <QtXml>
#include <QFile>
#include "menuitem.h"


class XMLReader
{
public:
    XMLReader(QString filePath);
    QVector<Item> ParseXml();
private:
    QDomDocument m_xmlDoc;
    bool ReadXmlFile(QString filePath);
};

#endif // XMLREADER_H
