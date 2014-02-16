import QtQuick 2.0
import "../Utils"

ColorModel {
    template: "hue %1°\nsaturation %2\%\nvalue %3\%"
    
    
    
    color: ColorConverter.hsv(sliderFirst.value,
                   sliderSecond.value,
                   sliderThird.value)
    
    sliderFirst.maximumValue: 359
    sliderSecond.maximumValue: 100
    sliderThird.maximumValue: 100 
}
