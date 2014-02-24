#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include "qtquick2applicationviewer.h"
#include "colorconverter.h"
#include "imageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QtQuick2ApplicationViewer viewer;
    
    ColorConverter colorConverter;
    viewer.rootContext()->setContextProperty("ColorConverter", &colorConverter);
    
    viewer.engine()->addImageProvider(QLatin1String("tones"), new ImageProvider);
    viewer.engine()->addImageProvider(QLatin1String("dither"), new ImageProvider);
    
    viewer.setMainQmlFile(QStringLiteral("qml/lesson2.qml"));
    viewer.showFullScreen();

    return app.exec();
}
