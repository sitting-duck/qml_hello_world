#ifndef IMAGEIO_H
#define IMAGEIO_H

#include <QObject>

class ImageIO : public QObject
{
    Q_OBJECT
public:
    explicit ImageIO(QObject *parent = nullptr);

    enum LoadImageStatus {NO_ERROR, NO_IMAGE_AT_PATH};
    Q_ENUM(LoadImageStatus)

    Q_INVOKABLE LoadImageStatus loadImage(const QString& filename);

    Q_INVOKABLE QStringList getOpenFileNames(const QString &folderPath = QString(), const QString &filter = QString());

signals:

public slots:
};

#endif // IMAGEIO_H
