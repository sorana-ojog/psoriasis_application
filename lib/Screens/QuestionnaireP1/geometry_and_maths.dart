import 'dart:math';

class Point {
  double x; // between 0 and 1
  double y;
  Point(this.x, this.y);

  @override
  String toString() {
    return "{" + x.toString() + ", " + y.toString() + "}";
  }
}

class LineParams {
  double a;
  double b;
  double c;
  LineParams(this.a, this.b, this.c);
}

class Polygon {
  List<Point> points;
  Polygon(this.points);

  bool inArea(Point x) {
    final lines = [
      for (int i = 0; i < points.length - 1; i++) [points[i], points[i + 1]]
    ];

    int intersectionsCount = 0;

    for (var line in lines) {
      if (linesIntersect(x, Point(99999, x.y), line[0], line[1])) {
        intersectionsCount += 1;
      }
    }
    return intersectionsCount % 2 == 1;
  }

  double determinant(LineParams l1, LineParams l2) {
    return l1.a * l2.b - l2.a * l1.b;
  }

  LineParams computeLineParams(Point a, Point b) {
    double A = b.y - a.y; // y2 - y1
    double B = a.x - b.x; // x1 - x2
    double C = A * a.x + B * a.y;
    return LineParams(A, B, C);
  }

  bool linesIntersect(Point a1, Point b1, Point a2, Point b2) {
    // check if the lines [a,b] and [x,y] intersect

    LineParams l1 = computeLineParams(a1, b1);
    LineParams l2 = computeLineParams(a2, b2);

    double eps = 0.0001;

    double det = determinant(l1, l2);

    if (det == 0) {
      return false; // the lines are paralel
    } else {
      double x = (l2.b * l1.c - l1.b * l2.c) / det;
      double y = (l1.a * l2.c - l2.a * l1.c) / det;
      // intersection point of line

      // print("Point");
      // print(x);
      // print(y);
      return min(a1.x, b1.x) <= x + eps &&
          min(a2.x, b2.x) <= x + eps &&
          max(a2.x, b2.x) >= x - eps &&
          max(a1.x, b1.x) >= x - eps &&
          min(a1.y, b1.y) <= y + eps &&
          min(a2.y, b2.y) <= y + eps &&
          max(a2.y, b2.y) >= y - eps &&
          max(a1.y, b1.y) >= y - eps; // checks if point on both segments
    }
  }
}