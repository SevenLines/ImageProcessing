#include "imagehistogram.h"
#include "opencv/opencvutils.h"
#include "opencv/cv.h"

using namespace cv;

ImageHistogram::ImageHistogram(QString path)
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    pixmap.load(path);
}


QPixmap ImageHistogram::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    QStringList v = id.split("/");
    
    if (v.size() >0) {
        QString style = v[0];
        if (style == "hist") {
            int channel = v.size() > 1? v[1].toInt() : 0;
            QString color = v.size() > 2? v[2] : "black";
            return getHistogam(channel, color);
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
                return getHistogam(img, color, backColor);
            }
            return OpenCVUtils::ToQPixmap(img);
        }
    }
    return pixmap;
}

QPixmap ImageHistogram::getHistogam(int c, QString color)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    if (c>=0 && c<3) {
        vector<Mat> rgb;
        split(img, rgb);
        
        return getHistogam(rgb[c], color);
    }
    if (c==4) { // luma
        cvtColor(img, img, COLOR_BGR2GRAY);
        return getHistogam(img, color);
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
    
    return QPixmap();
}

Mat ImageHistogram::getContrast(int kContrast)
{
    Mat img = OpenCVUtils::FromQPixmap(pixmap);
    cvtColor(img, img, COLOR_BGR2GRAY);
    
    float F = (float)(259 * (kContrast + 255)) / (255 * (259 - kContrast));
    
    for (int i = 0; i < img.rows; i++) {
        for (int j = 0; j < img.cols; j++) {
            int val = img.at<uchar>(i,j);
            val = F * (val - 128) + 128;
            img.at<uchar>(i,j) = val>255 ? 255 : val<0 ?0 :val;
        }
    }
    
    return img;
}
