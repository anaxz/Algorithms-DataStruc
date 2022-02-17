class Collision {
  //12 by 12 grid
  //note to self: mirrored diagonal; not accurate \
  int matrix[][] = {
    {0,0,0,0,0,0,0,0,0,0,0,0}, //game info from 10th col
    {0,0,0,0,0,0,0,1,0,0,0,0},
    {0,0,1,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}, 
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0}, 
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,1,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,1,0,0,0,0}, 
    {0,0,1,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0} 
  };
  
  //Load a blocks for the grid
  public void loadMap(){
    for(int i = 0; i < width; i+=world_w){ 
      for(int j = 0; j < height; j+=world_h){
        //divide each x & y by width/height of each cell
        int a = i/world_w;
        int b = j/world_h;
        
        //create blocks
        if(matrix[a][b] == 1){
          fill(180,180,180);
          rect(i, j, world_w, world_h);
        }
      }
    }
  }
  
  //Checks if rabbit or cheetah collide with blocks
  private boolean collide(String type, int xpos, int ypos){
    xpos = xpos/world_w; //to get co-ordinates
    ypos = ypos/world_h;
    
    //if on a co-ordinate that's a block, prevent it from moving to that co-ordinate
    if(matrix[xpos][ypos] == 1){
      if(type == "rabbit"){
        if(key == CODED){
          if(keyCode == RIGHT) rabbit.x -= 50; 
          if(keyCode == LEFT) rabbit.x += 50; 
          if(keyCode == DOWN) rabbit.y -= 50; 
          if(keyCode == UP) rabbit.y += 50; 
        }
      }
      else if(type == "cheetah"){
        if(key=='d' || key=='D') cheetah.x -= 50; 
        if(key=='a' || key=='A') cheetah.x += 50; 
        if(key=='s' || key=='S') cheetah.y -= 50; 
        if(key=='w' || key=='W') cheetah.y += 50;
      }
      return true;
    }
    return false;
  }
}