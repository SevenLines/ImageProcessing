#ifndef COLORCONVERTER_H
#define COLORCONVERTER_H

#include <QObject>
#include <QRgb>
#include <QColor>

class ColorConverter : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE int hue(QRgb &color);
    Q_INVOKABLE int hsvSaturation(QRgb &color);
    Q_INVOKABLE int hslSaturation(QRgb &color);
    Q_INVOKABLE int lightness(QRgb &color);
    Q_INVOKABLE int value(QRgb &color);
    
    Q_INVOKABLE QColor hsv(int h, int s, int v);
    
//    Q_INVOKABLE QImage processImage(QImage image);
    
signals:
    
public slots:
    
};

#endif // COLORCONVERTER_H
