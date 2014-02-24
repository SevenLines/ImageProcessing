#include "colorconverter.h"
#include <QColor>
#include <QDebug>

int ColorConverter::hue(QRgb &color)
{
    return QColor(color).hslHue();
}

int ColorConverter::hsvSaturation(QRgb &color)
{
    return QColor(color).hsvSaturation();
}

int ColorConverter::hslSaturation(QRgb &color)
{
    return QColor(color).hslSaturation();
}

int ColorConverter::lightness(QRgb &color)
{
    return QColor(color).lightness();
}

int ColorConverter::value(QRgb &color)
{
    return QColor(color).value();
}

QColor ColorConverter::hsv(int h, int s, int v)
{
    return QColor::fromHsv(h,s*2.55,v*2.55);
}

