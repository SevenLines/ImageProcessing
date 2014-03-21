# Add more folders to ship with the application, here
folder_01.source = qml
folder_01.target = .
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    colorconverter.cpp \
    imageprovider.cpp \
    ../_UTILS/opencv/opencvutils.cpp \
    imagehistogram.cpp \
    ../_UTILS/opencv/imagefilters.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

QT += widgets quick

OTHER_FILES += \
    qml/* \
    assets/* \ 
    qml/Lesson3/HistogramWhiteBalance.qml \
    qml/Lesson4/MeanBlur.qml


MOC_DIR = moc
OBJECTS_DIR = obj

RESOURCES += \
    images.qrc \
    shaders.qrc \
    lesson3.qrc \
    lesson4.qrc

HEADERS += \
    colorconverter.h \
    imageprovider.h \
    ../_UTILS/opencv/opencvutils.h \
    imagehistogram.h \
    ../_UTILS/opencv/imagefilters.h

INCLUDEPATH += ../_UTILS/ 

win32 {
    INCLUDEPATH += d:/_OpenCV/include/
    LIBS += -Ld:/_OpenCV/build/x86/ming48/lib
    LIBS += -lopencv_imgproc246.dll -lopencv_core246.dll -lopencv_highgui246.dll
}

unix {
    PKGCONFIG += opencv
    LIBS += -lopencv_core -lopencv_highgui -lopencv_imgproc
}

FORMS +=
