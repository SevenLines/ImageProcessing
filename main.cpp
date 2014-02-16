#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"
#include "colorconverter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QtQuick2ApplicationViewer viewer;
    
    ColorConverter colorConverter;
    viewer.rootContext()->setContextProperty("ColorConverter", &colorConverter);
    
    viewer.setMainQmlFile(QStringLiteral("qml/lesson2.qml"));
    viewer.showFullScreen();

    return app.exec();
}
