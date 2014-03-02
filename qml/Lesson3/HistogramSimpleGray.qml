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
                  +"/" 
                  +histogramsModel.get(item).name ;
    
    ListModel {
        id: histogramsModel
        property int num: 0
        ListElement {
            name: "red"
            nameRu: "красный"
            channel: 2
        }   
        ListElement {
            name: "lime"
            nameRu: "зеленый"
            channel: 1
        }   
        ListElement {
            name: "blue"
            nameRu: "синий"
            channel: 0
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
