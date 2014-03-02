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
    viewer.rootContext()->setContextProperty("ColorConverter", &colorConverter);
    
    viewer.engine()->addImageProvider(QLatin1String("dither"), new ImageProvider);
    viewer.engine()->addImageProvider(QLatin1String("colorDither"), 
                                      new ImageProvider(":/images/assets/Lenna.png"));
    
    viewer.engine()->addImageProvider(QLatin1String("himage1"),
                                      new ImageHistogram(":/images/assets/Lenna.png"));
    
    viewer.setMainQmlFile(QStringLiteral("qml/lesson3.qml"));
    
    viewer.showFullScreen();

    return app.exec();
}
