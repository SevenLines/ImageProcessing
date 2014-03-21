#include "imagehistogram.h"
#include "opencv/opencvutils.h"
#include "opencv/cv.h"
#include <QMutexLocker>

using namespace cv;

ImageHistogram::ImageHistogram(QString path)
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    pixmap.load(path);
}


QPixmap ImageHistogram::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    QMutexLocker lock();
    
    QStringList v = id.split("/");
    
    if (v.size() >0) {
        QString style = v[0];
        if (style == "hist") {
            int channel = v.size() > 1? v[1].toInt() : 0;
            QString color = v.size() > 2? v[2] : "white";
            QString backColor = v.size() > 3? v[3] : "black";
            return getHistogam(channel, color, backColor);
        }
        if (style == "luma") {
            return getGreyscale(-1);
        }
        if (style == "channel") {
            int channel = v.size() > 1? v[1].toInt() : -1;
            return getGreyscale(channel);
        }
        if (style == "contrast") {
            int k = v.size() > 1? v[1].toInt() : 0;
            QString type = v.size() > 2? v[2] : "";
            QString color = v.size() > 3? v[3]: "white";
            QString backColor = v.size() > 4? v[4]: "black";
            
            Mat img = getContrast(k);
            if (type == "hist") {
                vector<Mat> rgb;
//                cvtColor(img,img,COLOR_BGR2HLS);
                split(img, rgb);
                return getHistogam(rgb[0], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);
        }
        if (style=="normalized") {
            QString type = v.size() > 1? v[1] : "";
            QString color = v.size() > 2? v[2]: "black";
            QString backColor = v.size() > 3? v[3]: "white";
            
            Mat img = getNormalizeBrightness();
            
            if (type == "hist") {
                vector<Mat> hsv;
                cvtColor(img,img,COLOR_BGR2HSV);
                split(img, hsv);
                return getHistogam(hsv[2], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);
        }
        if (style=="HSVstretch") {
            QString type = v.size() > 1? v[1] : "";
            QString color = v.size() > 2? v[2]: "black";
            QString backColor = v.size() > 3? v[3]: "white";
            
            vector<Mat> hsv;
            Mat img = OpenCVUtils::FromQPixmap(pixmap);
            cvtColor(img,img,COLOR_BGR2HSV);
            split(img, hsv);
            
            normalizeChannel(hsv[1]);
            normalizeChannel(hsv[2]);
            merge(hsv, img);
            
            if (type == "hist") {               
//                cvtColor(img,img,COLOR_BGR2HSV);
//                split(img, hsv);
                return getHistogam(hsv[2], color, backColor);
            }
            
            cvtColor(img, img, COLOR_HSV2BGR);
            return OpenCVUtils::ToQPixmap(img);            
        }
        if (style=="huestretch") {
            QString type = v.size() > 1? v[1] : "";
            QString color = v.size() > 2? v[2]: "black";
            QString backColor = v.size() > 3? v[3]: "white";
            
            Mat img = getNormalizeHue();
            
            if (type == "hist") {
                vector<Mat> hsv;
                cvtColor(img,img,COLOR_BGR2HSV);
                split(img, hsv);
                return getHistogam(hsv[0], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);             
        }
        if (style=="colorenhance") {
            QString type = v.size() > 1? v[1] : "";
            QString color = v.size() > 2? v[2]: "black";
            QString backColor = v.size() > 3? v[3]: "white";
            
            Mat img = getNormalizeSaturation();
            
            if (type == "hist") {
                vector<Mat> hsv;
                cvtColor(img,img,COLOR_BGR2HSV);
                split(img, hsv);
                return getHistogam(hsv[1], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);             
        }
        
        // whitebalance/red/green/blue/hist/channel/color/backcolor
        if (style=="whitebalance") { 
            int red = v.size() > 1? v[1].toInt(): 255;
            int green = v.size() > 2? v[2].toInt(): 255;
            int blue = v.size() > 3? v[3].toInt(): 255;
            
            QString type = v.size() > 4? v[4]: "";
            Mat img = getWhiteBalanced(red, green, blue);
            
            if (type == "hist") {
                int channel= v.size() > 5? v[5].toInt(): 0;
                QString color = v.size() > 6? v[6]: "black";
                QString backColor = v.size() > 7? v[7]: "white";
                vector<Mat> rgb;
                split(img, rgb);
                return getHistogam(rgb[channel], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);     
        }
        if (style=="autobalance") {
            QString type = v.size() > 1? v[1] : "";
            int channel= v.size() > 2? v[2].toInt(): 0;
            QString color = v.size() > 3? v[3]: "black";
            QString backColor = v.size() > 4? v[4]: "white";
            
            Mat img = getAutoBalance();
            
            if (type == "hist") {
                vector<Mat> rgb;
                split(img, rgb);
                return getHistogam(rgb[channel], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);
        }
        if (style=="gamma") {
            int gamma = v.size() > 1? v[1].toInt() : 1;
            QString type = v.size() > 2? v[2] : "";
            QString color = v.size() > 3? v[3]: "black";
            QString backColor = v.size() > 4? v[4]: "white";
            
            Mat img = getGamma( (float)gamma / 100 );
            
            if (type == "hist") {
                vector<Mat> rgb;
                split(img, rgb);
                return getHistogam(rgb[0], color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);            
        }
       
    }
    return pixmap;
}

QPixmap ImageHistogram::getHistogam(int c, QString color, QString backColor)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    if (c>=0 && c<3) {
        vector<Mat> rgb;
        split(img, rgb);
        
        return getHistogam(rgb[c], color, backColor);
    }
    if (c==4) { // luma
        cvtColor(img, img, COLOR_BGR2GRAY);
        return getHistogam(img, color, backColor);
    }
    if (c==5) { // hue
        vector<Mat> hsv;
        cvtColor(img, img, COLOR_BGR2HSV); 
        split(img, hsv);
        return getHistogam(hsv[0], color, backColor);
    }
    if (c==6) { // HSV saturation 
        vector<Mat> hsv;
        cvtColor(img, img, COLOR_BGR2HSV); 
        split(img, hsv);
        return getHistogam(hsv[1], color, backColor);
    }
    if (c==7) { // value 
        vector<Mat> hsv;
        cvtColor(img, img, COLOR_BGR2HSV); 
        split(img, hsv);
        return getHistogam(hsv[2], color, backColor);
    }
    return QPixmap();
}

QPixmap ImageHistogram::getHistogam(Mat img, QString color, QString backColor)
{
    int bins = 256;             // number of bins
    Mat hist;       // array for storing the histograms
    Mat canvas;     // images for displaying the histogram
    int hmax = 0;      // peak value for each histogram
    
    hist = Mat::zeros(1, bins, CV_32SC1);
    
    for (int i = 0; i < img.rows; i++) {
        for (int j = 0; j < img.cols; j++) {
            uchar val = img.at<uchar>(i,j);
            hist.at<int>(val) += 1;
        }
    }
    for (int j = 0; j < bins; j++) {
        if ( hist.at<int>(j) > hmax) {
            hmax = hist.at<int>(j);
        }
    }
    
    float k = img.cols / bins;
    QColor clr(color);
    QColor backClr(backColor);

    canvas = Mat::ones(img.rows, img.cols, CV_8UC3);
    canvas = cv::Scalar(backClr.blue(),backClr.green(),backClr.red());
    
    for (int j = 0, rows = canvas.rows; j < bins; j++) {
        rectangle(canvas,
                  cv::Rect(j*k, rows - (hist.at<int>(j) * rows/hmax),
                           k,   rows),
                  Scalar(clr.blue(),clr.green(),clr.red()));
    }
    
    return OpenCVUtils::ToQPixmap(canvas);    
}

QPixmap ImageHistogram::getGreyscale(int c)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    if (c==-1) {
        cvtColor(img, img, COLOR_BGR2GRAY);
        return OpenCVUtils::ToQPixmap(img);
    }
    
    if (c>=0 && c < 3 ) {
        vector<Mat> rgb;
        split(img, rgb);
        return OpenCVUtils::ToQPixmap(rgb[c]);
    }
    if (c>4 && c <=7) {
        cvtColor(img, img, COLOR_BGR2HSV); 
        vector<Mat> hsv;
        split(img, hsv);     
        return OpenCVUtils::ToQPixmap(hsv[c-5]);
    }
    
    return QPixmap();
}

Mat ImageHistogram::getContrast(int kContrast)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
//    cvtColor(img, img, COLOR_BGR2HSV);
    
    float F = (float)(259 * (kContrast + 255)) / (255 * (259 - kContrast));
    
    Mat_<Vec3b> ref = img;
    
    for (int i = 0; i < ref.rows; i++) {
        for (int j = 0; j < ref.cols; j++) {
            for (int c=0;c<3;++c) {
                int val = ref(i,j)[c];
                val = F * (val - 128) + 128;
                ref(i,j)[c] = val>255 ? 255 : val<0 ?0 :val;
            }
        }
    }
    
//    cvtColor(img, img, COLOR_HSV2BGR);
    
    return img;
}

void ImageHistogram::normalizeChannel(Mat &img)
{
    int max = img.at<uchar>(0,0);
    int min = img.at<uchar>(0,0);
    for (int y=0;y<img.rows;++y) {
        for (int x=0; x<img.cols; ++x) {
            int val = img.at<uchar>(y,x);
            if (val > max) max = val;
            if (val < min) min = val;
        }
    }
    
    float k = 255.0f  / (max - min);
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0; x<img.cols; ++x) {
            int val = img.at<uchar>(y,x);
            int newValue = val - min;
            newValue *= k;
            img.at<uchar>(y,x) = newValue;
        }
    }
}

Mat ImageHistogram::getNormalizeBrightness()
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    cvtColor(img, img, COLOR_BGR2HSV);

    vector<Mat> hsv;
    split(img, hsv);
    normalizeChannel(hsv[2]);
    merge(hsv,img);
    
    cvtColor(img, img, COLOR_HSV2BGR);
    return img;
}

