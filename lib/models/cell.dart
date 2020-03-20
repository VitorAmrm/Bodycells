
import 'package:human_cells/human_cells.dart';

class Cell extends ManagedObject<_Cell> implements _Cell{}



class _Cell {
  @primaryKey
  int id;
  @Column(unique:true)
  String name;
  @Column()
  @Validate.length(lessThan:200)
  String role;
  @Column()
  String faction;
  @Column()
  String imageurl;
}

