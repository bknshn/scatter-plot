class Button {
  int x;
  int y;
  int w;
  int h;
  boolean on;
  int state;
  Button(int button_x, int button_y, int button_w, int button_h, boolean button_on, int state) {
    x = button_x;
    y = button_y;
    w = button_w;
    h = button_h;
    on = button_on;
    this.state = state;
  }
  boolean overButton(int x, int y) {
    if (this.x <= x && x <= this.x + this.w && this.y <= y && y <= this.y + this.h) {
      return true;
    } else {
      return false;
    }
  }
}
