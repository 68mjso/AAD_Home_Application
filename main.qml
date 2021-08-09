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
    property int itemCount: 3 + menuItem.getItemCount();

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
                width: 1920
                height:1096
                color: "#00000000"
                focus:true
                Keys.onPressed: {
                    console.log("key pressed")
                    if(event.key === Qt.Key_Left){
                        --focusItem;
                        if(focusItem < 0){
                            focusItem = itemCount;
                        }
                        console.log(focusItem)
                    }else if(event.key === Qt.Key_Right){
                        ++focusItem;
                        if(focusItem > itemCount){
                            focusItem = 0;
                        }
                        console.log(focusItem)
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
