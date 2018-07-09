class Line {
  ArrayList<Point> points;
  float r;
  boolean isShow;
  Line() {
    points = new ArrayList<Point>();
    r = lineRadius;
    isShow = false;
  }
  int size() {
    return points.size();
  }
  void show() {
    if (!isShow) { return; }
    for (int i = 0; i < points.size()-1; i++) {
      stroke(button_line.c);
      line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
    }
  }
      
  Point randomPoint() {
    Point p = new Point(0, 0);
    while (!p.inField()) {
      int index = int(random(points.size()));
      float theta = random(TWO_PI);
      float k = random(1);
      p.x = points.get(index).x + k * r * cos(theta);
      p.y = points.get(index).y + k * r * sin(theta);
    }
    return p;
  }
}
