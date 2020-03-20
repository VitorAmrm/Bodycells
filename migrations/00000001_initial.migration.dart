import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Cell", 
                          [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
                          SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),
                          SchemaColumn("role", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
                          SchemaColumn("faction", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
                          SchemaColumn("imageurl", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    final List<Map> cells =[
      {'name': 'Erythrocytes',
      'role':'delivers oxygen, carbon dioxide and sometimes nutrients all over the body',
      'faction':'Good',
      'imageurl':'human_cells\\lib\\images\\Erythrocytes.png'},
      
      {'name': 'Neutrophils',
      'role':'highly mobile white blood cells that are the first to react when pathogenic cells',
      'faction':'Good',
      'url':'human_cells\\lib\\images\\Neutrophils.png'},

      {'name': 'Thrombocytes',
      'role':'closes wounds, fixes blood clogs',
      'faction':'Good',
      'imageurl':'human_cells\\lib\\images\\thrombocytes.png'}
    
    ];
  
    for (final cell in cells){
      await database.store.execute("INSERT INTO _Cell (name, role, faction, imageurl) VALUES (@name,@role,@faction,@imageurl)",
      substitutionValues: {"name":cell["name"],
                          "role":cell["role"],
                          "faction":cell["faction"],
                          "imageurl":cell["imageurl"]}
      );
    }
  }
}
    