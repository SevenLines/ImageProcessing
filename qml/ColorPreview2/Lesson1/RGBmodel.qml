import QtQuick 2.0
import QtQuick 2.0
import QtQuick.Controls 1.1
import "../Utils"

ColorModel {
    template: "r:%1\ng:%2\nb:%3"
    color: Qt.rgba(sliderFirst.value / 255,
                   sliderSecond.value / 255,
                   sliderThird.value / 255,
                   1)
    
}
