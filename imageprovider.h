#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>

class ImageProvider : public QQuickImageProvider 
{
private:
    QPixmap pixmap;
    int colorsCount;
    
public:
    explicit ImageProvider(QString imagePath = ":/images/assets/portal_cube_720.png");
    
signals:
    
public slots:
    
    
    // QQuickImageProvider interface
public:
//    virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
    virtual QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
    void addError(uchar &clr, int &err);
    QPixmap linearDithering();
    QPixmap bilinearDithering();
    QPixmap floydSteinbergDithering();
    uchar getNereastColor(uchar g);
    QPixmap halfTone();
    QPixmap floydSteinbergColorDithering();
    QPixmap halfToneColor();
};

#endif // IMAGEPROVIDER_H
