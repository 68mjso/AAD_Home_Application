QT += quick dbus xml

CONFIG += c++11

DBUS_INTERFACES += climate.xml

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        climatemodel.cpp \
        main.cpp \
        menuitem.cpp \
        menuitemmodel.cpp \
        xmlreader.cpp

RESOURCES += \
    qml.qrc \
    resource.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

QT += xml

HEADERS += \
    climatemodel.h \
    menuitem.h \
    menuitemmodel.h \
    xmlreader.h

DISTFILES += \
config.xml \
climate.xml
