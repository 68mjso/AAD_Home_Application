import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.12

Item{
    z:0
    anchors.fill: parent
    Plugin {
        id: mapPlugin
        name: "mapboxgl" //"osm" // , "esri", ...
    }
    MapQuickItem {
        id: marker
        anchorPoint.x: image.width/4
        anchorPoint.y: image.height
        coordinate: QtPositioning.coordinate(21.03, 105.78)

        sourceItem: Image {
            id: image
            source: "qrc:/Img/Map/car_icon.png"
        }
    }
    Map {
        id: mapView
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(21.03, 105.78)
        zoomLevel: 14
        copyrightsVisible: false
        enabled: false
        Component.onCompleted: {
            mapView.addMapItem(marker)
        }
    }
}
