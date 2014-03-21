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
                id: image
//                anchors.centerIn: parent 
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/median_0x0.png"
                visible: true
            }
           
            
            ShaderEffect {
                width: image.width
                height: image.height
                
                property int radius: slider.value
                property real tY: 1 / height
                property real tX: 1 / width
                property variant src: ShaderEffectSource {
                    sourceItem: ShaderEffect {
                        id: shader
                        height: image.height
                        width: image.width
                
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

float d = float(radius+radius+1);
int i,j;
float xOffset; 


void main() {
    vec4 val = vec4(0.0);
    vec2 offset = vec2(0);    
    
    for(i=-radius; i<=radius; ++i) {
    val = val + texture2D(src, qt_TexCoord0 - vec2(float(i)*tX, 0.0));
    }
    gl_FragColor = val / vec4(d);
    /*vec4 val = vec4(0.0);
    vec2 offset = vec2(0);    

    for(i=-radius; i<=radius; ++i) {
        xOffset = float(i)*tX;
        for(j=-radius;j<=radius;++j) {
            val = val + texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
        }
    }
    gl_FragColor = val / vec4(d*d);*/
}"
                    }
                }
                
                fragmentShader: "
varying highp vec2 qt_TexCoord0;
uniform sampler2D src;
uniform int radius;
uniform float tY;
uniform float tX;

float d = float(radius+radius+1);
int i,j;
float xOffset; 


void main() {
    vec4 val = vec4(0.0);
    vec2 offset = vec2(0);    

    for(i=-radius; i<=radius; ++i) {
        val = val + texture2D(src, qt_TexCoord0 - vec2(0.0, float(i)*tY));
    }
    gl_FragColor = val / vec4(d);
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
            text: "Box blur"
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
       
}
