import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1
import "Presentation"
import "Lesson1"
import "Utils"


OpacityTransitionPresentation {
    
//    SlideCounter {}
    textColor: "white";
    
    // first title slide
    SlideTitle {
        centeredText: "Цветовые модели"
    }
    
    Slide1Im {
        source: "qrc:/images/assets/color_table.png"
    }
    
    Slide1Im {
        source: "qrc:/images/assets/SML.png"
    }
    
//    Slide1Im {
//        color: "black"
//        source: "qrc:/images/assets/AdditiveColor.png"
//    }
    
    
    // RGB model presentation
    
    Slide {
        anchors.fill: parent
        RGBmodel {
            anchors.fill: parent       
        }
    }
    
    Slide {
        anchors.fill: parent
        RGBmodelCircle {
            anchors.fill: parent       
        }
    }

    
    Slide1Im {
        color: "black"
        source: "qrc:/images/assets/Lenna.png"
    }
    
    Slide1Im {
        color: "black"
        source: "qrc:/images/assets/Lenna_zoomed.png"
    }
    
    Slide {
        anchors.fill: parent
        RGB_channels_ {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    
    Slide {
        anchors.fill: parent
        RGB_channels {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    
    
    // HSL model presentation
    Slide1Im {
        color: "silver"
        source: "qrc:/images/assets/HSV.png"
    }
    
//    Slide1Im {
//        source: "qrc:/images/assets/hsl-colors.png"
//    }
    
    Slide {
        anchors.fill: parent
        HSVmodel {
            anchors.fill: parent       
        }
    }
    
    Slide2Im {
        HSL_channels {
            anchors.fill: parent     
        }
    }
    
    Slide2Im {
        color: "silver"
        image1Source: "qrc:/images/assets/HSV.png"
        image2Source: "qrc:/images/assets/HSL.png"
    }
    
    
    Slide {
        anchors.fill: parent
        CMYmodelCircle {
            anchors.fill: parent       
        }
    }
    
    Slide {
        anchors.fill: parent
        CMYmodel {
            anchors.fill: parent       
        }
    }

    
    Slide {
        anchors.fill: parent
        CMY_channels {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    
    Slide2Im {
        image1Source: "qrc:/images/assets/1000px-CMY_ideal_version.svg.png"
        image2Source: "qrc:/images/assets/1000px-SubtractiveColor.svg.png"
    }
    
    Slide {
        anchors.fill: parent
        CMYK_channels {
            anchors.fill: parent
        }
    }
    
    Slide1Im {
         source: "qrc:/images/assets/NIEdot367.jpg"
    }    
    
    Slide1Im {
         source: "qrc:/images/assets/1000px-CMYK_screen_angles.svg.png"
    }

    
}




