/*This class asks the user for their pdb file, sets the background, and draws each atom  
 
 */

boolean fileChosen=false;
PDBUtils pdb; 
float x;
ArrayList<Atom> atoms;

void settings() {
  size(800, 800, P3D);
}
void setup() {
  selectInput("Select a file to process:", "fileSelected", dataFile("name_of_file"));
  x = 0;
  smooth();
  noStroke();
}

// This function is called after the sure has selected a valid value.
void fileSelected(File selection) throws IOException {
  // Make sure they didn't press cancel or close the window
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //  get the information from this file.
    println("User selected " + selection.getAbsolutePath());
    PDBUtils pdb = new PDBUtils(selection);
    atoms = pdb.getAtoms(selection);
    // true so the program knows
    // when to draw it.
    fileChosen = true;
  }
}

void draw() {
  tint(10);
  background(10, 35, 35);
  //allows to draw things as if the screen was centered
  // with (0,0,0) in the middle.
  translate(width/2, height/2, 5);
  // Each time, rotate along the x-axis slightly.
  mouseReleased();  
  rotateX(x*PI/360);
  rotateY(-x*PI/360); 
  x++;
  
  // If the atoms are not valid, quit early.
  if (!fileChosen) return;

  // Now, draw each atom and its connections.
  for (int i=0; i<atoms.size(); i++) {
    atoms.get(i).drawAtom();
    atoms.get(i).drawConnections();
  }
  
}

void mouseReleased() {
    if (mousePressed) {
    rotateY(mouseY*PI/360); 
    rotateX(-mouseX*PI/360);
  }
}