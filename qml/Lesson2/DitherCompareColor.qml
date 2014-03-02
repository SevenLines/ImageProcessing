import QtQuick 2.0
import "../Utils"

Slide2Im {
    anchors.fill: parent
    id:slide1
    image1Source: "image://colorDither/3/" + slide1.colorsCount;
    image2Source: "image://colorDither/4/" + slide1.colorsCount;
    property int colorsCount: 2;
    color:"black";
  
    
    fillMode: Image.Pad
    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true
        onWheel: {
            if(wheel.angleDelta.y > 0) {
                slide1.colorsCount++; 
            } else {
                if (slide1.colorsCount>2) {
                    slide1.colorsCount--;
                }
            }
        }
    }
    Rectangle {
        height: text.height*1.2
        width: parent.width
        anchors.bottom: parent.bottom
        Text {
            anchors.horizontalCenter: parent.horizontalCenter;
            id: text
//            anchors.margins: 
            text: "цветов:" + Math.pow(slide1.colorsCount,3)
            font.pixelSize: 60
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
    }
}  

