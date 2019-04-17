#include "controller.h"

void Controller::handleResults(const QString& result)
{
    qDebug() << "result: " << result;
    emit finished();
}
