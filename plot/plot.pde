History history;

// scatterplot domain
float x_fixed_max = 100;
float x_fixed_min = 0;
float y_fixed_max = 100;
float y_fixed_min = 0;

// scatterplot settings
final int margin = 50;
final int area_w = 500;
final int area_h = 500;
final int tool_h = 100;

Ellipse ellipse;
float eraser_size = 10;
Line line;
float lineRadius = 20;

static abstract class DrawState {
  static final int PLOT = 0;
  static final int ERASE = 1;
  static final int CIRCLE = 2;
  static final int LINE = 3;
}
int state;

// set canvas size
void settings() {
  size(margin * 2 + area_w, margin * 2 + area_h + tool_h);
  history = new History();
  state = DrawState.PLOT;
  ellipse = new Ellipse();
  line = new Line();
  for (Button button: buttons) {
    button.on = false;
  }
}

void draw() {
  background(200);
  for (Button button: buttons) {
    button.show();
  }
  for (Command command: commands) {
    command.show();
  }
  
  drawField();
  drawDataPoints();
  if (state == DrawState.CIRCLE) {
    ellipse.show();
  }
  if (state == DrawState.LINE) {
    line.show();
  }
  drawDataPointCount();
}

void drawField() {
  stroke(0);
  fill(255);
  rect(margin, margin, area_w, area_h);
}

void drawDataPoints() {
  for(int i=0;i<history.now.size();i++) {
    Point p = history.now.get(i).toPoint();
    
    fill(0);
    stroke(0, 0, 0);
    strokeWeight(1);
    ellipse(p.x, p.y, 5, 5);
  }
}

void drawDataPointCount() {
  fill(0);
  textSize(12);
  String count_text = String.format("Plot Count: " + history.now.size());
  text(count_text, margin + area_w - 100, margin * 2 + area_h);
}

void when_dragging_field(Point p) {
  switch (state) {
  case DrawState.PLOT:
    history.addPoint(p);
    break;
  case DrawState.ERASE:
    for (int i = 0; i < history.now.size(); i++) {
      Point p2 = history.now.get(i).toPoint();
      if (dist(p.x, p.y, p2.x, p2.y) <= eraser_size) {
        history.now.remove(i);
      }
    } 
    break;
  case DrawState.CIRCLE:
    ellipse.a = abs(mouseX - ellipse.center.x);
    ellipse.b = abs(mouseY - ellipse.center.y);
    break;
  case DrawState.LINE:
    line.points.add(p);
    break;
  }
}

void mousePressed() {
  Point p = new Point(mouseX, mouseY);
  if (p.inField()) {
    history.saveProgress();
    switch (state) {
    case DrawState.CIRCLE:
      ellipse.center = p;
      ellipse.isShow = true;
      break;
    case DrawState.LINE:
      line.isShow = true;
      break;
    }
  }
}
void mouseDragged() {
  Point p = new Point(mouseX, mouseY);
  if (p.inField()) {
    when_dragging_field(p);
  }
}
void mouseReleased() {
  switch (state) {
  case DrawState.CIRCLE:
    for (int i = 0; 500 * i < ellipse.a * ellipse.b; i++) {
      history.addPoint(ellipse.randomPoint());
    }
    ellipse = new Ellipse();
    break;
  case DrawState.LINE:
    line.isShow = false;
    for (int i = 0; i < line.size(); i++) {
      history.addPoint(line.randomPoint());
    }
    line.points.clear();
  }
}

void mouseClicked() {
  Point p = new Point(mouseX, mouseY);
  for (Button button: buttons) {
    if (button.overButton(p)) {
      if (state == button.state) {
        state = DrawState.PLOT;
        button.on = false;
      } else {
        for (Button otherButton: buttons) {
          otherButton.on = false;
        }
        state = button.state;
        button.on = true;
      }
    }
  }
  for (Command command: commands) {
    if (command.overCommand(p)) {
      command.execute();
    }
  }
}
