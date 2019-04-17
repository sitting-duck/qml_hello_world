#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QThread>
#include <QDebug>

class Worker : public QObject
{
    Q_OBJECT
public:
    QThread workerThread;

    Worker();

public slots:
    void doWork(const QString& parameter) {

        qDebug() << "DO WORK";
        QString result;

        // do work here
        qDebug() << "parameter: " << parameter;

        emit resultReady(result);

    }

signals:
    void resultReady(const QString& result);

};

#endif // WORKER_H
