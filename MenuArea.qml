import QtQuick 2.14
import MenuItemList 1.0
import QtQuick.Window 2.14
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.12
import QtQml.Models 2.1
import "./Component"

Rectangle {
    property alias menuAreaList:listApp
    id:menuArea
    width: 1920
    height:526
    color: "#00000000"
    function openApplication(url){
        appWindow.displayBack = true;
        appStackView.push([url]);
    }


    function writeData(){
        var list = [];
        for(var i =0;i<listApp.count;i++){
            var item  = listAppModel.items.get(i).model;
            var title = item.title;
            var url = item.app_url;
            var icon = item.normal_img.substr(0,item.normal_img.length - 6);
//            list.push({title:title,url:url,icon:icon});
             list.push([title,url,icon]);

        }
        menuItem.writeXml(list);

    }
    Component{
        id:dragDelegate
        MouseArea{
            id:dragArea
            property bool held: false
            property int img_status : 0
            width: 306
            height: 526

            drag.target: held ? content : undefined
            drag.axis: Drag.XAxis

            onPressAndHold: {
                held = true
            }

            onPressed: {
                img_status = 1
            }

            onReleased: {
                held = false;
                img_status = 0;
            }
            onClicked: {
                appWindow.focusArea = 1;
                appWindow.focusItem = index;
                openApplication(app_url)
            }

            onCanceled: {
                img_status = 0;
            }
            MenuItem{
                id: content
                width: 306
                height: 480

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                img_source: img_status == 1?press_img: appWindow.focusItem == index && appWindow.focusArea == 1 ? focus_img : normal_img

                img_normal:normal_img

                name:title

                Drag.active: dragArea.held
                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                states: State {
                    when: dragArea.held

                    ParentChange { target: content }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }
            }


            DropArea {
                anchors.fill: parent

                onEntered: {
                    listAppModel.items.move(
                                drag.source.DelegateModel.itemsIndex,
                                dragArea.DelegateModel.itemsIndex)
                    writeData();
                }
            }
        }
    }

    DelegateModel{
        id: listAppModel
        model: MenuItemModel{
            list: menuItem
        }
        delegate: dragDelegate
    }

    ListView{
        id: listApp
        anchors.leftMargin: 12
        anchors.fill: parent
        orientation: Qt.Horizontal
        spacing:12
        snapMode: ListView.SnapToItem
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }
        model: listAppModel
        ScrollBar.horizontal: ScrollBar{
            parent: listApp.parent
          //  width: 200
            //active: true
            anchors.left:parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            stepSize: 0.5
        }
    }



}
