function setup() {
  createCanvas(windowWidth, windowHeight);

}

function draw() {
  background(0);
  
  
  translate(width/2,height/2);
  
  for(var i =0;i<360;i+=1){

var x = i*sin(i);
    var y = i*cos(i);
  
    noStroke();
    fill(255);
  ellipse(x*.75,y*.75,i/25,i/25);  
  
  }
  
}