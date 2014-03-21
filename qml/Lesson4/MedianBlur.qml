import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1

Slide {
    anchors.fill: parent 
    
    Rectangle {
        id: rect
        anchors.centerIn: parent
        color: "black"
        width: row.width
        height: row.height
        Row {
            id: row
            spacing: 10
            Image {
//              anchors.centerIn: parent 
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/median_0x0.png"
//                visible: true
            }
            
            Image {
                id: image
//                anchors.centerIn: parent 
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/median_" + (slider.value|0) + "x" + (slider.value|0) + ".png"
            }
        }
    }


    Rectangle {
        width: parent.width
        anchors.bottom: parent.bottom
        height: 80
        color: "#DDD"
        Text {
            anchors.left: parent.left
            anchors.right: slider.left 
            anchors.verticalCenter: parent.verticalCenter
            text: "Median blur"
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.Center
        }

        Slider {
            
            id: slider
            anchors.centerIn: parent
            width: parent.width/3
            
            minimumValue: 0
            maximumValue: 7
        }
        
        Text {
            anchors.right: parent.right
            anchors.left: slider.right 
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            text: (slider.value | 0) + " px"
            font.pixelSize: 60
            font.bold: true
        }
    }
       
}
