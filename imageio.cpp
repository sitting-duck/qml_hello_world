#include "imageio.h"
#include <QFileDialog>

ImageIO::ImageIO(QObject *parent) : QObject(parent)
{

}

ImageIO::LoadImageStatus ImageIO::loadImage(const QString &filename)
{
    qDebug ("hello there");
    return LoadImageStatus::NO_ERROR;
}

QStringList ImageIO::getOpenFileNames(const QString &folderPath, const QString &filter)
{
    QStringList filePaths;

    filePaths = QFileDialog::getOpenFileNames(0, tr("Open images"), folderPath, filter );
    return filePaths;
}
