import java.util.Stack;

class History {
  ArrayList<FixedPoint> now;
  float r = 20;
  Stack<ArrayList<FixedPoint>> past;
  Stack<ArrayList<FixedPoint>> future;
  
  History() {
    now = new ArrayList<FixedPoint>();
    past = new Stack<ArrayList<FixedPoint>>();
    future = new Stack<ArrayList<FixedPoint>>();
  }
  
  void addPoint(Point p) {
    if (now.size() == 1000) {
      now.remove(int(random(1000)));
    }
    now.add(p.fix());
  }
  
  void saveProgress() {
    future = new Stack();
    past.push(new ArrayList<FixedPoint>(now));
  }
  
  void undo() {
    if (past.empty()) { return; }
    future.push(new ArrayList<FixedPoint>(now));
    now = past.pop();
  }
  
  void redo() {
    if (future.empty()) { return; }
    past.push(new ArrayList<FixedPoint>(now));
    now = future.pop();
  }
  
  Point randomPoint() {
    Point p = new Point(0, 0);
    if (now.size() == 0) { return p; }
    while (!p.inField()) {
      int index = int(random(now.size()));
      Point point = now.get(index).toPoint();
      float theta = random(TWO_PI);
      float k = random(1);
      p.x = point.x + k * r * cos(theta);
      p.y = point.y + k * r * sin(theta);
    }
    return p;
  }
}
