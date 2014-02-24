import QtQuick 2.0

Rectangle {
    id: rect
    width:0.35*parent.width;
    anchors.top: parent.top
    color: Qt.rgba(1,1,1,1)
    anchors.right: parent.right;
    anchors.bottom: parent.bottom;
    z: 1000;
    
    property alias model: listView.model
    property alias delegate: listView.delegate
    
    ListView {
        id: listView
        spacing: 2
       
        clip: true
        
        anchors.fill: parent
        anchors.margins: 8
        
    }
}
