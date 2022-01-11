cmake_minimum_required(VERSION 3.16)
project(Molar
        VERSION 0.0.1
        LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt6
find_package(Qt6 6.2 COMPONENTS Charts Core Gui Quick QuickControls2 Widgets REQUIRED)

# KDDockWidgets variables
set(KDDockWidgets_STATIC ON CACHE BOOL "Build static versions of the libraries" FORCE)
set(KDDockWidgets_QTQUICK ON CACHE BOOL "Build for QtQuick instead of QtWidgets" FORCE)
set(KDDockWidgets_EXAMPLES OFF CACHE BOOL "Build the examples" FORCE)

# Add the thirdparty directory
add_subdirectory(thirdparty)

qt_add_executable(Molar
    src/main.cpp
)

set_source_files_properties(src/ui/main.qml PROPERTIES
    QT_RESOURCE_ALIAS main.qml
)

set_source_files_properties(src/ui/delegates/FileDelegate.qml PROPERTIES
    QT_RESOURCE_ALIAS FileDelegate.qml
)

qt_add_qml_module(Molar
    URI ui
    VERSION 1.0
    QML_FILES
        src/ui/main.qml
        src/ui/delegates/AxisDelegate.qml
        src/ui/delegates/FileDelegate.qml
        # thirdparty/PapaParse/papaparse.js
)

# add_subdirectory(src/ui/delegates)
# add_subdirectory(src/ui/pages)

target_link_directories(Molar PUBLIC src
                                     thirdparty)
target_link_libraries(Molar PRIVATE Qt6::Charts
                                    Qt6::Core
                                    Qt6::Gui
                                    Qt6::Quick
                                    Qt6::QuickControls2
                                    Qt6::Widgets
                                    KDAB::kddockwidgets
                                    pybind11::embed)
