#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QDebug>
#include "imagehistogram.h"
#include "qtquick2applicationviewer.h"
#include "colorconverter.h"
#include "imageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QtQuick2ApplicationViewer viewer;
    
    ColorConverter colorConverter;
    
    QString lesson = "qml/lesson4.qml";
    
    viewer.rootContext()->setContextProperty("ColorConverter", &colorConverter);
    
    if (lesson == "qml/lesson2.qml") {
        viewer.engine()->addImageProvider(QLatin1String("dither"), new ImageProvider);
        viewer.engine()->addImageProvider(QLatin1String("colorDither"), 
                                      new ImageProvider(":/images/assets/Lenna.png"));
    }
    
    if (lesson == "qml/lesson3.qml") {
        viewer.engine()->addImageProvider(QLatin1String("himage1"),
                        new ImageHistogram(":/images/assets/Lenna.png"));
        viewer.engine()->addImageProvider(QLatin1String("himage2"),
                        new ImageHistogram(":/lesson3/assets/rose.png"));        
        viewer.engine()->addImageProvider(QLatin1String("himage3"),
                        new ImageHistogram(":/lesson3/assets/girl_in_water.png"));
    }
    
    viewer.setMainQmlFile(lesson);
    
    viewer.showFullScreen();

    return app.exec();
}
