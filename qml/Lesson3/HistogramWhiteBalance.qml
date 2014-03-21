import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1


Slide2Im {
    id:slide
    
    
    property int channel: 0
    image1Source: "image://himage1/whitebalance/"
                  + (red.value | 0) +"/"
                  + (green.value | 0) + "/"
                  + (blue.value | 0) 
    image2Source: "image://himage1/whitebalance/"
                  + (red.value | 0) +"/"
                  + (green.value | 0) + "/"
                  + (blue.value | 0) + "/hist/" + channel + "/black/#EEE"
    
//    asynchronous: false
    
    Component {
        id: colorSlider
        Slider {
            width: rect.width * 0.3
            maximumValue: 255
            value: 255
            property int channel: 0
        }
    }

    Row {
        anchors.bottom: slidersRow.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 0.8 * parent.width
        spacing:  0.02*parent.width
        height: 60
        Text {
            width: parent.width * 0.3
            text: "red: " + (red.value | 0)
            font.pixelSize: 40
            font.bold: true
        }
        Text {
            font.pixelSize: 40
            width: parent.width * 0.3
            text: "green: " + (green.value | 0)
            font.bold: true
        }
        Text {
            font.pixelSize: 40
            font.bold: true
            width: parent.width * 0.3
            text: "blue: " + (blue.value | 0)        
        }
    }
    
              
    Row {
        id: slidersRow
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 0.8 * parent.width
        spacing:  0.02*parent.width
        height: 40
        
        ColorSlider {
            id: red
            width: parent.width * 0.3
            maximumValue: 255
            value: 255
            
            property int channel: 2
            onValueChanged: {slide.channel = channel}
        }
        
        ColorSlider {
            id: green
            width: parent.width * 0.3
            maximumValue: 255
            value: 255
            
            property int channel: 1
            onValueChanged: {slide.channel = channel}
        }
        
        ColorSlider {
            id: blue
            width: parent.width * 0.3
            maximumValue: 255
            value: 255
            
            property int channel: 0
            
            onValueChanged: {slide.channel = channel}
        }
    }
        
}
