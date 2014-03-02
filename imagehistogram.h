#ifndef IMAGEHISTOGRAM_H
#define IMAGEHISTOGRAM_H

#include <QQuickImageProvider>
#include "opencv/opencvutils.h"
#include "opencv/cv.h"

class ImageHistogram : public QQuickImageProvider 
{
    QPixmap pixmap;
    
public:
    explicit ImageHistogram(QString path);
    
    // QQuickImageProvider interface
public:
    virtual QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
    
private:
    /**
     * @brief getHistogam
     * @param channel канал 0,1,2 - bgr; 4 - luma
     * @param color цвет гистограммы
     * @return 
     */
    QPixmap getHistogam(int channel, QString color);
    
    // img should be in grayscale color model
    QPixmap getHistogam(cv::Mat img, QString color, QString backColor="black");
    
    QPixmap getGreyscale(int c);
    
    /**
     * @brief getContrast
     * @param kContrast value from -255 to 255
     * @return 
     */
    cv::Mat getContrast(int kContrast);
    
};

#endif // IMAGEHISTOGRAM_H
