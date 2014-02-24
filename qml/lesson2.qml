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
    
    Slide1Im {
        anchors.fill: parent
        source: "qrc:/images/assets/772px-Grey_square_optical_illusion.PNG" 
    }
    
    Slide1Im {
        anchors.fill: parent
        source: "qrc:/images/assets/772px-Same_color_illusion_proof2.png" 
    }
    
    
    
    Slide {
        anchors.fill: parent
        Grayscale_style {           
        }
    }
    
    Slide {
        anchors.fill: parent;
        Dithering {
            
        }
    }
    
    
    DitheringCompare {
        
    }  
    
    DitherCompareColor {
        
    }  

        
    Slide {
        anchors.fill: parent;
        ColorReplace {
            
        }
    }
}
