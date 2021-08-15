import QtQuick 2.0
import "../Component"

Item{
    function changeFanSpeed(){
        if (climateModel.fan_level < 1) {
            speedImg.source = "qrc:/Img/Climate/widget_climate_wind_level_01.png"
        }
        else if (climateModel.fan_level < 10) {
            speedImg.source = "qrc:/Img/Climate/widget_climate_wind_level_0"+climateModel.fan_level+".png"
        } else {
            speedImg.source = "qrc:/Img/Climate/widget_climate_wind_level_"+climateModel.fan_level+".png"
        }
    }

    function changeTemp(){
        if (climateModel.driver_temp == 16.5) {
            driverTemp.text = "LOW"
        } else if (climateModel.driver_temp == 31.5) {
            driverTemp.text = "HIGH"
        } else {
            driverTemp.text = climateModel.driver_temp+"°C"
        }

        if (climateModel.passenger_temp == 16.5) {
            passengerTemp.text = "LOW"
        } else if (climateModel.passenger_temp == 31.5) {
            passengerTemp.text = "HIGH"
        } else {
            passengerTemp.text = climateModel.passenger_temp+"°C"
        }
    }

    function getDriverTemp(){
        var text = "";
        if (climateModel.driver_temp == 16.5) {
            text = "LOW"
        } else if (climateModel.driver_temp == 31.5) {
            text = "HIGH"
        } else {
            text = climateModel.driver_temp+"°C"
        }
        return text;
    }
    function getPassengerTemp(){
        var text = "";
        if (climateModel.passenger_temp == 16.5) {
            text = "LOW"
        } else if (climateModel.passenger_temp == 31.5) {
            text = "HIGH"
        } else {
            text = climateModel.passenger_temp+"°C"
        }
        return text;
    }

    Connections{
        target: climateModel
        onDataChanged:{
            changeFanSpeed();
            changeTemp();
        }
    }

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
            Image{
                id:driverDirectionUpper
                width: parent.width
                height: 150
                anchors.top: driverLabel.bottom
                anchors.topMargin: 30
                source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/Climate/widget_climate_arrow_01_s_b.png" : ""

            }
            Image{
                id:driverDirectionLower
                width: parent.width
                height: 150
                anchors.top: driverLabel.bottom
                anchors.topMargin: 30
                source: climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                            "qrc:/Img/Climate/widget_climate_arrow_02_s_b.png" : ""
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
            Image{
                id:passengerDirectionUpper
                width: parent.width
                height: 150
                anchors.top: passengerLabel.bottom
                anchors.topMargin: 30
                source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/Climate/widget_climate_arrow_01_s_b.png" : ""

            }
            Image{
                id:passengerDirectionLower
                width: parent.width
                height: 150
                anchors.top: passengerLabel.bottom
                anchors.topMargin: 30
                source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                            "qrc:/Img/Climate/widget_climate_arrow_02_s_b.png" : ""
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
                text:getDriverTemp()
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
                text:getPassengerTemp()
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
                    color: !climateModel.auto_mode ? "#fff" : "#ccc"
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
                text: ""
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
                    color: !climateModel.sync_mode ? "#fff": "#ccc"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
