#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "enginesimulator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    EngineSimulator simulator;

    engine.rootContext()->setContextProperty(
        "engineSimulator",
        &simulator
        );

    engine.loadFromModule(
        "AutomotiveTachometer",
        "Main"
        );

    return app.exec();
}
