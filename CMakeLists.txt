cmake_minimum_required(VERSION 3.16)
project(Molar
        VERSION 0.0.1
        LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Gui Quick QuickControls2 REQUIRED)

qt_add_executable(Molar
    src/main.cpp
)

set_source_files_properties(src/ui/main.qml PROPERTIES
    QT_RESOURCE_ALIAS main.qml
)

qt_add_qml_module(Molar
    URI ui
    VERSION 1.0
    QML_FILES src/ui/main.qml)

target_link_libraries(Molar PRIVATE Qt6::Gui Qt6::Quick Qt6::QuickControls2)
