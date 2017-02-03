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
  private Type type; 

  public Atom(Type type, float xCoordinate, float yCoordinate, float zCoordinate) {  
    this.type = type; 
    //store the coordinates and type, multiply the coordinates so that the visual representation is aesthetically pleasing 
    this.x = xCoordinate*60; 
    this.y = yCoordinate*60;
    this.z = zCoordinate*60; 
    this.type = type; 
    //radius in angstrom and colors used are conventional colors (those colors used for ochem models) 
    if (this.type.equals(Type.HYDROGEN)) {
     this.radius = Type.HYDROGEN.radius(); 
     //white
     this.atomColor = color(255, 255, 255);
     } else if (this.type.equals(Type.CARBON)) {
     this.radius = Type.CARBON.radius();
     //light black 
     this.atomColor = color(33, 47, 60);
     } else if (this.type.equals(Type.OXYGEN)) {
     this.radius = Type.OXYGEN.radius();
     //light red 
     this.atomColor = color(205, 97, 85);
     } else {
     this.radius = Type.NITROGEN.radius(); ;
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

    //each element of the atomConnections array has a double array list of positions[x][y][z]
    //this outer loop just goes through the individual elements
    for ( int i = 0; i <atomConnections.size(); i++ ) {
      //this inner for loop to go through x,y,z coordinates contained at each element of the array 
      for ( int j = 0; j < atomConnections.get(i).length; j++ ) {
        if (j ==0) {
          connectX = (float)atomConnections.get(i)[j];
        } else if (j ==1) {
          connectY = (float)atomConnections.get(i)[j];
        } else {
          connectZ = (float)atomConnections.get(i)[j];
        }
      }
      stroke(7); 
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
