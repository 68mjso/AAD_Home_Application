#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "menuitem.h"
#include "menuitemmodel.h"
#include "xmlreader.h"
#include "climatemodel.h"
#include "songlistmodel.h"
#include "song.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<SonglistModel>("SongList",1,0,"SonglistModel");
    qmlRegisterUncreatableType<Song>("SongList" ,1,0,"Song",QString("reason"));

    qmlRegisterType<MenuItemModel>("MenuItemList",1,0,"MenuItemModel");
    qmlRegisterUncreatableType<MenuItem>("MenuItemList",1,0,"Item",QString("reason"));



    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    Song* songList = new Song();
    engine.rootContext()->setContextProperty(QStringLiteral("songList"),songList);
    engine.rootContext()->setContextProperty(QStringLiteral("songPlayer"),songList->player());
    engine.rootContext()->setContextProperty(QStringLiteral("songPlayerList"),songList->playlist());

    MenuItem *menuItem = new MenuItem();
    engine.rootContext()->setContextProperty(QStringLiteral("menuItem"),menuItem);

    ClimateModel climate;
    engine.rootContext()->setContextProperty("climateModel",&climate);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
