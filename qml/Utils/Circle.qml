import QtQuick 2.0

Item {
    id: circle
    anchors.fill: parent;
    
    property int radius: 100
    property alias rectX: rect.x
    property alias rectY: rect.y
    property alias color: rect.color
    property alias rectOpacity: rect.opacity
    
    Rectangle {
        id:rect
        width: circle.radius
        height: circle.radius
        radius: width*0.5
        x: 0
        y: 0
        color:"lime"
    }
}
