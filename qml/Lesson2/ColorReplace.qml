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
            source: "qrc:/images/assets/rainbow_cake-6.png"
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
        
        property int colorOffset: 0
        property int colorReplace: 0
        property int style: 0
        property int saturationIncrease: 100;
        
        fragmentShader: "
uniform sampler2D src;
uniform int style;
uniform int colorOffset;
uniform int colorReplace;
uniform int saturationIncrease;
varying vec2 highp qt_TexCoord0;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


void main() {
vec4 clr = texture2D(src, qt_TexCoord0);    
if (clr.a > 0.0) {
    if (style == 1) {
        vec3 hsv = rgb2hsv(clr.rgb);
        hsv.r = float(colorReplace) / 360.0;
        vec3 rgb = hsv2rgb(hsv);
        gl_FragColor = vec4(rgb.r, rgb.g, rgb.b, 1);
        return;
    }
    if (style == 2) {
        vec3 hsv = rgb2hsv(clr.rgb);
        hsv.r = hsv.r + float(colorOffset) / 360.0;
        if (hsv.r>1.0) hsv.r = hsv.r - 1.0;
        vec3 rgb = hsv2rgb(hsv);
        gl_FragColor = vec4(rgb.r, rgb.g, rgb.b, 1);
        return;
    }
    if (style == 3) {
        vec3 hsv = rgb2hsv(clr.rgb);
        hsv.g = hsv.g * float(saturationIncrease) / 100.0;
        if (hsv.r>1.0) hsv.r = hsv.r - 1.0;
        vec3 rgb = hsv2rgb(hsv);
        gl_FragColor = vec4(rgb.r, rgb.g, rgb.b, 1);
        return;
    }

        gl_FragColor = clr;    
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
                title: "saturation"
                type: 3
            }
            ListElement {
                title: "color shift"
                type: 2
            }  
            ListElement {
                title: "color replace"
                type: 1
            }
        }
          
        delegate: ItemDelegate {
            id: item
            selected: type == effect.style
            
            text: {
                if (type==1) {
                    return title +" "+ effect.colorReplace + "°";
                } 
                if (type==2) {
                    return title +" "+ effect.colorOffset + "°";
                }
                if (type==3) {
                    return title +" "+ effect.saturationIncrease + "%";
                }
                
                return title;
            }
            
            onMouseClicked: {
                effect.style = type;
            }
            
            onWheelEvent: {
                if (wheel.angleDelta.y>0) {
                    if (type == 1) {
                        if ( effect.colorReplace==359) {
                             effect.colorReplace=0;
                        } else {
                            effect.colorReplace++;
                        }
                    }
                    if (type == 2) {
                        if ( effect.colorOffset==359) {
                             effect.colorOffset=0;
                        } else {
                            effect.colorOffset++;
                        }
                    }
                    if (type == 3) {
                        effect.saturationIncrease+=10;
                    }
                } else {
                    if (type == 1) {
                        if (effect.colorReplace == 0) {
                            effect.colorReplace = 359;
                        } else {
                            effect.colorReplace--;
                        }
                    }
                    if (type == 2) {
                        if (effect.colorOffset == 0) {
                            effect.colorOffset = 359;
                        } else {
                            effect.colorOffset--;
                        }
                    }
                    if (type == 3) {
                        effect.saturationIncrease-=10;
                        if (effect.saturationIncrease < 0) {
                            effect.saturationIncrease = 0;
                        }
                    }
                }
            }
        }
    }
    
   
}
