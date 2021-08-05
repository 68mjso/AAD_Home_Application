#include "xmlreader.h"

XMLReader::XMLReader(QString filePath)
{
    ReadXmlFile(filePath);
}

bool XMLReader::ReadXmlFile(QString filePath)
{
    // Load xml file as raw data
    QFile f(filePath);
    if (!f.open(QIODevice::ReadOnly ))
    {
        if(filePath == "config.xml"){
            QFile defaultFile("://config.xml");
            if(!defaultFile.open(QIODevice::ReadOnly)){
                return false;
            }
            m_xmlDoc.setContent(&defaultFile);
            defaultFile.close();
            return true;
        }
        // Error while loading file
        return false;
    }
    // Set data into the QDomDocument before processing
    m_xmlDoc.setContent(&f);
    f.close();
    return true;
}

QVector<Item> XMLReader::ParseXml()
{
    QVector<Item> model;
    // Extract the root markup
    QDomElement root=m_xmlDoc.documentElement();

    // Get the first child of the root (Markup COMPONENT is expected)
    QDomElement Component=root.firstChild().toElement();

    // Loop while there is a child
    while(!Component.isNull())
    {
        // Check if the child tag name is COMPONENT
        if (Component.tagName()=="APP")
        {
            // Get the first child of the component
            QDomElement Child=Component.firstChild().toElement();

            QString title;
            QString img_normal;
            QString img_focus;
            QString img_press;
            QString app_url;
            // Read each child of the component node
            while (!Child.isNull())
            {
                // Read Name and value
                if (Child.tagName()=="TITLE"){
                    title = Child.firstChild().toText().data();
                }
                if (Child.tagName()=="ICON"){
                    img_normal = Child.firstChild().toText().data()+"_n.png";
                    img_focus = Child.firstChild().toText().data()+"_f.png";
                    img_press = Child.firstChild().toText().data()+"_p.png";
                }
                if(Child.tagName()=="URL"){
                    app_url = Child.firstChild().toText().data();
                }
                // Next child
                Child = Child.nextSibling().toElement();
            }
            Item item({title,img_normal,img_focus,img_press,app_url});
            model.push_back(item);
        }
        // Next component
        Component = Component.nextSibling().toElement();
    }
    return model;
}
