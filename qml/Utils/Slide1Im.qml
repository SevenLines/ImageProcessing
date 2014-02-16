import QtQuick 2.0
import "../Presentation"

Slide {
    anchors.fill: parent 
    
    property alias source: image.source
    property alias color: rect.color
    
    Rectangle {
        id: rect
        anchors.fill: parent
        
        
        
        color: "white"
        Image {
            anchors.margins: 16
            id: image
            anchors.fill: parent 
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/1000px-CMY_ideal_version.svg.png"
        }
    }
}
