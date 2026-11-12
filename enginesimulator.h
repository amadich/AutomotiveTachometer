#pragma once

#include <QObject>
#include <QTimer>

class EngineSimulator : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double rpm READ rpm NOTIFY rpmChanged)
    Q_PROPERTY(bool accelerating READ accelerating
                   NOTIFY acceleratingChanged)

public:
    explicit EngineSimulator(QObject *parent = nullptr);

    double rpm() const;
    bool accelerating() const;

    Q_INVOKABLE void setAccelerating(bool value);

signals:
    void rpmChanged();
    void acceleratingChanged();

private:
    void updateEngine();

    double m_rpm = 900.0;
    bool m_accelerating = false;

    QTimer m_timer;
};
