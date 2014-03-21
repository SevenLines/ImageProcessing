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
        property real angle: sliderAngle.value
        property real tY: 1 / height
        property real tX: 1 / width
        
        fragmentShader: "
varying highp vec2 qt_TexCoord0;
uniform sampler2D src;
uniform int radius;
uniform float angle;
uniform float tY;
uniform float tX;

void main() {
    vec4 val = vec4(0.0);
    vec2 offset = vec2(0);
    float rad = radians(angle);
    vec2 step = vec2( cos(rad), sin(rad));
    vec2 max = step*vec2(radius);
    int j = 0;
    if (max.x >= 0.0 && max.y >= 0.0) {
        for(vec2 i = -max; i.x<=max.x && i.y <=max.y; i=i+step ) {
            offset.y = i.y*tY;
            offset.x = i.x*tX;
            val = val + texture2D(src, qt_TexCoord0 + offset);
            ++j;
        }
    } else if (max.x <= 0.0 && max.y >= 0.0) {
        for(vec2 i = -max; i.x>=max.x && i.y <=max.y; i=i+step ) {
            offset.y = i.y*tY;
            offset.x = i.x*tX;
            val = val + texture2D(src, qt_TexCoord0 + offset);
            ++j;
        }
    } else if (max.x >= 0.0 && max.y <= 0.0) {
        for(vec2 i = -max; i.x<=max.x && i.y >=max.y; i=i+step ) {
            offset.y = i.y*tY;
            offset.x = i.x*tX;
            val = val + texture2D(src, qt_TexCoord0 + offset);
            ++j;
        }
    } else if (max.x <= 0.0 && max.y <= 0.0) {
        for(vec2 i = -max; i.x>=max.x && i.y >=max.y; i=i+step ) {
            offset.y = i.y*tY;
            offset.x = i.x*tX;
            val = val + texture2D(src, qt_TexCoord0 + offset);
            ++j;
        }
    }
    gl_FragColor = val / vec4(float(j));
}"
    } 
    
    Rectangle {
        color: "#DDD"
        width: parent.width
        anchors.bottom: parent.bottom
        height: 80
        Text {
            anchors.left: parent.left
            anchors.right: slider.left 
            anchors.verticalCenter: parent.verticalCenter
            text: "Motion blur"
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
        }
    }
    
    Rectangle {
        color: "#DDD"
        width: parent.width
        anchors.top: parent.top
        height: 80
        Text {
            anchors.left: parent.left
            anchors.right: sliderAngle.left 
            anchors.verticalCenter: parent.verticalCenter
            text: "Angle"
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.Center
        }

        Slider {
            id: sliderAngle
            anchors.centerIn: parent
            width: parent.width/3
            
            minimumValue: 0
            maximumValue: 359
        }
        
        Text {
            anchors.right: parent.right
            anchors.left: sliderAngle.right 
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            text: (sliderAngle.value | 0) + "°"
            font.pixelSize: 60
            font.bold: true
        }
    }    
       
}
