// data 
ArrayList<Float> x_fixed_list = new ArrayList<Float>();
ArrayList<Float> y_fixed_list = new ArrayList<Float>();

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

boolean inField(int x, int y) {
  return margin <= x && x <= margin + area_w && margin <= y && y <= margin + area_h;
}

// image
PImage image_circle_button;
Button button_c = new Button(0, margin * 2 + area_h, 300, 100, false, DrawState.CIRCLE);
Button button_e = new Button(button_c.w, margin * 2 + area_h, 300, 100, false, DrawState.ERASE);
Button[] buttons = { button_c, button_e };

static abstract class DrawState {
  static final int PLOT = 0;
  static final int ERASE = 1;
  static final int CIRCLE = 2;
}
int state;

// set canvas size
void settings() {
  size(margin * 2 + area_w, margin * 2 + area_h + tool_h);
  image_circle_button = loadImage("circle.png");
  state = DrawState.PLOT;
}

void draw() {
  background(200);
  image(image_circle_button, button_c.x, button_c.y);
  fill(150);
  rect(button_e.x, button_e.y, button_e.w, button_e.h);
  
  drawField();
  drawDataPoints();
  drawDataPointCount();
}

void drawField() {
  fill(255);
  rect(margin, margin, area_w, area_h);
}

void drawDataPoints() {
  for(int i=0;i<x_fixed_list.size();i++) {
    float p_x = map(x_fixed_list.get(i), x_fixed_min, x_fixed_max, margin, area_w + margin);
    float p_y = map(y_fixed_list.get(i), y_fixed_min, y_fixed_max, margin, area_h + margin);
    
    fill(0);
    stroke(0, 0, 0);
    strokeWeight(1);
    ellipse(p_x, p_y, 5, 5);
  }
}

void addDataPoint(float x, float y) {
  x_fixed_list.add(map(x, margin, area_w + margin, x_fixed_min, x_fixed_max));
  y_fixed_list.add(map(y, margin, area_h + margin, y_fixed_min, y_fixed_max));
  
}

void drawDataPointCount() {
  fill(0);
  String count_text = String.format("Plot Count: " + x_fixed_list.size());
  text(count_text, margin + area_w - 100, margin * 2 + area_h);
  String state_text = String.format("state: " + state);
  text(state_text, margin + area_w - 100, margin * 2 + area_h + 10);
}

//void mousePressed() {
//  if (state == DrawState.PLOT) {
//    addDataPoint(mouseX, mouseY);
//  }
//}
void mouseDragged() {
  switch (state) {
    case DrawState.PLOT:
      if (inField(mouseX, mouseY)) {
        addDataPoint(mouseX, mouseY);
      }
      break;
  }
}

void mouseClicked() {
  for (Button button: buttons) {
    if (button.overButton(mouseX, mouseY)) {
      if (state == button.state) {
        state = DrawState.PLOT;
      } else {
        state = button.state;
        // hogehoge
      }
    }
  }
  switch (state) {
  case DrawState.PLOT:
    if (inField(mouseX, mouseY)) {
      addDataPoint(mouseX, mouseY);
    }
    break;
  case DrawState.CIRCLE:
    // hogehoge
    float center_x = mouseX;
    break;
  }
  println(mouseX, mouseY);
}
