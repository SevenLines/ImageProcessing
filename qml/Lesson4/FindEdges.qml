import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1

Slide {
    anchors.fill: parent 
    Rectangle {
        color: invert.checked?"black":"white"
        anchors.fill: parent 
    
    Rectangle {
        id: rect
        anchors.centerIn: parent
        color: invert.checked?"black":"white"
        width: row.width
        height: row.height
        Row {
            id: row
            spacing: 10
            Image {
                id: image
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/Nanjing_Skyline_2010.png"
                visible: true
                }
            ShaderEffect {
                id: shader
                height: image.height
                width: image.width

                property variant src: image
                property int radius: slider.value
                property real angle: sliderAngle.value
                property real tY: 1 / height
                property real tX: 1 / width
                property bool invert: invert.checked
                
                fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform sampler2D src;
        uniform int radius;
        uniform float angle;
        uniform float tY;
        uniform float tX;
        uniform bool invert;
        
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
                    val = val - texture2D(src, qt_TexCoord0 + offset);
                    ++j;
                }
            } else if (max.x <= 0.0 && max.y >= 0.0) {
                for(vec2 i = -max; i.x>=max.x && i.y <=max.y; i=i+step ) {
                    offset.y = i.y*tY;
                    offset.x = i.x*tX;
                    val = val - texture2D(src, qt_TexCoord0 + offset);
                    ++j;
                }
            } else if (max.x >= 0.0 && max.y <= 0.0) {
                for(vec2 i = -max; i.x<=max.x && i.y >=max.y; i=i+step ) {
                    offset.y = i.y*tY;
                    offset.x = i.x*tX;
                    val = val - texture2D(src, qt_TexCoord0 + offset);
                    ++j;
                }
            } else if (max.x <= 0.0 && max.y <= 0.0) {
                for(vec2 i = -max; i.x>=max.x && i.y >=max.y; i=i+step ) {
                    offset.y = i.y*tY;
                    offset.x = i.x*tX;
                    val = val - texture2D(src, qt_TexCoord0 + offset);
                    ++j;
                }
            }
            val += vec4(float(j)) * texture2D(src, qt_TexCoord0);
            if (invert) {
                gl_FragColor = 1.0 - val;
            } else {
                gl_FragColor = val;
            }
            gl_FragColor.a = 1.0;
        }"
            } 
        }
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
            text: "Edges"
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.Center
        }

        Slider {
            id: slider
            anchors.centerIn: parent
            width: parent.width/4
            
            minimumValue: 0
            maximumValue: image.width / 4
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
        Row {
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Text {
                text: "inv"
                font.pixelSize: 40
                font.bold: true
                horizontalAlignment: Text.Center
            }

            CheckBox {
                id: invert
                height: parent.height
            }
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
}
