import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    width: 600  
    height: 600

    Rectangle {
        id: rectangle1
        x: 146
        y: 130
        width: 200
        height: 200
        color: "#8014ff00"
        radius: height*0.5
    }
    
    Rectangle {
        id: rectangle2
        x: 200
        y: 223
        radius: height*0.5
        width: 200
        height: 200
        color: "#800075ff"
    }

    Rectangle {
        id: rectangle3
        x: 244
        y: 130
        width: 200
        height: 200
        color: "#80ff0000"
        radius: height*0.5
    }
}
