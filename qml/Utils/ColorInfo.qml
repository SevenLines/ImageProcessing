import QtQuick 2.0

Text {
    id: lableText
    text: qsTr("")
    font.bold: false
    font.pixelSize: height
    style: Text.Outline
    z: 2

    property int first: 0
    property int second: 0
    property int third: 0
    
    property string template: "%1 %2 %3"

    color: "white";
    
    function resetText() {
        lableText.text = template.arg(first).arg(second).arg(third);   
    }
    
    onFirstChanged: {
        resetText();
    }
    
    onSecondChanged: {
        resetText();  
    }
    
    onThirdChanged: {
        resetText();    
    }    
    
    onTemplateChanged: {
        resetText()
    }
    
}
