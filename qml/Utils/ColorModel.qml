import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 1.1


Rectangle {
    id: mainRect
    
    width: 360
    height: 360
    
    Component.onCompleted: {
        
    }
    
    property alias sliderFirst: sliderFirst
    property alias sliderSecond: sliderSecond
    property alias sliderThird: sliderThird
    property alias template: colorInfo.template
    
    ColorInfo {
        id: colorInfo
        x: 8
        y: 8
        height: 0.1* mainRect.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        first: sliderFirst.value
        second: sliderSecond.value
        third: sliderThird.value
    }

    Rectangle {
        id: sliders
        color: Qt.rgba(0,0,0,0);
        width: 92
        height: 0.3 * parent.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8

        ColorSlider {
            id: sliderSecond
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 31
            orientation: 0
        }
        
        ColorSlider {
            id: sliderThird
            anchors.left: parent.left
            anchors.leftMargin: 63
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 31
            orientation: 0
        }
        
        ColorSlider {
            id: sliderFirst
            anchors.left: parent.left
            anchors.leftMargin: 7
            anchors.top: parent.top
            anchors.topMargin: 31
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            orientation: 0

        }
    }
    
}
