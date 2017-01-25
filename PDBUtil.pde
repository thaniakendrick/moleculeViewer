
/* Thania Kendrick 
 This class is used to parse through the pdb file provided by the user, the pdb file contains a molecule and gives the coordinates and types of atoms that 
 are in that molecule as well as the atoms that are connected to each other  
 */

import java.io.File;
import java.io.IOException;
import java.util.*;

public class PDBUtils {
  private String atomName; 
  private int atomNumber; 
  private float x;
  private float y; 
  private float z; 
  private String type; 

  //file sent to constructor from PDBViewer class 
  public PDBUtils(File pdb) throws IOException {   
    this.type = "";
    this.atomName = "";
    this.atomNumber=0;
    this.x =0;
    this.y=0;
    this.z=0;
    getAtoms(pdb);
  }

  public ArrayList<Atom> getAtoms(File f) throws IOException {
    ArrayList<Atom> atoms = new ArrayList<Atom>();
    Scanner input = new Scanner(f);
    String checkIfAtom = "";
    while (input.hasNextLine()) {
      Scanner ls = new Scanner(input.nextLine());     
      while (ls.hasNext()) {
        checkIfAtom = ls.next(); 
        //if line of file says ATOM or HETATM then parse through file section for atom type and coordinates 
        if (checkIfAtom.equals("ATOM") || checkIfAtom.equals("HETATM")) {
          atomNumber = ls.nextInt(); 
          this.atomName = ls.next(); 
          //store different types of atom types (carbon,hydrogen, nitrogen,oxygen) to type variable 
          if (atomName.charAt(0) == 'C') {
            this.type = "CARBON";
          } else if (atomName.charAt(0) == 'H') {
            this.type= "HYDROGEN";
          } else if (atomName.charAt(0) == 'N') {
            this.type= "NITROGEN";
          } else {
            this.type= "OXYGEN";
          }
          ls.next();
          ls.next();
          //store coordinates 
          this.x = ls.nextFloat();
          this.y = ls.nextFloat();
          this.z = ls.nextFloat();
          //add coordinates and atom type to atoms array and pass to Atom class
          atoms.add(new Atom(this.type, this.x, this.y, this.z));
        }
        //if line of file says "CONECT" parse through file section to get connections 
        if (checkIfAtom.equals("CONECT")) {
          //new ArrayList every time it you come accross the CONECT string.
          List<double[]> others = new ArrayList<double[]>();
          int from = ls.nextInt(); 
          while (ls.hasNextInt()) {
            int num = ls.nextInt();
            // grab the coordinates from atom array list at index num-1
            double[] positions = atoms.get(num-1).getPosition();
            // add this to the others array list
            others.add(positions);
          }      
          //pass others array to Atom method, setConnections, at the atoms array index, from-1
          atoms.get(from-1).setConnections(others); 
        }
      }
      ls.close();
    }
    input.close(); 

    return atoms;
  }
} 