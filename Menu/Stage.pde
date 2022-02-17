//http://learningprocessing.dreamhosters.com/examples/chapter-18/example-18-1/
//Above link to code for user input example
class Stage {
  void startScreen(){
    final String TITLE = 
      "2016 Algorithm Coursework\nby Anna Huang\nAngela Pham\n\n"+
      "Part 1\n\t1a. Play the game\n\t1b. Display all Paths\n"+
      "\nPart 2\n\t2a. Play the game\n\t2b. Display all Paths\n"+
      "\t2c. Display Model walk -Not working completely-\n\t2d. Binary Tree -Not complete-\n\t0. Exit";
    
    background(0);
    textSize(15);
    text(TITLE, 80, 80);
    text("Click in this screen and type. \nPress enter to confirm", 80, 490);
    text(typing, 80, 540); //display what user is currently typing
    
    //change to next screen
    switch(letter){
      case "1a": start = false; play1 = true; rabbitTurn = true; //divert to play screen
        break;
      case "1b": start = false; record1 = true; letter = ""; //divert to data stored
        break;
      case "2a": start = false; play2 = true; cheetahTurn = true; //divert to play screen part 2
        break;
      case "2b": start = false; record2 = true; letter = ""; //divert to data stored
        break;
      case "2c": start = false; model = true; letter = ""; //divert to model walk - not working properly
        break;
      case "2d": start = false; tree = true; letter = ""; //divert to binary tree - not working at all
        break;
      case "0": exit();
    }
  }//>---------------------------------------end start screen--------------------------------------------<//
  
  //play screen
  //note: Originally 2 playscreens. Made only one play screen since for both are almost the same
  void playScreen(){
    //display and load functions
    platform.displayGrid();
    platform.displayInfo();
    rabbit.display();
    cheetah.display();
    collision.loadMap();
    
    //add first co-ordinates
    if(rab_queue.isEmpty()) rab_queue.enqueue(data.currentLoc((int)rabbit.x, (int)rabbit.y));
    if(che_queue.isEmpty()) che_queue.enqueue(data.currentLoc((int)cheetah.x, (int)cheetah.y));
    
    //if cheetah catches rabbit?
    if(rabbit.x+rabbit.w >= cheetah.x && rabbit.x <= cheetah.x+cheetah.w &&
      rabbit.y+rabbit.h >= cheetah.y && rabbit.y <= cheetah.y + cheetah.h){
      
      //turn controls off
      rabbitTurn = false;
      cheetahTurn = false;
      
      if(play1){
        play1_counter++;
        //make another queue and copy items from existing queue
        rabQ1[play1_counter].inherit(rab_queue, rabQ1[play1_counter]);
        cheQ1[play1_counter].inherit(che_queue, cheQ1[play1_counter]);
          
        //store both into linked list so can be displayed later in record
        link1[play1_counter].insert(rabQ1[play1_counter].display(), cheQ1[play1_counter].display());
        play1 = false;
      }
      else if(play2){
        play2_counter++;
        //make another queue and copy items from existing queue
        rabQ2[play2_counter].inherit(rab_queue, rabQ2[play2_counter]);
        cheQ2[play2_counter].inherit(che_queue, cheQ2[play2_counter]);
        
        //store both into linked list so can be displayed later in record
        link2[play2_counter].insert(rabQ2[play2_counter].display(), cheQ2[play2_counter].display());
        play2 = false;
      }
      end = true; //change to End Screen
    }
    //if part 2, let rabbit move by itself but check if rabbit got caught first
    else if(play2 && rabbitTurn == true && rab_stack.size() <= 2) rabbit.turn2();
  }//>-----------------------------------------end play screen----------------------------------------------<//
  
  void endScreen(){
    background(0);
    textSize(13);
    //Display paths
    text("Rabbit path: \n"+rab_queue.display(), 50, 200);
    text("Cheetah path: \n"+che_queue.display(), 50, 350);
    
    textSize(20);
    text("Game Over", 220, 100);
    text("Press enter to exit to main screen", 120, 150);
    
    if(keyPressed && key == '\n'){
      //reset Cheetah & Rabbit including queues
      rabbit.Random();
      if(rabbit.done) cheetah.Random(); //wait until rabbit done resetting first or will crash
      che_queue.dequeueAll(); //empty the queues
      rab_queue.dequeueAll();
      
      //reset stacks
      //need this for when eg: cheetah catches rabbit and cheetah.size() != 0 then stack won't reset
      if(rab_stack.size() < 2){
        int temp = rab_stack.size(); //store current stack size
        temp = 2 - temp;             //max - current stack size
        for(int i = 0; i < temp; i++) rab_stack.push(1); //add remainder stacks
      }
      if(che_stack.size() < 3){
        int temp = che_stack.size(); //store current stack size
        temp = 3 - temp;             //max - current stack size
        for(int i = 0; i < temp; i++) che_stack.push(1); //add remainder stacks
      }
      end = false; //change to Start Screen again
      start = true;
    }
  }//>------------------------------------------------end End screen-------------------------------------------------<//
  
