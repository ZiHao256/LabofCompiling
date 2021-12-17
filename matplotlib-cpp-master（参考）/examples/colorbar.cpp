#define _USE_MATH_DEFINES
#include <cmath>
#include <iostream>
#include "../matplotlibcpp.h"

using namespace std;
namespace plt = matplotlibcpp;

int main()
{
    // Prepare data
    int ncols = 500, nrows = 300;
    std::vector<float> z(ncols * nrows);
    for (int j=0; j<nrows; ++j) {
        for (int i=0; i<ncols; ++i) {
            z.at(ncols * j + i) = std::sin(std::hypot(i - ncols/2, j - nrows/2));
        }
    }

    const float* zptr = &(z[0]);
    const int colors = 1;

    plt::title("My matrix");
    PyObject* mat;
    plt::imshow(zptr, nrows, ncols, colors, {}, &mat);
    plt::colorbar(mat);
    const char* filename = "./color.png";
    std::cout << "Saving result to " << filename << std::endl;;
    plt::save(filename);
    // Show plots
    plt::show();
    plt::close();
    Py_DECREF(mat);
}
