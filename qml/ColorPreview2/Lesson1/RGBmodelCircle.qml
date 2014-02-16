import QtQuick 2.0
import "../Utils"

Rectangle {
    id: rgbModel
    width: 600 
    height: 600
    color: "black"
    
    Item {
        id:scene
        width: 600 
        height: 600
        anchors.centerIn: parent
        
        property int min: Math.min(width,height)

        Circle {
            id: red
            radius: scene.min / 1.5
            color: "red"
            rectOpacity: sliderFirst.value/255
        }
        
        Circle {
            id: green
            radius: scene.min / 1.5
            rectX: radius*0.5
            color: "lime"
            rectOpacity: sliderSecond.value/255
        }
        
        Circle {
            id: blue
            radius: scene.min / 1.5
            rectX: radius*0.25
            rectY: radius*0.5
            color: "blue"
            rectOpacity: sliderThird.value/255
        }
        
        
        ShaderEffect {
            anchors.fill: scene
            property variant red: ShaderEffectSource {sourceItem: red; hideSource:true}
            property variant blue: ShaderEffectSource {sourceItem: blue; hideSource:true}
            property variant green: ShaderEffectSource {sourceItem: green; hideSource:true}
            
            fragmentShader: "
    varying highp vec2 qt_TexCoord0;    
    uniform sampler2D red;
    uniform sampler2D blue;
    uniform sampler2D green;
    void main(void) {
            gl_FragColor = texture2D(red, qt_TexCoord0) 
                        + texture2D(blue, qt_TexCoord0)
                        + texture2D(green, qt_TexCoord0);
    }
        "
        }
    }
    
    Rectangle {
        id: sliders
        color: Qt.rgba(0,0,0,0);
        width: 92
        height: 0.3 * parent.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8

        
        ColorSlider {
            id: sliderFirst
            anchors.left: parent.left
            anchors.leftMargin: 7
            anchors.top: parent.top
            anchors.topMargin: 31
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            orientation: 0
        }
        
        ColorSlider {
            id: sliderSecond
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 31
            orientation: 0
        }
        
        ColorSlider {
            id: sliderThird
            anchors.left: parent.left
            anchors.leftMargin: 63
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 31
            orientation: 0
        }
    }
}
