#include <pybind11/embed.h>

#include <kddockwidgets/Config.h>
#include <kddockwidgets/DockWidgetQuick.h>
#include <kddockwidgets/private/DockRegistry_p.h>
#include <kddockwidgets/FrameworkWidgetFactory.h>

#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

namespace py = pybind11;


int main(int argc, char *argv[])
{
    // Initialize the Python interpretter
    py::scoped_interpreter guard{};

    // Use QApplication instead of QGuiAppliaction (see https://stackoverflow.com/questions/34099236/qtquick-chartview-qml-object-seg-faults-causes-qml-engine-segfault-during-load/34198644)
    // QGuiApplication app(argc, argv);
    QApplication app(argc, argv);
    app.setOrganizationName("iwoithe");
    app.setApplicationName("Molar");

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    
    // Add KDDockWidgets
    KDDockWidgets::Config::self().setQmlEngine(&engine);

    const QUrl url("qrc:/ui/main.qml");
    engine.load(url);

    return app.exec();
}
