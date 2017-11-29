#include <QGuiApplication>
#include <QQmlApplicationEngine>

#ifdef _WIN32
//#include "../../zlib/include/contrib/minizip/zip.h"
//#include "../../zlib/include/contrib/minizip/unzip.h"
#else
#include "zlib.h"
//#include "/usr/local/include/minizip/zip.h"
//#include "/usr/local/include/minizip/unzip.h"
#include "OpenImageIO/version.h"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
