class Point {
  float x;
  float y;
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  FixedPoint fix() {
    float x = map(this.x, margin, area_w + margin, x_fixed_min, x_fixed_max);
    float y = map(this.y, margin, area_h + margin, y_fixed_min, y_fixed_max);
    return new FixedPoint(x, y);
  }
  boolean inField() {
    return margin <= x && x <= margin + area_w && margin <= y && y <= margin + area_h;
  }
}

class FixedPoint {
  float x;
  float y;
  FixedPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Point toPoint() {
    float x = map(this.x, x_fixed_min, x_fixed_max, margin, area_w + margin);
    float y = map(this.y, y_fixed_min, y_fixed_max, margin, area_h + margin);
    return new Point(x, y);
  }
}