Mat ImageHistogram::getNormalizeSaturation()
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    cvtColor(img, img, COLOR_BGR2HSV);

    vector<Mat> hsv;
    split(img, hsv);
    normalizeChannel(hsv[1]);
    merge(hsv,img);
    
    cvtColor(img, img, COLOR_HSV2BGR);
    return img;    
}

Mat ImageHistogram::getNormalizeHue()
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    cvtColor(img, img, COLOR_BGR2HSV);

    vector<Mat> hsv;
    split(img, hsv);
    normalizeChannel(hsv[0]);
    merge(hsv,img);
    
    cvtColor(img, img, COLOR_HSV2BGR);
    return img;      
}

Mat ImageHistogram::getWhiteBalanced(int red, int green, int blue)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    
    float kR = 255.0f / red;
    float kG = 255.0f / green;
    float kB = 255.0f / blue;
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0; x<img.cols; ++x) {
            int r = img.at<Vec3b>(y,x)[2];
            int g = img.at<Vec3b>(y,x)[1];
            int b = img.at<Vec3b>(y,x)[0];
            
            img.at<Vec3b>(y,x)[2] = qMin(255.0f, r*kR);
            img.at<Vec3b>(y,x)[1] = qMin(255.0f, g*kG);
            img.at<Vec3b>(y,x)[0] = qMin(255.0f, b*kB);
        }
    }
    return img;
}

Mat ImageHistogram::getAutoBalance()
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);

    vector<Mat> rgb;
    split(img, rgb);
    
    normalizeChannel(rgb[0]);
    normalizeChannel(rgb[1]);
    normalizeChannel(rgb[2]);
    
    merge(rgb, img);
    
    return img;    
}

Mat ImageHistogram::getGamma(float k)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    
    vector<uchar> lut(256);
    for (int i=0;i<256;++i) {
        lut[i] = pow((float)i / 255, k) * 255;
    }
    
    for (int y=0;y<img.rows;++y) {
        for (int x=0; x<img.cols; ++x) {
            float r = img.at<Vec3b>(y,x)[2];
            float g = img.at<Vec3b>(y,x)[1];
            float b = img.at<Vec3b>(y,x)[0];
            
            img.at<Vec3b>(y,x)[2] = lut[r];
            img.at<Vec3b>(y,x)[1] = lut[g];
            img.at<Vec3b>(y,x)[0] = lut[b];
        }
    }
    return img;
}
