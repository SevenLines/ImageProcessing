import QtQuick 2.0
import "../Presentation"

Slide {
    property alias image1Source: image1.source
    property alias image2Source: image2.source
    property alias color: mainRect.color
    
    anchors.fill: parent 
       
    Rectangle {
        id: mainRect
        
        anchors.margins: 8
        
        width: parent.width
        anchors.fill: parent 
        color: "white"
        Row {        

            height: image1.height
            width: parent.width
            anchors.centerIn: parent
            
            Image {
                id: image1
                width: parent.width/2
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/assets/1000px-SubtractiveColor.svg.png"
            }
            Image {
                id: image2
                width: parent.width/2
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/assets/1000px-CMY_ideal_version.svg.png"
            }
        }
    }
}
