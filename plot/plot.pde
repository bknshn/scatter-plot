// data 
ArrayList<Float> x = new ArrayList<Float>();
ArrayList<Float> y = new ArrayList<Float>();

// scatterplot domain
float x_max = 100;
float x_min = 0;
float y_max = 100;
float y_min = 0;

// scatterplot settings
final int margin = 50;
final int area_w = 500;
final int area_h = 500;
final int tool_h = 100;

// set canvas size
void settings() {
  size(margin * 2 + area_w, margin * 2 + area_h + tool_h);
}

void draw() {
  background(200);
  
  drawField();
  drawDataPoints();
  drawDataPointCount();
}

void drawField() {
  fill(255);
  rect(margin, margin, area_w, area_h);
}

void drawDataPoints() {
  for(int i=0;i<x.size();i++) {
    float p_x = map(x.get(i), x_min, x_max, margin, area_w + margin);
    float p_y = map(y.get(i), y_min, y_max, margin, area_h + margin);
    
    fill(0);
    stroke(0, 0, 0);
    strokeWeight(1);
    ellipse(p_x, p_y, 5, 5);
  }
}

void drawDataPointCount() {
  fill(0);
  String count_text = String.format("Plot Count: " + x.size());
  text(count_text, margin + area_w - 100, margin * 2 + area_h);
}

void mousePressed(){
  addDataPoint();
}
void mouseDragged(){
  //addDataPoint();
}

void addDataPoint() {
  if(mouseX < margin || mouseX > margin + area_w) return;
  if(mouseY < margin || mouseY > margin + area_h) return;
  
  x.add(map(mouseX, margin, area_w + margin, x_min, x_max));
  y.add(map(mouseY, margin, area_h + margin, y_min, y_max));
  
}
