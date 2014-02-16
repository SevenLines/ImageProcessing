import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 1.1
import "../Utils"

ColorModel {
    template: "cyan %1\nmagenta %2\nyellow %3"
    color: Qt.rgba((100 - sliderFirst.value) / 100,
                   (100 - sliderSecond.value) / 100,
                   (100 - sliderThird.value) / 100,
                   1)
    sliderFirst.maximumValue: 100;
    sliderSecond.maximumValue: 100;
    sliderThird.maximumValue: 100;
    
}
