#define _USE_MATH_DEFINES
#include <cmath>
#include "../matplotlibcpp.h"

namespace plt = matplotlibcpp;
using namespace std;

void drawHeart();
void drawBasic();
int main(){

    for (int i=0; i<4; i++){
        int t;
        cin>>t;
        if(t){
            drawHeart();
        }else{
            drawBasic();
        }
            

    }

    return 0;
}
void drawHeart(){
    int n = 5000; // number of data points
	vector<double> x(n),y(n); 
	for(int i=0; i<n; ++i) {
		double t = 2*M_PI*i/n;
		x.at(i) = 16*sin(t)*sin(t)*sin(t);
		y.at(i) = 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t);
	}
	plt::plot(x, y, "r-", x, [](double d) { return 12.5+abs(sin(d)); }, "k-");
    string filename = "./heart.png";
    std::cout << "Saving result to " << filename << std::endl;;
    plt::save(filename);
}
void drawBasic(){
    // Prepare data.
    int n = 5000;
    std::vector<double> x(n), y(n), z(n), w(n,2);
    for(int i=0; i<n; ++i) {
        x.at(i) = i*i;
        y.at(i) = sin(2*M_PI*i/360.0);
        z.at(i) = log(i);
    }
    
    // Set the size of output image = 1200x780 pixels
    plt::figure_size(1200, 780);

    // Plot line from given x and y data. Color is selected automatically.
    plt::plot(x, y);

    // Plot a red dashed line from given x and y data.
    plt::plot(x, w,"r--");

    // Plot a line whose name will show up as "log(x)" in the legend.
    plt::named_plot("log(x)", x, z);

    // Set x-axis to interval [0,1000000]
    plt::xlim(0, 1000*1000);

    // Add graph title
    plt::title("Sample figure");

    // Enable legend.
    plt::legend();

    // save figure
    string filename = "./basic.png";
    std::cout << "Saving result to " << filename << std::endl;;
    plt::save(filename);
}