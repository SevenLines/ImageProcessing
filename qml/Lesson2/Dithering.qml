import QtQuick 2.0
import "../Utils"

Rectangle {
    id: scene
    anchors.fill: parent
    
    color:"black";
    
    
    Component.onCompleted: {
        image.source = "qrc:/images/assets/portal_cube_720.png";
    }
    
    Image {
        id: image
        width: scene.width - itemList.width - 4
        anchors.left: scene.left
        anchors.top: scene.top
        anchors.bottom: scene.bottom
        fillMode: Image.Pad
        
        property real textureX:imageMouseArea.mouseX / width
        property real textureY:imageMouseArea.mouseY / height
        
        MouseArea {
            id: imageMouseArea
            anchors.fill: parent;
        }
    }
    
    ShaderEffect {
        id: effect
        visible: imageMouseArea.containsMouse
        
        x: imageMouseArea.mouseX - width / 2
        y: imageMouseArea.mouseY - height / 2
        

        property int style:0
        width: 0.3*parent.width
        height: 0.3*parent.width
        
        property var src: ShaderEffectSource{
            sourceItem: image;
        }
        
        property real textureHeight: 0.2
        property real textureX: image.textureX
        property real textureY: image.textureY
        
        fragmentShader: "
uniform sampler2D src;
uniform float textureX;
uniform float textureY;
uniform float textureHeight;
varying vec2 highp qt_TexCoord0;
void main() 
{
    vec2 tex = qt_TexCoord0*textureHeight + vec2(textureX - textureHeight*0.5,textureY - textureHeight*0.5);
    vec4 clr = texture2D(src, tex);
    gl_FragColor = clr;
}
"
    }
    
    ItemsList {
        id: itemList
        model: ListModel {
            ListElement {
                title: "origin"
                style: 0;
            }
            ListElement {
                title: "black / white"
                style: 1;
            }
            ListElement {
                title: "linear"
                style: 2;
            }
            ListElement {
                title: "floyd-steinberg"
                style: 3;
            }
        }
        
        delegate: ItemDelegate {
            text: title
            selected: style === effect.style
            
            onMouseClicked: {
                effect.style = style;
                switch(style) {
                case 0:
                    image.source = "qrc:/images/assets/portal_cube_720.png"
                    break;
                case 1:
                    image.source = "qrc:/images/assets/portal_cube_ht.png"
                    break;
                case 2:
                    image.source = "qrc:/images/assets/portal_cube_linear.png"
                    break;
                case 3:
                    image.source = "qrc:/images/assets/portal_cube_fs.png"
                    break;
                default:
                }
            }
        }
    }
    
   
    
    

}
