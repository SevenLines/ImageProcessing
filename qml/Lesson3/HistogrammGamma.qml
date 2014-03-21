import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1


Slide2Im {
    id:slide
    
    
    property int channel: 0
    image1Source: "image://himage3/gamma/"
                  + (gamma.value | 0)
    image2Source: "image://himage3/gamma/"
                  + (gamma.value | 0)
                  + "/hist/black/#EEE"
    
    asynchronous: false
    
    Component {
        id: colorSlider
        Slider {
            width: rect.width * 0.3
            maximumValue: 240
            value: 100
            property int channel: 0
        }
    }
    
    Rectangle {
        id: rect
        width:slide.width
        anchors.bottom: parent.bottom
        height: 100
            
        Item {
            anchors.centerIn: rect
            Text {
                text: (gamma.value | 0) / 100
                anchors.left: gamma.right 
                anchors.verticalCenter: gamma.verticalCenter
                anchors.leftMargin: 30
                font.pixelSize: 40
//                font.bold: true
            }
            
            Text {
                text: "гамма"
                anchors.right: gamma.left 
                anchors.verticalCenter: gamma.verticalCenter
                anchors.rightMargin: 30
                font.pixelSize: 40
            }

            ColorSlider {
                id: gamma
                width: rect.width * 0.3
                anchors.centerIn: parent
                maximumValue: 255
                value: 100
                
                property int channel: 2
                onValueChanged: {slide.channel = channel}
            }
        }
    }

}
