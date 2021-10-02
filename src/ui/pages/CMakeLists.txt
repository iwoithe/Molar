set_source_files_properties(homepage/HomePage.qml PROPERTIES
    QT_RESOURCE_ALIAS HomePage.qml
)

qt_add_qml_module(pages
    URI ui.pages
    VERSION 1.0
    QML_FILES homepage/HomePage.qml
)
