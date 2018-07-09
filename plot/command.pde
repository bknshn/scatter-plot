static abstract class CommandType {
  static final int FINISH = 0;
  static final int UNDO = 1;
  static final int REDO = 2;
  static final int REFRESH = 3;
  static final int SAVE = 4;
}

class Command {
  int x;
  int y;
  int w;
  int h;
  color c;
  int type;
  Command(int x, int y, int w, int h, color c, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.type = type;
  }
  int rightSide() {
    return x + w;
  }
  int downSide() {
    return y + h;
  }
  boolean overCommand(Point p) {
    if (this.x <= p.x && p.x <= this.x + this.w && this.y <= p.y && p.y <= this.y + this.h) {
      return true;
    } else {
      return false;
    }
  }
  void show() {
    fill(c);
    stroke(0);
    if (type == CommandType.FINISH) {
      ellipse(x + w/2, y + h/2, w/2, h/2);
    } else {   
      rect(x, y, w, h);
    }
  }
  void execute() {
    switch (type) {
    case CommandType.FINISH:
      while (0 < history.now.size() && history.now.size() < 1000) {
        println("hoge");
        history.addPoint(history.randomPoint());
      }
      break;
    case CommandType.UNDO:
      history.undo();
      break;
    case CommandType.REDO:
      history.redo();
      break;
    case CommandType.REFRESH:
      settings();
      break;
    case CommandType.SAVE:
      save("plots.png");
      break;
    }
  }
}

Command command_finish = new Command(button_line.rightSide() + 10, margin+ 20 + area_h, 150, 150, 100, CommandType.FINISH);
Command command_undo = new Command(command_finish.rightSide() + 10, margin*2 + area_h, 30, 30, 100, CommandType.UNDO);
Command command_redo = new Command(command_undo.rightSide(), margin*2 + area_h, 30, 30, 100, CommandType.REDO);
Command command_refresh = new Command(command_finish.rightSide() + 10, command_undo.downSide(), 30, 30, color(255, 0, 0), CommandType.REFRESH);
Command command_save = new Command(command_refresh.rightSide(), command_redo.downSide(), 30, 30, 100, CommandType.SAVE);
Command[] commands = { command_finish, command_undo, command_redo, command_refresh, command_save };
