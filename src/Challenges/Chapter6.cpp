// 2. and 3.

#include <cmath>

class Shape {
public:
    virtual double area() = 0;
    virtual double circ() = 0;
};

class Circle : public Shape {
public:
    Circle(double r) : radius(r) {}
    virtual double area() override {
        return M_PI * radius * radius;
    }
    virtual double circ() override {
        return 2.0 * M_PI * radius;
    }
private:
    double radius;
};

class Rect : public Shape {
public:
    Rect(double h, double w) : height(h), width(w) {}
    virtual double area() override {
        return height * width;
    }
    virtual double circ() override {
        return 2.0 * (height + width);
    }
private:
    double height, width;
};

class Square : public Shape {
public:
    Square(double w) : width(w) {}
    virtual double area() override {
        return width * width;
    }
    virtual double circ() override {
        return 4.0 * width;
    }
private:
    double width;
};
