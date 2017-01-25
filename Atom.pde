/*This class gets passed the coordinates, connections, and atom types from the PDBUtil class
 it then uses this information to define the size of each atom, the color, and shape. It also 
 sets up the connections between the atoms. 
 */

import java.util.*;

public  class Atom {
  private float x; 
  private float y;
  private float z; 
  private double radius;
  private List<double[]> atomConnections = new ArrayList<double[]>();
  private color atomColor; 
  private String type; 

  public Atom(String type, float xCoordinate, float yCoordinate, float zCoordinate) {  
    this.type = type; 
    this.x = xCoordinate*60; 
    this.y = yCoordinate*60;
    this.z = zCoordinate*60; 
    this.type = type; 
    //radius in angstrom and colors used are conventional colors 
    if (this.type.equals("HYDROGEN")) {
      this.radius = 53/5;
      //white
      this.atomColor = color(255, 255, 255);
    } else if (this.type.equals("CARBON")) {
      this.radius = 67/5;
      //light black 
      this.atomColor = color(33, 47, 60);
    } else if (this.type.equals("OXYGEN")) {
      this.radius = 48/5;
      //light red 
      this.atomColor = color(205, 97, 85);
    } else {
      this.radius = 149/5;
      //light blue
      this.atomColor = color(52, 152, 219);
    }
  } 

  // Will set the connections to be the requested ones.
  public void setConnections(List<double[]> conn) {
    //the array passed by the PDBUtil class is now equal to the array created in this class, atomConnections 
    atomConnections = conn;
  }

  // Will return the position as an array.
  public double[] getPosition() {
    double[] pos = new double[3];
    pos[0] = x;
    pos[1] = y;
    pos[2] = z;
    return pos;
  }

  //draw shape of atom using x,y,z coordinates
  public void drawAtom() {
    translate(this.x, this.y, this.z);
    noStroke();
    lights(); 
    fill(this.atomColor); 
    sphere((float)(this.radius*2));
    translate(-this.x, -this.y, -this.z);
  }

  //draw connections of molecule 
  public void drawConnections() {
    float connectX = 0;
    float connectY = 0;
    float connectZ = 0;

  //each element of the atomConnections array has 
    for ( int i = 0; i <atomConnections.size(); i++ ) {
      //inner for loop to go through x,y,z coordinates: [x at position 0][y at position 1][z at position 3]
      for ( int j = 0; j < atomConnections.get(i).length; j++ ) {
        if (j ==0) {
          connectX = (float)atomConnections.get(i)[j];
        } else if (j ==1) {
          connectY = (float)atomConnections.get(i)[j];
        } else {
          connectZ = (float)atomConnections.get(i)[j];
        }
      }
      stroke(10); 
      strokeWeight(5);  
      fill(213, 216, 220);
      line(this.x, this.y, this.z, connectX, connectY, connectZ);
    }
  }

  //to debug 
  public String toString() {
    return "";
  }
}