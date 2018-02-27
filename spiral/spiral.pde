void  setup() {
  size(600,600);

}

void  draw() {
  background(0);
  
  
  translate(width/2,height/2);
  
  for(int i =0;i<360;i+=1){

float x = i*sin(i);
    float y = i*cos(i);
  
    noStroke();
    fill(255);
  ellipse(x*.75,y*.75,i/25,i/25);  
  
  }
  
}