import QtQuick 2.0

import "../Presentation"
import "../Utils"
import QtQuick.Controls 1.1

Slide {
    id:slide
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
                id:image
//              anchors.centerIn: parent 
                fillMode: Image.PreserveAspectFit
                source:"qrc:/lesson4/assets/blurs/median_0x0.png"
//                visible: true
            }
            
            ShaderEffect {
                id: shader
                height: image.height
                width: image.width
//                anchors.centerIn: parent
        
                property variant src: image
                property int style: sharpenModel.get(listView.currentIndex).style
                property real tY: 1 / height
                property real tX: 1 / width
                
                fragmentShader: "
        varying highp vec2 qt_TexCoord0;
        uniform sampler2D src;
        uniform int style;
        uniform float tY;
        uniform float tX;
        int i,j;
        float xOffset; 
        
        void sharpen1() {
            vec4 val = vec4(0.0);
            vec2 offset = vec2(0);    
        
            for(i=-1; i<=1; ++i) {
                xOffset = float(i)*tX;
                for(j=-1;j<=1;++j) {
                    if (i==0 && j ==0 ) {
                        val = val + vec4(9) * texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    } else {
                        val = val - texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    }   
                }
            }
            gl_FragColor = val;
        }
        
        void sharpen2() {
            vec4 val = vec4(0.0);
            vec2 offset = vec2(0);    
        
            for(i=-2; i<=2; ++i) {
                xOffset = float(i)*tX;
                for(j=-2;j<=2;++j) {
                    if (i==0 && j ==0 ) {
                        val = val + vec4(8) * texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    } else if (i>=-1 && i<=1 && j>=-1 && j<=1 ) {
                        val = val + vec4(2) * texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    } else {
                        val = val - texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    }  
                }
            }
            gl_FragColor = val / vec4(8.0);
        }

        void edges() {
            vec4 val = vec4(0.0);
            vec2 offset = vec2(0);    
        
            for(i=-1; i<=1; ++i) {
                xOffset = float(i)*tX;
                for(j=-1;j<=1;++j) {
                    if (i==0 && j ==0 ) {
                        val = val + vec4(-7) * texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    } else {
                        val = val + texture2D(src, qt_TexCoord0 - vec2(xOffset, float(j)*tY));
                    }   
                }
            }
            gl_FragColor = val;
        }

        
        void main() {
            if (style == 0 ) {
                sharpen1();
                return;
            } 
            if (style == 1 ) {
                sharpen2();
            }
            if (style == 2 ) {
                edges();
            }
            return;
        }"
            } 

        }
    }

    
    ListModel {
        id: sharpenModel
        ListElement{
            name: "Sharpen"
            style: 0
        }
        ListElement{
            name: "Sharpen II"
            style: 1
        }
        ListElement{
            name: "Edges"
            style: 2
        }
    }
    
    
    ListView {
        id: listView
        anchors.bottom: slide.bottom
        width: slide.width
        height: 60
        orientation: ListView.Horizontal
        
        model: sharpenModel
        
        delegate: ItemDelegate {
            id: item
            text: name
            width: slide.width / sharpenModel.count ;
            defalTextColor: "#222"
            selectedColor: "white"
            selectedTextColor: "black"
            hoverColor: Qt.lighter(name, 1.7)
            defalColor: "#444"    
            
            onMouseClicked: {
                listView.currentIndex = index
            }
        }
    }
    
//    Rectangle {
//        width: parent.width
//        anchors.bottom: parent.bottom
//        height: 80
//        color: "#DDD"
//        Text {
//            anchors.left: parent.left
//            anchors.right: slider.left 
//            anchors.verticalCenter: parent.verticalCenter
//            text: "Sharpen"
//            font.pixelSize: 40
//            font.bold: true
//            horizontalAlignment: Text.Center
//        }

//        Slider {
            
//            id: slider
//            anchors.centerIn: parent
//            width: parent.width/3
            
//            minimumValue: 0
//            maximumValue: 7
//        }
        
//        Text {
//            anchors.right: parent.right
//            anchors.left: slider.right 
//            anchors.leftMargin: 40
//            anchors.verticalCenter: parent.verticalCenter
//            text: (slider.value | 0) + " px"
//            font.pixelSize: 60
//            font.bold: true
//        }
//    }
       
}
