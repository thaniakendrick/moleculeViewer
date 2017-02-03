public enum Type {
  //Atom types 
  HYDROGEN, OXYGEN, CARBON, NITROGEN;  

  //assigns a specific radius for each atom 
  public double radius() {
    switch (this) {
    case HYDROGEN: 
      return 53/5; 
    case CARBON: 
      return 67/5;
    case OXYGEN: 
      return 48/5; 
    case NITROGEN: 
      return 149/5;
    default: 
      return 0;
    }
  }
}