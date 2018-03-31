#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QThread>

#include "worker.h"

class Controller : public QObject
{
    Q_OBJECT

    QThread workerThread;
public:
    Controller() {
        Worker* worker = new Worker;
        worker->moveToThread(&workerThread);

        // set up signalling for deletion of the thread
        connect(&workerThread, SIGNAL(finished()), worker, SLOT(deleteLater()));

        // set up signalling for the work to actually be done in the separate thread
        connect(this, SIGNAL(operate(QString)), worker, SLOT(doWork(QString)));

        // set up signalling for when the thread is done doing the work
        connect(worker, SIGNAL(resultReady(QString)), this, SLOT(handleResults(QString)));
    }

    ~Controller() {
        workerThread.quit();
        workerThread.wait();
    }

public slots:
    void handleResults(const QString&);

signals:
    void operate(const QString&);
};

#endif // CONTROLLER_H
