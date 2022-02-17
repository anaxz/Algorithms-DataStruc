class Rabbit {
  float x, y, w, h, speed = 50;
  boolean done;
  
  Rabbit(float x, float y){
    this.x = x; 
    this.y = y;
    w = 28;
    h = 28;
  }
  
  //controls for user
  private void userControls(){
    if(key == CODED){
      if(keyCode == RIGHT) x += speed; //moves right
      if(keyCode == LEFT) x -= speed; //moves left
      if(keyCode == DOWN) y += speed; //moves down
      if(keyCode == UP) y -= speed; //moves up
    }
  }
  
  //generate random co-ordinate
  private void Random(){
    done = false; //reset everytime Random() is used
    
    while(done == false){ //(min, max-min)+min
      int rx = (int)random(25, width-25)+25;
      int ry = (int)random(25, height-155)+25;
      
      //if mod of 25, make new co-ordiantes
      //Made it not mod of 10 as not within grid or would appear between two cells
      if(rx % 25 == 0 && ry % 25 == 0 && rx % 10 != 0 && ry % 10 != 0){
        x = rx;
        y = ry;
        if(collision.matrix[(int)x/world_w][(int)y/world_h] != 1){ //if x & y not on a block
          if(!(rabbit.x+rabbit.w >= cheetah.x && rabbit.x <= cheetah.x+cheetah.w &&
            rabbit.y+rabbit.h >= cheetah.y && rabbit.y <= cheetah.y + cheetah.h)){ //if not same postion as cheetah
            done = true; //stop Random()
          }
        }
      }
    }
  }
  
  //prevents rabbit from leaving screen
  //note: change it to boolean as when adding co-ordinates,
  //adds even when colliding with screen border
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
  
  //for when its rabbits turn - Part 1
  private void turn(){
    userControls(); //only allow player to move if their turn
    
    //check if collides with blocks and screen border
    if(collision.collide("rabbit", (int) x, (int) y) == false && boundary() == false){
      if(keyPressed == true && key == CODED && rabbitTurn){
        rab_queue.enqueue(data.currentLoc((int)x, (int)y)); //add current position to queue
        rab_stack.pop(); //remove 1 step
        //Doesn't crash because it's in void KeyPressed
        
        //if 2 steps done, cheetahs turn
        if(rab_stack.isEmpty()){
          cheetahTurn = true;
          rabbitTurn = false;
          rab_stack.push(1); //reset steps
          rab_stack.push(2);
        }
      }
    }
  }
  
  //For part 2 when it's rabbit's turn
  //Has to be separate as this has to within draw()
  private void turn2(){
    boolean moved = false;
    int temp = (int) random(1, 4)+1; //take a random integer
    
    //make the rabbit move randomly
    switch(temp){
      case 1: x += speed; moved = true;
        break;
      case 2: x -= speed; moved = true;
        break;
      case 3: y += speed; moved = true;
        break;
      case 4: y -= speed; moved = true;
        break;
    }
    //println("x: "+x+" y: "+y+" posx: "+x/world_w+" posy: "+y/world_h);
    
    //check if collides with blocks and screen border
    if(collision.collide("rabbit", (int) x, (int) y) == false && boundary() == false){
      if(moved && rabbitTurn){
        rab_queue.enqueue(data.currentLoc((int)x, (int)y)); //add current position to queue
        rab_stack.pop(); //remove 1 step
        
        //if 2 steps done, cheetahs turn
        if(rab_stack.isEmpty()){
          cheetahTurn = true;
          rabbitTurn = false;
          rab_stack.push(1); //reset stacks
          rab_stack.push(2);
          moved = false;
        }
      }
    }
  }
  
  private void display(){
    fill(255);
    noStroke();
    ellipse(x, y, w, h);
  }
}