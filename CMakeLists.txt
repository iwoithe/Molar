cmake_minimum_required(VERSION 3.16)
project(Molar
        VERSION 0.0.1
        LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt6
find_package(Qt6 6.2 COMPONENTS Gui Widgets Quick QuickControls2 REQUIRED)

# KDDockWidgets
set(KDDockWidgets_STATIC ON CACHE BOOL "Build static versions of the libraries" FORCE)
set(KDDockWidgets_QTQUICK ON CACHE BOOL "Build for QtQuick instead of QtWidgets" FORCE)
set(KDDockWidgets_EXAMPLES OFF CACHE BOOL "Build the examples" FORCE)
add_subdirectory(thirdparty/KDDockWidgets)

qt_add_executable(Molar
    src/main.cpp
)

set_source_files_properties(src/ui/main.qml PROPERTIES
    QT_RESOURCE_ALIAS main.qml
)

qt_add_qml_module(Molar
    URI ui
    VERSION 1.0
    QML_FILES src/ui/main.qml
)

add_subdirectory("src/ui/pages")

target_link_libraries(Molar PRIVATE Qt6::Gui Qt6::Quick Qt6::QuickControls2 KDAB::kddockwidgets)
