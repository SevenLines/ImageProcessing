import QtQuick 2.0

import "../Presentation"
import "../Utils"


Slide2Im {
    id:slide
        
    property alias item: listView.currentIndex
    image1Source: "image://himage1/"
    image2Source: "image://himage1/hist/"
                  +histogramsModel.get(item).channel
                  +"/" 
                  +histogramsModel.get(item).name ;
    
    ListModel {
        id: histogramsModel
        property int num: 0
        ListElement {
            name: "red"
            nameRu: "red"
            channel: 2
        }   
        ListElement {
            name: "lime"
            nameRu: "green"
            channel: 1
        }   
        ListElement {
            name: "blue"
            nameRu: "blue"
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
