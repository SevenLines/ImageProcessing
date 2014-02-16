import QtQuick 2.0
import "Presentation"
import "Utils"
import "Lesson2"

OpacityTransitionPresentation {
    
//    SlideCounter {}
    textColor: "white";
    
    // first title slide
    SlideTitle {
        centeredText: "Оттенки серого"
    }

    Slide {
        anchors.fill: parent
        Grayscale_style {
            
        }
    }
}
