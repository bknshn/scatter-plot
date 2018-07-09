// ((x - center.x) / a)^2 + ((y - center.y) / b)^2 <= 1 
class Ellipse {
  Point center;
  float a;
  float b;
  boolean isShow;
  Ellipse() {
    this.center = new Point(0, 0);
    this.a = 0;
    this.b = 0;
    this.isShow = false;
  }
  void show() {
    if (isShow) {
      noFill();
      stroke(button_circle.c);
      ellipse(center.x, center.y, a * 2, b * 2);
    }
  }
  Point randomPoint() {
    Point p = new Point(0, 0);
    while (!p.inField()) {
      float theta = random(TWO_PI);
      float k = random(1);
      p.x = center.x + k * a * cos(theta);
      p.y = center.y + k * b * sin(theta);
    }
    return p;
  }
}
