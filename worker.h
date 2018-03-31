#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QThread>

class Worker : public QObject
{
    Q_OBJECT
public:
    QThread workerThread;

    Worker();

public slots:
    void doWork(const QString& parameter) {

        QString result;

        // do work here

        emit resultReady(result);

    }

signals:
    void resultReady(const QString& result);

};

#endif // WORKER_H