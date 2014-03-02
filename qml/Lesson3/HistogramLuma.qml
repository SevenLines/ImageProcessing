import QtQuick 2.0

import "../Presentation"
import "../Utils"


Slide2Im {
    id:slide
    
    property int increment: 5
    property int item: listView.currentIndex
    
    image1Source: "image://himage1/contrast/"+histogramsModel.get(item).contrast
    image2Source: "image://himage1/contrast/"
                  +histogramsModel.get(item).contrast
                  +"/hist/" 
                  + histogramsModel.get(item).name
                  + "/white"
    
    ListModel {
        id: histogramsModel
        property int num: 0
        ListElement {
            name: "gray"
            nameRu: "contrast"
            contrast: 0
        }     
    }
    
    ListView {
        id: listView
        anchors.bottom: slide.bottom
        width: slide.width
        height: 90
        orientation: ListView.Horizontal
        
        model: histogramsModel
        
        delegate: ItemDelegate {
            text: nameRu  + " " + contrast
            width: slide.width;
            
            defalTextColor: name
            selectedColor: name
            hoverColor: Qt.lighter(name, 1.7)
            defalColor: "white"

            onMouseClicked: {
                listView.currentIndex = index
            }
            
            onWheelEvent:  {
                var v = histogramsModel.get(slide.item).contrast;
                if (wheel.angleDelta.y > 0)
                    v+=increment;
                else
                    v-=increment;
                
                v = Math.max(-255, Math.min(v,255));
                
                histogramsModel.get(slide.item).contrast = v;
            }
        }

    }
}
