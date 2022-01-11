#include <QObject>
#include <QQmlEngine>
#include <QtQml/qqmlregistration.h>
#include <QVariantList>


namespace OpenDataIO
{
    class CSV : public QObject
    {
        Q_OBJECT
        QML_ELEMENT
        QML_SINGLETON
    public:
        Q_INVOKABLE QVariantList parse(QVariantList args);
    };    
} // namespace OpenDataIO
