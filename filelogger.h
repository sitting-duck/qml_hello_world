#ifndef FILELOGGER_H
#define FILELOGGER_H

#include <QObject>
#include <QDir>
#include <QStandardPaths>
#include <QCoreApplication>

#include "RollingFileAppender.h"
#include "FileAppender.h"

class FileLogger : public QObject
{
    Q_OBJECT
public:
    explicit FileLogger(QObject* parent = nullptr); // this constuctor doesn't allow implict conversions or copy initialization

    RollingFileAppender* fileAppender;
    RollingFileAppender* fileAppenderQML;
    RollingFileAppender* fileAppenderNetwork;
    QtMessageHandler defaultHandler;

    Q_INVOKABLE void enableLogging();
//    Q_INVOKABLE void disableLogging();
//    QString generateFileName(int type);

};

#endif // FILELOGGER_H
