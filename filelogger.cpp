#include "filelogger.h"

FileLogger::FileLogger(QObject *parent) :
    QObject(parent),
    fileAppender(nullptr),
    fileAppenderQML(nullptr),
    fileAppenderNetwork(nullptr)
{

}

//Blank output, need to save so console output works later
//This will be overwritten by CuteLogger
// NOTICE that this is NOT a filelogger class function
void blank(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    (void)type;
    (void)context;
    (void)msg;
}

void FileLogger::enableLogging()
{
    if (!fileAppender)
    {
        defaultHandler = qInstallMessageHandler(blank);
        fileAppender = new RollingFileAppender();
        fileAppenderQML = new RollingFileAppender();
        fileAppenderNetwork = new RollingFileAppender();

        //fileAppender->setFileName(this->generateFileName(1));
        //fileAppenderQML->setFileName(this->generateFileName(2));
        //fileAppenderNetwork->setFileName(this->generateFileName(3));

        //fileAppender->setDetailsLevel(Logger::Trace); //Trace, Debug, Info, Warning, Error
        //fileAppender->setFormat(QLatin1String("%{time}{yyyy-MM-ddTHH:mm:ss.zzz} [%{type:-7}] <%{function} line #: %{line}> Thread ID: %{threadid} %{message}\n"));
        //fileAppender->setLogFilesLimit(30);
        //fileAppender->setDatePattern(RollingFileAppender::MonthlyRollover);
    }

//    cuteLogger->registerAppender (fileAppender);
//    cuteLogger->registerCategoryAppender("qml", fileAppenderQML);
//    cuteLogger->registerCategoryAppender("qt.network.ssl", fileAppenderNetwork);
}

//QString FileLogger::generateFileName(int type)
//{
//    QDir dir;

//#ifdef Q_OS_MAC
//    dir = QDir( QCoreApplication::applicationDirPath());

//    dir.cdUp();
//    dir.cdUp();
//    dir.cdUp();
//#else
//    QString userDataFolder = QDir::cleanPath(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
//    dir = QDir(userDataFolder);
//#endif
//    dir.mkdir("Logs");
//    QString str;
//    switch(type)
//    {
//    case 1:
//        str = "-Main";
//        break;
//    case 2:
//        str = "-QML";
//        break;
//    default:
//        str = "-Network";
//        break;
//    }

//    QString result = dir.absolutePath() + "/Logs/" + QDateTime::currentDateTime().toString("yyyy-MM-dd-hh-mm-s") + str + ".tzlog";
//    return result;
//}

//void FileLogger::disableLogging()
//{
//    qInstallMessageHandler(defaultHandler);

//    cuteLogger->removeAppender(fileAppender);
//    cuteLogger->removeAppender(fileAppenderQML);
//    cuteLogger->removeAppender( fileAppenderNetwork);
//}
