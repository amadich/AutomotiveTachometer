#include "enginesimulator.h"

#include <algorithm>

EngineSimulator::EngineSimulator(QObject *parent)
    : QObject(parent)
{
    m_timer.setInterval(16);

    connect(&m_timer, &QTimer::timeout,
            this, &EngineSimulator::updateEngine);

    m_timer.start();
}

double EngineSimulator::rpm() const
{
    return m_rpm;
}

bool EngineSimulator::accelerating() const
{
    return m_accelerating;
}

void EngineSimulator::setAccelerating(bool value)
{
    if (m_accelerating == value)
        return;

    m_accelerating = value;
    emit acceleratingChanged();
}

void EngineSimulator::updateEngine()
{
    constexpr double idleRpm = 900.0;
    constexpr double maxRpm = 9000.0;

    // RPM per second
    constexpr double accelerationRate = 3200.0;
    constexpr double decelerationRate = 2200.0;

    double dt = m_timer.interval() / 1000.0;

    if (m_accelerating) {
        m_rpm += accelerationRate * dt;
    } else {
        m_rpm -= decelerationRate * dt;
    }

    m_rpm = std::clamp(m_rpm, idleRpm, maxRpm);

    emit rpmChanged();
}
