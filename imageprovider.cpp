#include "imageprovider.h"
#include <opencv/cv.h>
#include "opencv/opencvutils.h"
#include <QMutexLocker>

ImageProvider::ImageProvider()
    : QQuickImageProvider(QQmlImageProviderBase::Pixmap)
{
    pixmap.load(":/images/assets/portal_cube_720.png");
}

QPixmap ImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{   
    QStringList val = id.split("/");
    int style = val[0].toInt();
    colorsCount = val[1].toInt();
    if (style == 1) {
        return halfTone();
    }
    if (style == 2) {
        return floydSteinbergDithering();
    } 
    if (style == 3) {
        return halfToneColor();
    }
    if (style == 4) {
        return floydSteinbergColorDithering();    
    }
    
    
    return pixmap;
}


using namespace cv;

uchar ImageProvider::getNereastColor(uchar g)
{
    unsigned char factor = 255 / (colorsCount-1);
    
    unsigned char k = g / factor;
    unsigned  char left = g - k*factor;
    unsigned char right = (k+1)*factor - g;
    unsigned char newColor;
    if (left < right) {
        newColor = k*factor;
    } else  {
        newColor = (++k)*factor;
    }
    return newColor;
}


void ImageProvider::addError(uchar &clr, int &err) {
    int n = clr + err;
    if (n < 0) {
        clr = 0;
        err = - n;
    } else if (n > 255) {
        clr = 255;
        err = n - 255;
    } else {
        clr = n;
        err = 0;
    }    
}

QPixmap ImageProvider::halfTone()
{
    int err = 0;
    
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<uchar> img = mat;
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0;x<img.cols;++x) {
            uchar oldColor = img(y,x);
            
            // correct on error
//            addError(oldColor, err);
            img(y,x) = getNereastColor(oldColor);
        }
    }
    
    return OpenCVUtils::ToQPixmap(OpenCVUtils::ToRGB(mat));
}

QPixmap ImageProvider::halfToneColor()
{
    int err = 0;
    
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
//    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<Vec3b> img = mat;
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0;x<img.cols;++x) {
            for (int c=0;c<3;++c) {
                uchar oldColor = img(y,x)[c];
                img(y,x)[c] = getNereastColor(oldColor);
            }
        }
    }
    
    return OpenCVUtils::ToQPixmap(OpenCVUtils::ToRGB(mat));
}

QPixmap ImageProvider::linearDithering()
{
    int err = 0;
    
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<uchar> img = mat;
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0;x<img.cols;++x) {
            uchar newColor;
            uchar oldColor = img(y,x);
            
            // correct on error
                addError(oldColor, err);
            
            newColor = getNereastColor(oldColor);
            
            err += oldColor - newColor;

            img(y,x) = newColor;
        }
    }
    
   return OpenCVUtils::ToQPixmap(OpenCVUtils::ToRGB(mat));
}

QPixmap ImageProvider::bilinearDithering()
{
    int err = 0;
    
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<uchar> img = mat;
    
    QVector<int> errors(img.cols);
    errors.fill(0);
    
    for (int y=0;y<img.rows;++y) {
        err = 0;
        for (int x=0;x<img.cols;++x) {
            uchar newColor;
            uchar oldColor = img(y,x);
            
            addError(oldColor, errors[x]); 
            addError(oldColor, err);
            
            newColor = getNereastColor(oldColor);
            
            errors[x] += (oldColor - newColor) >> 1;
            err += (oldColor - newColor) >> 1;

            img(y,x) = newColor;
        }
    }
    
    return OpenCVUtils::ToQPixmap(OpenCVUtils::ToRGB(mat));    
}

QPixmap ImageProvider::floydSteinbergDithering()
{
    int err = 0, errXY = 0;
    
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<uchar> img = mat;
    
    QVector<int> errors(img.cols);
    errors.fill(0);
    
    for (int y=0;y<img.rows;++y) {
        err = 0;
        for (int x=0;x<img.cols-1;++x) {
            uchar newColor;
            uchar oldColor = img(y,x);
            
            if (x>0){
               errors[x-1]+=errXY;
            }
            
            addError(oldColor, errors[x]); 
            addError(oldColor, err);
            
            newColor = getNereastColor(oldColor);
            errors[x] += (oldColor - newColor)*(5.f/16.f);
            
            if (x>0)
                errors[x-1] += (oldColor - newColor)*(3.f/16.f);
            
            err += (oldColor - newColor)*(7.f/16.f);
            errXY = (oldColor - newColor)*(1.f/16.f);
            

            img(y,x) = newColor;
        }
    }
    
    return OpenCVUtils::ToQPixmap(OpenCVUtils::ToRGB(mat));    
}

QPixmap ImageProvider::floydSteinbergColorDithering()
{
    cv::Mat mat = OpenCVUtils::FromQPixmap(pixmap);
    
//    cv::cvtColor(mat, mat, cv::COLOR_RGB2GRAY);
    cv::Mat_<Vec3b> img = mat;
    
    QVector<QVector<int> > errors(3);
    for (int c=0;c<3;++c) {
        errors[c].resize(img.cols);
        errors[c].fill(0);
    }
    
    for (int y=0;y<img.rows;++y) {
        int err[3] = {0,0,0};
        int errXY[3] = {0,0,0};
        for (int x=0;x<img.cols-1;++x) {
            for (int c=0;c<3;++c) {
                uchar newColor;
                uchar oldColor = img(y,x)[c];
                
                if (x>0){
                   errors[c][x-1]+=errXY[c];
                }
                
                addError(oldColor, errors[c][x]); 
                addError(oldColor, err[c]);
                
                newColor = getNereastColor(oldColor);
                errors[c][x] += (oldColor - newColor)*(5.f/16.f);
                
                if (x>0)
                    errors[c][x-1] += (oldColor - newColor)*(3.f/16.f);
                
                err[c] += (oldColor - newColor)*(7.f/16.f);
                errXY[c] = (oldColor - newColor)*(1.f/16.f);
                
    
                img(y,x)[c] = newColor;
            }
        }
    }
    
    return OpenCVUtils::ToQPixmap(mat);    
}
