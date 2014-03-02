import QtQuick 2.2
Rectangle {
    id: rect
    width: parent.width   
    height:1.1*text.height
    
    property bool selected: ListView.isCurrentItem
    property alias text: text.text
    
    property string selectedColor: "orange" 
    property string selectedTextColor: "white"
    property string defalColor: "white" 
    property string defalTextColor: "black" 
    property string hoverColor: "#DDD"
    
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
            PropertyChanges {target: rect; color: selectedColor }
        },
        State {
            name: "default"
            PropertyChanges {target: rect; color: defalColor }
        },
        State {
            name: "hovered"
            PropertyChanges {target: rect; color: hoverColor}
        }

    ]
    
    transitions: [
        Transition {
            ColorAnimation {properties: "color"}
        }
    ]
    
    Text {
        color: rect.selected?selectedTextColor:defalTextColor
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
