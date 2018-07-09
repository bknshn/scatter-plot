class Button {
  int x;
  int y;
  int w;
  int h;
  boolean on;
  int state;
  color c;
  color c_on;
  Button(int x, int y, int w, int h, boolean on, int state, int gray) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.on = on;
    this.state = state;
    this.c = color(gray);
    this.c_on = color(100, 100, 100);
  }
  int rightSide() {
    return x + w;
  }
  boolean overButton(Point p) {
    if (this.x <= p.x && p.x <= this.x + this.w && this.y <= p.y && p.y <= this.y + this.h) {
      return true;
    } else {
      return false;
    }
  }
  void show() {
    stroke(0);
    fill(c);
    rect(x, y, w, h);
    if (on) {
      fill(0);
      textSize(32);
      text("ON", x + 25, y + 60);
    }
  }
}

Button button_eraser = new Button(0, margin * 2 + area_h, 100, 100, false, DrawState.ERASE, 255);
Button button_circle = new Button(button_eraser.rightSide(), margin * 2 + area_h, 100, 100, false, DrawState.CIRCLE, 200);
Button button_line = new Button(button_circle.rightSide(), margin * 2 + area_h, 100, 100, false, DrawState.LINE, 150);
Button[] buttons = { button_eraser, button_circle, button_line };
