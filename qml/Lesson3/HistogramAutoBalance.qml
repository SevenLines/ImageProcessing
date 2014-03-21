import QtQuick 2.0

import "../Presentation"
import "../Utils"


Slide2Im {
    id:slide
    
    property int increment: 5
    property int item: listView.currentIndex
    
    image1Source: {
        var currentStyle = histogramsModel.get(item).style;
        switch (currentStyle) {
        case 0:
            return "image://himage1/"
        case 1:
            return "image://himage1/autobalance/"
        }
        return "image://himage1"
    }
    image2Source: {
        var currentStyle = histogramsModel.get(item).style;
        switch (currentStyle) {
        case 0:
            return "image://himage1/hist/0/black/#EEE"
        case 1:
            return "image://himage1/autobalance/hist/0/black/#EEE"
        }
        return "image://himage1"
    }
    
    ListModel {
        id: histogramsModel
        property int num: 0
        ListElement {
            name: "grey"
            nameRu: "origin"
            style: 0
        }     
        ListElement {
            name: "grey"
            nameRu: "auto balance"
            style: 1
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
            width: slide.width /2 ;
            
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
