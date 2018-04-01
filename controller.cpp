#include "controller.h"

void Controller::handleResults(const QString& result)
{
    emit finished();
}
