import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1

Slide {
    anchors.fill: parent 
    
    Rectangle {
        id: rect
        anchors.fill: parent
        color: "black"
        Image {
            id: image
            anchors.centerIn: parent 
            fillMode: Image.PreserveAspectFit
            source:"qrc:/lesson4/assets/blurs/alfaromeo.jpg"
            visible: false
            }
        }
    ShaderEffect {
        id: shader
        height: image.height
        width: image.width
        anchors.centerIn: parent

        property variant src: image
        property int radius: slider.value
        property real tY: 1 / height
        property real tX: 1 / width
        
        fragmentShader: "
varying highp vec2 qt_TexCoord0;
uniform sampler2D src;
uniform int radius;
uniform float tY;
uniform float tX;
void main() {
    vec4 val = vec4(0.0);
    vec2 offset = vec2(0);
    for(int i=-radius; i<=radius; ++i) {
        offset.x = float(i)*tX;
        val = val + texture2D(src, qt_TexCoord0 - offset);
    }
    gl_FragColor = val / vec4(float(2 * radius+1));
}"
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
            text: "Horizontal blur"
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.Center
        }

        Slider {
            
            id: slider
            anchors.centerIn: parent
            width: parent.width/3
            
            minimumValue: 0
            maximumValue: 100
        }
        
        Text {
            anchors.right: parent.right
            anchors.left: slider.right 
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            text: (slider.value | 0) + " px"
            font.pixelSize: 60
            font.bold: true
//            horizontalAlignment: Text.Left
        }
    }
       
}
