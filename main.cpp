#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "filelogger.h"
#include "controller.h"

//FileLogger fileLogger; // TO BE CONTINUED

int main(int argc, char *argv[])
{
    qmlRegisterType<Controller>("AThread", 1, 0, "Controller");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