  //Part 1 of cw
  void recordScreen1(){
    boolean appear = false;
    background(0);
    textSize(16);
    
    if(play1_counter == 0) text("Only 1 record available. Enter 0 to view"+
      "\nEnter 'e' to exit to main screen", 50, 80);
      
    else if(play1_counter > 0) text("Enter number any integer from 0 to "+play1_counter+
      " to view game data\nEnter 'e' to exit to main screen", 50, 80);
      
    else text("No data. Play the game first!\nEnter 'e' to exit to main screen", 50, 80);
    text(typing, 70, 200); //display what use is currently typing
    
    textSize(13);
    //change back to main screen or display data according to whats inputted in
    switch(letter){
      case "e": record1 = false; start = true; //change to Start Screen
        break;
      default: //display all game data (linkedList)
        try {
          if(key=='\n' && letter != ""){
            appear = !appear;
            int numBuffer = Integer.parseInt(letter); //convert string to int
            if(appear) text(link1[numBuffer].display(), 50, 140);
          }
        }
        catch(Exception e){ //catch the exception of when letter isn't an int
          text("Enter an integer!", 50, 140);
        }
    }
  }//>-------------------------------------------end record1 screen-------------------------------------------<//
  
  //Part 2 of cw
  void recordScreen2(){
    boolean appear = false;
    background(0);
    textSize(16);
    
    if(play2_counter == 0) text("Only 1 record available. Enter 0 to view"+
      "\nTo display shortest length for R or C enter 'sr' or 'sc'"+
      "\nEnter 'e' to exit to main screen", 50, 80);
      
    else if(play2_counter > 0) text("Enter number any integer from 0 to "+play2_counter+
      " to view game data\nTo display shortest length for R or C enter 'sr' or 'sc'"+
      "\nEnter 'e' to exit to main screen", 50, 80);
      
    else text("No data. Play the game first!\nEnter 'e' to exit to main screen", 50, 80);
    text(typing, 70, 200); //display what use is currently typing
    
    textSize(13);
    //change back to main screen or display data according to whats inputted in
    switch(letter){
      case "e": record2 = false; start = true; //Change to Start Screen
        break;
      case "sr": //display shortest length for rabbit
        if(key=='\n' && letter != ""){
          appear = !appear; //makes sure to display or not depending on key press
          int num = data.shortQ("rabbit"); //find shortest length for rabbit
          if(appear && num != -1) text("Shortest Length for rabbit:\nGame "+(num+1)+":\n"+rabQ2[num].display(), 50, 160);
        }
        break;
        
      case "sc": //display shortest length for cheetah
        if(key=='\n' && letter != ""){
          appear = !appear; 
          int num = data.shortQ("cheetah"); //find shortest length for cheetah
          if(appear && num != -1) text("Shortest Length for cheetah:\nGame "+(num+1)+":\n"+cheQ2[num].display(), 50, 160);
        }
        break;
        
      default: //display all game data (linkedList)
        try {
          if(key=='\n' && letter != ""){
            appear = !appear; //makes sure to display or not depending on key press
            int numBuffer = Integer.parseInt(letter); //convert string to int
            if(appear) text(link2[numBuffer].display(), 50, 160); //display only if true
          }
        }
        catch(Exception e){ //catch the exception of when letter isn't an int
          text("Enter an integer! OR 'sr', 'sc'", 50, 160);
        }
    }//end switch
  }//>-------------------------------------------end record2 screen-------------------------------------------<//
  
  void displayTree(){
    background(0);
    boolean appear = false; 
    
    int num = data.shortQ("rabbit"); //find shortest length for rabbit
    //binaryTree.addNode(cheQ2[num].display()); //<<--issue: need to get only integer
    
    textSize(18);
    if(play2_counter == 0) text("Only 1 record available. Enter 0 to view"+
      "\nEnter 'e' to exit to main screen", 50, 80);
      
    else if(play2_counter > 0) text("Enter number any integer from 0 to "+play2_counter+
      " to view game data\nEnter 'e' to exit to main screen", 50, 80);
      
    else text("No data. Play the game first!\nEnter 'e' to exit to main screen", 50, 80);
    text(typing, 70, 200); //display what use is currently typing
    
    textSize(13);
    //change back to main screen or display data according to whats inputted in
    switch(letter){
      case "e": tree = false; start = true; //change to Start Screen
        break;
      default: 
        try {
          if(key=='\n' && letter != ""){
            appear = !appear;
            int numBuffer = Integer.parseInt(letter); //convert string to int
            //if(appear) binaryTree.combine(); <<<-
          }
        }
        catch(Exception e){ //catch the exception of when letter isn't an int
          text("Enter an integer!", 50, 140);
        }
    }
  }//>-------------------------------------------end displayTree screen-------------------------------------------<//
  
  //Modelling the walk - Note: Doesn't work as intended...
  void modelWalk(){
    boolean appear = false;
    platform.displayGrid();
    
    switch(letter){
      case "e": model = false; start = true; //exit screen
        break;
      default: //whatever number entered, display the queue for it
        try {
          if(key=='\n' && letter != ""){
            appear = !appear;
            if(appear){
              int numBuffer = Integer.parseInt(letter.trim()); //convert string to int
              data.displayModel(); //display walk <<-----bug: only displays last co-ordinate
            }
          }
        }
        catch(Exception e){ //catch the exception of when letter isn't an int
          println("Enter an int!");
        }
    }
    
    //creates box to display info
    fill(0);
    stroke(255);
    rect(4, height-130, width-10, 120);
    
    fill(255);
    textSize(18);
    if(play2_counter >= 0) text("Enter number any integer from 0 to "+play2_counter+
      "\nEnter 'e' to exit screen", 10, height-100);
    else text("No data. Play the game first!\nEnter 'e' to exit to main screen", 10, height-100);
    text(typing, 10, height-25); //display what user is typing
  }
}