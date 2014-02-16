import QtQuick 2.0

Rectangle {
    id: mainRect
    
    color: "black"
    
    anchors.fill: parent
    
    Grid {
        id: gridId
        
        spacing: 4
        columns: 2
        rows: 2
        anchors.centerIn: parent
        height: parent.height
    
        Image {
            id: image1  
            height: gridId.height / gridId.columns

            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna.png"
        }
    
        Image {
            id: image0
            height: gridId.height / gridId.columns
    
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-R.png"
        }
        
        Image {
            id: image2
            height: gridId.height / gridId.columns
            
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-G.png"
        }
    
        Image {
            id: image3
            height: gridId.height / gridId.columns
    
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-B.png"
        }
    
    }
}
