class Platform {
  public void displayGrid(){
    background(0);
    for(int i = 0; i < width; i+=world_w){ 
      for(int j = 0; j < height; j+=world_h){ 
        noFill();
        rect(i, j, world_w, world_h); //create rectangle
        
        stroke(0,180,0); //makes line yellow
        line(0, j, height, j); //create line for row
      }
      stroke(250,200,0); //makes line green
      line(i, 0, i, width); //create line for col
    }
  }
  
  public void displayInfo(){
    //creates box to display info
    fill(0);
    stroke(255);
    rect(4, height-130, width-10, 120);
    
    //info...
    fill(255);
    textSize(20);
    
    if(rabbitTurn){ //info for when rabbit's turn
      text("Rabbit's turn", 10, height-100);
      text(rab_stack.size()+" step left", 10, height-75); //include how many steps left
      if(play1 && rab_queue.size() == 1){
        text("Use arrow keys to move", 10, height-50); //display controls only once
      }
    }
    
    if(cheetahTurn){ //info for when cheetah's turn
      text("Cheetah's turn", 10, height-100);
      text(che_stack.size()+" step left", 10, height-75);
      if(play1 && che_queue.size() == 1){
        text("Use 'w', 's', 'a', 'd' to move", 10, height-50);
      }
    }
    
    if(play2 && che_queue.size() == 1){ //info for when cheetah's turn && play2
      text("Use 'w', 's', 'a', 'd' to move", 10, height-50);
      text("Use 'q', 'e', 'z', 'c' to move diagonally", 10, height-25);
    }
  }
}