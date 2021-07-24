import QtQuick 2.0
import "../Component"
Item{
    z:0
    anchors.fill: parent
    Text{
        id: climateLabel
        text: "Climate"
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.topMargin: 42
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#fff"
    }
    Item{
        id:widgetControl
        width: parent.width
        height: 200
        anchors.top: climateLabel.bottom
        anchors.topMargin: 63
        Item{
            id:widgetDriver
            width: 150
            anchors.left: parent.left
            anchors.leftMargin: 25
            Text{
                id:driverLabel
                text:"DRIVER"
                color: "#fff"
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image{
                id:driverIcon
                width: parent.width
                height: 150
                anchors.top: driverLabel.bottom
                anchors.topMargin: 30
                source: "qrc:/Img/Climate/seat.png"
            }
        }
        Rectangle{
            id:widgetSpeed
            width: 210
            height: 70
            color:"#00000000"
            anchors.left: widgetDriver.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 30
            Image{
                id:speedBg
                anchors.fill: parent
                source: "qrc:/Img/Climate/widget_climate_wind_level_bg.png"
            }
            Image{
                id:speedImg
                anchors.fill: parent
                source: "qrc:/Img/Climate/widget_climate_wind_level_01.png"
            }
        }
        Item{
            id:widgetPassenger
            width: 150
            anchors.left: widgetSpeed.right
            anchors.leftMargin: 30
            Text{
                id:passengerLabel
                text:"PASSENGER"
                color: "#fff"
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image{
                id:passengerIcon
                width: parent.width
                height: 150
                anchors.top: passengerLabel.bottom
                anchors.topMargin: 30
                source: "qrc:/Img/Climate/seat.png"
            }
        }
    }
    Item{
        id:widgetControlTemp
        anchors.top: widgetControl.bottom
        width: parent.width
        height: 80
        Item{
            id: driverTempContainer
            width: 150
            anchors.left: parent.left
            anchors.leftMargin: 25
            Text{
                id:driverTemp
                text:"HIGH"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#fff"
                font.pixelSize: 36
                anchors.top: parent.top
                anchors.topMargin: 27
            }
        }
        Item{
            id:fanIconContainer
            width: 210
            anchors.left: driverTempContainer.right
            anchors.leftMargin: 30
            Image{
                id:fanIcon
                width: 40
                height: 40
                source:"qrc:/Img/Climate/widget_climate_ico_wind.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
            }
        }
        Item{
            id: passengerTempContainer
            width: 150
            anchors.left: fanIconContainer.right
            anchors.leftMargin: 30
            Text{
                id:passengerTemp
                text:"HIGH"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#fff"
                font.pixelSize: 36
                anchors.top: parent.top
                anchors.topMargin: 27
            }
        }
    }
    Item{
        id:widgetControlFunc
        anchors.top: widgetControlTemp.bottom
        width: parent.width
        height: 100
        Item{
            id:controlAuto
            width: 150
            height: parent.height
            anchors.leftMargin: 25
            anchors.left: parent.left
            MouseArea{
                anchors.fill: parent
                Text{
                    text: "AUTO"
                    font.pixelSize: 36
                    color: "#fff"
                    anchors.centerIn: parent
                }
            }
        }
        Item{
            id:controlOutside
            width: 210
            height: parent.height
            anchors.leftMargin: 30
            anchors.left: controlAuto.right
            Text{
                text: "Outside"
                font.pixelSize: 24
                color: "#fff"
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text{
                text: "Text"
                font.pixelSize: 24
                color: "#fff"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Item{
            id:controlSync
            width: 150
            height: parent.height
            anchors.leftMargin: 30
            anchors.left: controlOutside.right
            MouseArea{
                anchors.fill: parent
                Text{
                    text: "SYNC"
                    font.pixelSize: 36
                    color: "#fff"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
