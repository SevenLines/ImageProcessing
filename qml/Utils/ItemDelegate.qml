import QtQuick 2.2
Rectangle {
    id: rect
    width: parent.width   
    height:1.1*text.height
    
    property bool selected: false
    property alias text: text.text
    
    
    signal wheelEvent(variant wheel);
    signal mouseClicked(variant mouse);
    
    state: {
        if (selected) {
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
        color: rect.selected?"white":"black"
        id: text
        width:parent.width
        
            
        font.pixelSize: 40
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
            hoverEnabled: true; 
            
            onClicked: {
                rect.mouseClicked(mouse);
            }
            onWheel: {
                rect.wheelEvent(wheel);
            }
        }
    }
}
