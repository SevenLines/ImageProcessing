import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1

Slide {
    anchors.fill: parent 
    Rectangle {
        anchors.fill: parent
        color: invert.checked?"black":"white"
    }

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
                id:image
//                anchors.centerIn: parent 
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/Nanjing_Skyline_2010.png"
                visible: true
            }

            
            ShaderEffect {
                id: shader
                height: image.height
                width: image.width
//                anchors.centerIn: parent
        
                property variant src: image
                property int radius: slider.value
                property real tY: 1 / height
                property real tX: 1 / width
                property bool invert: invert.checked
                
                fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform sampler2D src;
        uniform int radius;
        uniform float tY;
        uniform float tX;   
        uniform bool invert;
        
        float d = float(radius+radius+1);
        int i,j;
        float xOffset; 
        
        
        void main() {
            vec4 val = vec4(0.0);
            vec2 offset = vec2(0);    
        
            for(i=-radius; i<=radius; ++i) {
                xOffset = float(i)*tX;
                for(j=-radius;j<=radius;++j) {
                    val = val - texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                }
            }
            gl_FragColor = val + texture2D(src, qt_TexCoord0) * vec4(d*d);
            if (invert) {
               gl_FragColor = vec4(1.0) - gl_FragColor; 
            }
            gl_FragColor.a = 1.0;
        }"
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
            text: "Edge detect"
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
       
}
