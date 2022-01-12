#include <pybind11/embed.h>
#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <pybind11/stl.h>
#include <pybind11/stl_bind.h>

#include <iostream>
#include <string>
#include <vector>

#include "csv.h"
#include <QDebug>
#include <QList>
#include <QString>
#include <QVariant>
#include <QVector>


namespace py = pybind11;
using namespace pybind11::literals;

using namespace OpenDataIO;


QVariantList CSV::parse(QVariantList args)
{
    const QString &returnData = args.at(0).toString();
    const QString &file = args.at(1).toString();

    py::list header_rows;
    py::object list_append = header_rows.attr("append");
    list_append(0);
    list_append(1);
    list_append(2);

    py::object pandas = py::module_::import("pandas");
    py::object read_csv = pandas.attr("read_csv");
    py::object result = read_csv(file.toStdString(), "header"_a=header_rows, "delimiter"_a=",", "skip_blank_lines"_a=true);
    // result = result.attr("dropna")();
    
    QVariantList data;

    if (returnData == "headers") {
        std::vector<std::vector<std::string>> headers_vector = py::list(result.attr("columns").attr("values")).cast<std::vector<std::vector<std::string>>>();

        for (int i = 0; i < headers_vector.size(); i++) {
            std::vector<std::string> header_vector = headers_vector[i];
            QString header_string = QString();
            for (int h_index = 0; h_index < header_vector.size(); h_index++) {
                QString header_i_string = QString::fromStdString(header_vector[h_index]);
                if (h_index >= header_vector[h_index].size() - 1) {
                    header_string.append(header_i_string);
                } else {
                    header_string.append(header_i_string + " ");
                }

                header_string.append(header_i_string);
            }
            data.append(header_string);
        }

    } else {
        // Default to "data"
        py::object numpy_array = result.attr("to_numpy")();
        
        std::vector<std::vector<double>> array_vector = numpy_array.cast<std::vector<std::vector<double>>>();

        std::vector<int> array_shape = numpy_array.attr("shape").cast<std::vector<int>>();
        int num_rows = array_shape[0];
        int num_columns = array_shape[1];
        
        for (int column_index = 0; column_index < num_columns; column_index++) {
            QVariantList row_data;

            for (int row_index = 0; row_index < num_rows; row_index++) {
                row_data.push_back(array_vector[row_index][column_index]);
            }

            data.push_back(row_data);
        }
    }

    return data;
}
