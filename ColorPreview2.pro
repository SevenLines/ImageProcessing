# Add more folders to ship with the application, here
folder_01.source = qml/ColorPreview2
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    colorconverter.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/ColorPreview2/colorprocessing.js \
    assets/* \
    assets/HSV.png \
    assets/Lenna-CMYK_Y.png \
    assets/NIEdot367.jpg \
    assets/8a.jpg \
    assets/AdditiveColor.png \
    assets/1000px-SubtractiveColor.svg.png \
    assets/1000px-CMY_ideal_version.svg.png \
    assets/Lenna-RGB_R_.png \
    assets/Lenna-RGB_G_.png \
    assets/Lenna-RGB_B_.png \
    assets/Lenna-CMY_Y.png \
    assets/Lenna-CMY_M.png \
    assets/Lenna-CMY_C.png \
    assets/1000px-CMYK_screen_angles.svg.png \
    assets/color_table.pdf \
    qml/ColorPreview2/lesson1.qml

RESOURCES += \
    images.qrc

HEADERS += \
    colorconverter.h
