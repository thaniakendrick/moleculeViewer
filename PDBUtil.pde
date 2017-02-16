
/* Thania Kendrick 
 
 This class is used to parse through the pdb file provided by the user, the pdb file contains a molecule and gives the coordinates and types of atoms that 
 are in that molecule as well as the atoms that are connected to each other  
 */

import java.io.File;
import java.io.IOException;

public class PDBUtils {
  private String atomName; 
  private int atomNumber; 
  private float x;
  private float y; 
  private float z; 
  private Type type; 

  //file sent to constructor from PDBViewer class 
  public PDBUtils(File pdb) throws IOException {   
    this.atomName = "";
    this.atomNumber=0;
    this.x =0;
    this.y=0;
    this.z=0;
    //send file to getAtoms method 
    tryCatch(pdb);
  }

  public void tryCatch(File f) throws IOException {
    try {
      getAtoms(f);
    }
    catch(IOException e) {
      System.out.println("Caught IOException: " + e.getMessage());
    }
  }


  public ArrayList<Atom> getAtoms(File f) throws IOException {
    //atoms array will contain the coordinates and type of atoms in the molecule 
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
          //only looking at first char because sometimes the file contains numbers after the atom that are not relevant for this model  
          switch(this.atomName.charAt(0)) {
          case 'C': 
            this.type = Type.CARBON;         
            break; 
          case 'H':
            this.type= Type.HYDROGEN;
            break;
          case 'N':
            this.type = Type.NITROGEN; 
            break; 
          default: 
            this.type = Type.OXYGEN; 
            break;
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
          //new ArrayList every time we come accross the CONECT string.
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
