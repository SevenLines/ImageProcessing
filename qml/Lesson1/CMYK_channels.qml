import QtQuick 2.0

Rectangle {
    id: mainRect
    
    color: "black"
    
    anchors.fill: parent
    
    Grid {
        id: gridId
        
        spacing: 4
        columns: 3
        rows: 2
        anchors.centerIn: parent
        height: parent.height
    
        Image {
            id: image  
            height: gridId.height / gridId.rows

            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna.png"
        }
        
        Image {
            id: image1  
            height: gridId.height / gridId.rows

            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-CMYK_C.png"
        }
    
        Image {
            id: image0
            height: gridId.height / gridId.rows
    
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-CMYK_M.png"
        }
        
        Image {
            id: image2
            height: gridId.height / gridId.rows
            
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-CMYK_Y.png"
        }
    
        Image {
            id: image3
            height: gridId.height / gridId.rows
    
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/assets/Lenna-CMYK_B.png"
        }
    
    }
}
