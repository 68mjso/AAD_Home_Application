import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import MenuItemList 1.0
import "./JS/Utility.js" as Utility

Window {
    id: appWindow
    width: 1920
    height: 1200
    visible: true
    title: qsTr("Home Application")
    property bool displayBack: false
    property int focusItem :0
    property int focusArea: 0
    property int itemCount: menuItem.getItemCount();

    function openApplication(url){
        focusItem = 0;
        appWindow.displayBack = true;
        appStackView.push([url]);
    }

    Image {
        anchors.fill: parent
        id: bg
        source: "qrc:/Img/bg_full.png"
    }
    Header{
        id:header
        anchors.left: parent.left
        anchors.right: parent.right
        isDisplay: displayBack
        onBackClicked:{
            appStackView.pop();
            displayBack = false;
            focusItem = 0;
        }
    }
    StackView{
        id:appStackView
        width: 1920
        height:1096
        anchors.top: header.bottom
        initialItem: Component{
            id:root
            Rectangle{
                id: mainArea
                width: 1920
                height:1096
                color: "#00000000"
                focus:true
                Component.onCompleted: {
                    mainArea.forceActiveFocus();
                }

                Keys.onPressed: {
                    switch(event.key){
                    case Qt.Key_Left:
                        --focusItem;
                        if(focusArea == 0){
                            if(focusItem < 0){
                                focusItem = 2;
                            }
                        }else{
                            if(focusItem <0){
                                focusItem = itemCount-1;
                            }
                        }
                        break;
                    case Qt.Key_Right:
                        ++focusItem;
                        if(focusArea == 0){
                            if(focusItem > 2){
                                focusItem = 0;
                            }
                        }else{
                            if(focusItem > itemCount-1){
                                focusItem = 0;
                            }
                        }
                        break;
                    case Qt.Key_Up:
                        focusArea = focusArea == 0 ? 1 : 0;
                        focusItem = 0;
                        break;
                    case Qt.Key_Down:
                        focusArea = focusArea == 1 ? 0 : 1;
                        focusItem = 0;
                        break;
                    }
                    if(focusArea == 1 && focusItem > 5){
                        menuArea.menuAreaList.currentIndex = focusItem;
                    }else{
                        menuArea.menuAreaList.currentIndex = 0;
                    }
                }
                Keys.onReturnPressed: {
                    if(focusItem > 0){
                        switch(focusItem){
                        case 1:
                            openApplication("qrc:/App/AppMap.qml");
                            break;
                        case 2:
                            openApplication("qrc:/App/AppClimate.qml");
                            break;
                        case 3:
                            openApplication("qrc:/App/AppMedia.qml");
                            break;
                        default:
                            var url = menuItem.getURL(focusItem-4);
                            openApplication(url);
                            break;
                        }
                    }
                }

                WidgetArea{
                    id:widgetArea
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
                MenuArea{
                    id:menuArea
                    anchors.top: widgetArea.bottom
                    anchors.left: widgetArea.left
                    anchors.right: widgetArea.right
                }
            }
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }


}
