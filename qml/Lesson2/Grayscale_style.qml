import QtQuick 2.0
import QtQuick.Controls 1.1
import "../Utils"

Rectangle {
    anchors.fill: parent
    
    color:"black";
    
    Item {
        id: img
        anchors.fill: parent
        Image {
            width: 0.65 * parent.width
            height:parent.height
            source: "qrc:/images/assets/Lenna.png"
            fillMode: Image.PreserveAspectFit
        }
    }
    
    ShaderEffectSource {
        id: imgSource
        sourceItem: img
        hideSource: true
    }
    
    ShaderEffect {
        id: effect;
        
        anchors.fill: parent
        property variant src: imgSource
        
        property int numberOfShades: 2
        property int numberOfColorShades: 2
        property int style: 0
        
        fragmentShader: "
uniform sampler2D src;
uniform int style;
uniform int numberOfShades;
uniform int numberOfColorShades;
varying vec2 highp qt_TexCoord0;
void main() {
vec4 clr = texture2D(src, qt_TexCoord0);
    
if (clr.a > 0.0) {

    float min = min(clr.r,min(clr.g,clr.b));
    float max = max(clr.r,max(clr.g,clr.b));
    float gray;
    if (style == 0) {
        gl_FragColor = clr;
        return;
    }
    if (style == 1) {
        gray = (clr.r + clr.g + clr.b)/3.0;
    }
    if (style == 2) {
        gray = (min + max)/2.0;
    }
    if (style == 3) {
        gray = 0.30*clr.r + 0.59*clr.g + 0.11*clr.b;
    }
    if (style == 4) {
        gray = min(clr.r, min(clr.g, clr.b));
    }
    if (style == 5) {
        gray = max(clr.r, max(clr.g, clr.b));
    }
    if (style == 6) {
        gray = 0.30*clr.r + 0.59*clr.g + 0.11*clr.b;
        float n = float(numberOfShades);
        float factor = 1.0 / (n - 1.0);
        gray = float(int(gray / factor + 0.5))  * factor;
    }
    if (style == 7) {
        float n = float(numberOfColorShades);
        float factor = 1.0 / (n - 1.0);
        clr.r = float(int(clr.r / factor + 0.5))  * factor;        
        clr.g = float(int(clr.g / factor + 0.5))  * factor;
        clr.b = float(int(clr.b / factor + 0.5))  * factor;
        gl_FragColor = vec4(clr.r, clr.g, clr.b, 1.0);
        return;
    }
    if (style == 8) {
        gray = clr.r;
    }
    if (style == 9) {
        gray = clr.g;
    }
    if (style == 10) {
        gray = clr.b;
    }

    float o = gray;

    gl_FragColor = vec4(o, o, o, 1);
} else {
    gl_FragColor = vec4(0.0);
}
}
"
    }
    
    
    ItemsList {
        model: ListModel {
            ListElement {
                title: "origin"
                type: 0
            }
            ListElement {
                title: "average"
                type: 1
            }
            ListElement {
                title: "desaturate"
                type: 2
            }
            ListElement {
                title: "luma"
                type: 3
            }
            ListElement {
                title: "min"
                type: 4
            }
            ListElement {
                title: "max"
                type: 5
            }
            ListElement {
                title: "red"
                type: 8
            }
            ListElement {
                title: "green"
                type: 9
            }
            ListElement {
                title: "blue"
                type: 10
            }
            ListElement {
                title: "grays"
                type: 6
            }
            ListElement {
                title: "tones"
                type: 7
            }
        }
          
        delegate: ItemDelegate {
            id: item
            selected: type == effect.style
            
            text: {
                if (type==6)
                    return title +":"+ effect.numberOfShades;
                if (type == 7)
                    return title +":"+ effect.numberOfColorShades + " " + effect.numberOfColorShades + 
                            " " + effect.numberOfColorShades;

                return title;
            }
            
            onMouseClicked: {
                effect.style = type;
            }
            
            onWheelEvent: {
                if (type==6 ) {
                    if (wheel.angleDelta.y>0) {
                        effect.numberOfShades++;
                    } else {
                        if (effect.numberOfShades > 2) {
                            effect.numberOfShades--;
                        }
                    }
                }
                if (type==7 ) {
                    if (wheel.angleDelta.y>0) {
                        effect.numberOfColorShades++;
                    } else {
                        if (effect.numberOfColorShades > 2) {
                            effect.numberOfColorShades--;
                        }
                    }
                }
            }
        }
    }
    
}
