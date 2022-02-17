class Data {
  //Grab current location of rabbit or cheetah
  private String currentLoc(int x, int y){
    return ("("+(int)(x/world_w)+", "+(int)(y/world_h)+")");
  }
  
  //model a walk note: Doesn't work as intended
  public void displayModel(){
    String t[] = splitTokens(cheQ2[0].display(), ", ( ) ->"); //split items that aren't int
    ArrayList <Integer> arrayX = new ArrayList <Integer> ();
    ArrayList <Integer> arrayY = new ArrayList <Integer> ();
    int num[] = int(t);
    int xpos = 0, ypos = 0;
  
    //background(0);
    for(int i = 0; i < t.length; i++){ //Split it into 2 arrays: one for x and y co-ordinate
      //int temp = Integer.parseInt(t[i].trim());
      if(i % 2 == 0) arrayX.add(num[i]); //if odd, add to arrayX
      else arrayY.add(num[i]);           //else to arrayY
    }
    //System.out.println("num:"+Arrays.toString(num));
    //println("x:"+arrayX+"y:"+arrayY);
    
    int n = -1;
    boolean button = false;
    for(int i = 0; i < width; i+=world_w){
      for(int j = 0; j < height; j+=world_h){
        n++;
        if(n >= arrayX.size() || n >= arrayY.size()){
          button = true; //if 
        }
        if(play2_counter > -1 && button == false){
          xpos = arrayX.get(n) * world_w; //get last number and mulitiply to get co-ordinates
          ypos = arrayY.get(n) * world_h;
        }
        //println("x: "+xpos+" y: "+ypos);
        
        noStroke();
        //fill in rect where C or R has been at
        if(i >= xpos && (i-30) <= xpos && j >= ypos && (j-30) <= ypos){
          fill(0, 0, 255); //<<----bug: Only fills out the last co-ordinate instead of all
        }
        else noFill();
        rect(i, j, world_w, world_h); //create rectangle
      }
    }
  }
  
  //Find the shortest length of a path
  public int shortQ(String type){
    int num = -1;
    int smallest = -1;
    
    //if only one game played, return 0 as queue[0] only available
    if(play2_counter == 0) return num = 0; 
    
    for(int i = 0; i < play2_counter; i++){
      //if current queue's size greater than next queue's size, add next queue's size
      //so then will return smallest queue length
      if(type == "rabbit" && rabQ2[i].size() > rabQ2[i+1].size()){
        
        //if next queue's size less than current smallest, change smallest
        //This makes sure to check past queues that could be smaller than next queue's size
        //I did OR smallest = -1 so as when smallest hasn't been added, add next queue's size to smallest
        if(rabQ2[i+1].size() < smallest || smallest == -1){
          num = i+1;
          smallest = rabQ2[i].size();
        }
      }
      else if(type == "cheetah" && cheQ2[i].size() > cheQ2[i+1].size()){
        if(cheQ2[i+1].size() < smallest || smallest == -1){
          num = i+1;
          smallest = cheQ2[i].size();
        }
      }
    }
    return num;
  }
}