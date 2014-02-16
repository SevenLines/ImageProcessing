import QtQuick 2.0
import QtQuick.Controls 1.1

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
        property int style: 0
        
        fragmentShader: "
uniform sampler2D src;
uniform int style;
uniform int numberOfShades;
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

    float o = gray;

    gl_FragColor = vec4(o, o, o, 1);
} else {
    gl_FragColor = vec4(0.0);
}
}
"
    }
    
    
    
    Rectangle {
        width:0.35*parent.width;
        anchors.top: parent.top
        color: Qt.rgba(1,1,1,1)
        anchors.right: parent.right;
        anchors.bottom: parent.bottom;
        z: 1000;
        
        ListView {
            spacing: 2
           
            clip: true
            
            anchors.fill: parent
            anchors.margins: 8
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
                    title: "tones"
                    type: 6
                }
            }
            delegate: Rectangle {
                id: rect
                width: parent.width   
                height:1.1*text.height
                
                state: {
                    if (type == effect.style) {
                        return "selected";
                    } else  {
                        if (mouseArea.containsMouse) {
                            return "hovered";
                        }
                        return "default";
                    }
                }
                
                states: [
                    State {
                        name: "selected"
                        PropertyChanges {target: rect; color: "orange" }
                    },
                    State {
                        name: "default"
                        PropertyChanges {target: rect; color: "white" }
                    },
                    State {
                        name: "hovered"
                        PropertyChanges {target: rect; color: "#DDD"}
                    }

                ]
                
                transitions: [
                    Transition {
                        ColorAnimation {properties: "color"}
                    }
                ]
                
                Text {
                    color: (type == effect.style)?"white":"black"
                    id: text
                    width:parent.width
                    text: {
                        if (type==6) {
                            return title +":"+ effect.numberOfShades;
                        } else {
                            return title;
                        }
                    }
                        
                    font.pixelSize: 60
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    
                    transitions: [
                        Transition {
                            ColorAnimation {properties: "color"}
                        }
                    ]
                    
                    MouseArea {
                        id:mouseArea
                        anchors.fill: parent
                        onClicked: {
                            effect.style = type
                        }
                        hoverEnabled: true; 
                        
                        onWheel: {
                            if (type==6) {
                                if (wheel.angleDelta.y>0) {
                                    effect.numberOfShades++;
                                } else {
                                    if (effect.numberOfShades > 2) {
                                        effect.numberOfShades--;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
