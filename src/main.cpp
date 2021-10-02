#include <kddockwidgets/Config.h>
#include <kddockwidgets/DockWidgetQuick.h>
#include <kddockwidgets/private/DockRegistry_p.h>
#include <kddockwidgets/FrameworkWidgetFactory.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
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
