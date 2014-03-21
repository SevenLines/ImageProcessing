import QtQuick 2.0

import "../Presentation"
import "../Utils"


Slide2Im {
    id:slide
    
    
    property int item: listView.currentIndex
    image1Source: "image://himage1/channel/"
                  +histogramsModel.get(item).channel
    image2Source: "image://himage1/hist/"
                  +histogramsModel.get(item).channel
                  +"/black/#EEE";
    
    ListModel {
        id: histogramsModel
        property int num: 0
        ListElement {
            name: "gray"
            nameRu: "hue"
            channel: 5
        }   
        ListElement {
            name: "gray"
            nameRu: "saturation"
            channel: 6
        }   
        ListElement {
            name: "gray"
            nameRu: "value"
            channel: 7
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
            text: nameRu
            width: slide.width / histogramsModel.count
            
            defalTextColor: name
            selectedColor: name
            hoverColor: Qt.lighter(name, 1.7)
            defalColor: "white"

            onMouseClicked: {
                listView.currentIndex = index
            }
        }

    }
}
