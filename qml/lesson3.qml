import QtQuick 2.0

import "Presentation"
import "Utils"
import "Lesson3"

OpacityTransitionPresentation {
    
//    SlideCounter {}
    textColor: "white";


    
    // first title slide
    SlideTitle {
        centeredText: "Контраст"
    }
    
    HistogramSimple {
    }
    
    HistogramSimpleGray {
    }
    
    HistogramLuma {
        
    }

}
