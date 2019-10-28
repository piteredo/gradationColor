final int FPS = 60;
final int SCREEN_WIDTH = 1024;
final int SCREEN_HEIGHT = 768;
final int colorFrequency = 80; //width of one color

//col1R, col1G, col1B, col2R, col2G, col2B
int[] waitCounter = {0, 0, 0, 0, 0, 0};
int[] colors = {255, 0, 0, 0, 255, 0};
String[] colorMode = {"DOWN", "UP", "STAY", "STAY", "DOWN", "UP"};

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  frameRate(FPS);
}

void draw() {
  background(0);
  
  //draw gradation
  color col1 = color(colors[0], colors[1], colors[2]); //start => (255,0,0), (0,255,0)
  color col2 = color(colors[3], colors[4], colors[5]);
  for(float w=0; w<SCREEN_WIDTH; w += colorFrequency) {
    color col = lerpColor(col1, col2, w/SCREEN_WIDTH);
    noStroke();
    fill(col);
    rect(w, 0, colorFrequency, SCREEN_HEIGHT);
  }
  
  //update color
  for(int i=0; i<colors.length; i++) {
    switch(colorMode[i]){
      case "DOWN":
        colors[i]--;
        if(colors[i] <= 0) colorMode[i] = "STAY";
        break;
      case "UP":
        colors[i]++;
        if(colors[i] >= 255) colorMode[i] = "DOWN";
        break;
      case "STAY":
        waitCounter[i]++;
        if(waitCounter[i] >= 255){
          colorMode[i] = "UP";
          waitCounter[i] = 0;
        }
        break;
    }
  }
}
