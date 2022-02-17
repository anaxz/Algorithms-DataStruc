class Cheetah extends Rabbit {
  float x, y, w, h, speed = 50;
  
  Cheetah(float x, float y){
    super(x, y);
    this.x = x;
    this.y = y;
    w = 30;
    h = 30;
  }
  
  //controls for user
  private void userControls(){
    if(key=='d' || key=='D') x += speed; //moves right
    if(key=='a' || key=='A') x -= speed; //moves left
    if(key=='s' || key=='S') y += speed; //moves down
    if(key=='w' || key=='W') y -= speed; //moves up
    
    //only enable these controls if play2 true
    //allows cheetah to move diagonal
    if(play2){
      if(key=='q' || key=='Q'){
        x -= speed;
        y -= speed;
      }
      if(key=='e' || key=='E'){
        x += speed;
        y -= speed;
      }
      if(key=='z' || key=='Z'){
        x -= speed;
        y += speed;
      }
      if(key=='c' || key=='C'){
        x += speed;
        y += speed;
      }
    }
  }
  
  //generate random co-ordinate
  private void Random(){
    super.Random(); //inherit same method from rabbit class
  }
  
  //prevents cheetah from leaving screen
  private boolean boundary(){
    if(x < 20){
      x = 25;
      return true;
    }
    else if(x+w > width-14){
      x = width-25;
      return true;
    }
    else if(y < 20){
      y = 25;
      return true;
    }
    else if(y+h > height-142){
      y = height-175;
      return true;
    }
    else return false;
  }
  
  //for when its cheetah turn
  private void turn(){
    userControls(); //only allow player to move if their turn
    
    //check if collides with blocks and screen border
    if(collision.collide("cheetah", (int) x, (int) y) == false && boundary() == false){
      if(keyPressed == true && (key=='d' || key=='D') || (key=='s' || key=='S') 
        || (key=='a' || key=='A') || (key=='w' || key=='W') && cheetahTurn 
        || (play2 && (key=='q' || key=='Q') || (key=='e' || key=='E') || (key=='Z' || key=='z') || (key=='c' || key=='C'))){
        che_queue.enqueue(data.currentLoc((int)x, (int)y)); //add current position to queue
        che_stack.pop(); //remove 1 step
        
        //if 3 steps done, rabbits turn
        if(che_stack.isEmpty()){
          rabbitTurn = true;
          cheetahTurn = false;
          che_stack.push(1); //reset stacks
          che_stack.push(2);
          che_stack.push(3);
        }
      }
    }
  }
  
  private void display(){
    noStroke();
    fill(255,0,0);
    arc(x, y, w, h, QUARTER_PI, PI+HALF_PI+QUARTER_PI);
  }
}