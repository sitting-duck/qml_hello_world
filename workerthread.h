#ifndef WORKERTHREAD_H
#define WORKERTHREAD_H

#include <QThread>

class WorkerThread : public QThread
{
        Q_OBJECT

signals:
    void resultReady(const QString& s);

public:
    void run() {
        QString result;

        /* expensive or blocking operation */

        emit resultReady(result);
    }
};

#endif // WORKERTHREAD_H
