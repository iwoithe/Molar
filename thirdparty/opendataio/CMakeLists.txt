qt_add_qml_module(opendataio
    URI thirdparty.opendataio
    VERSION 1.0
    SOURCES
        csv.h
        csv.cpp
)

target_link_libraries(opendataio PRIVATE pybind11::embed)
