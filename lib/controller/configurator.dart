import "package:human_cells/human_cells.dart";

class ConfiguratorCell extends Configuration{
  
  ConfiguratorCell(File configPath) : super.fromFile(configPath);

  DatabaseConfiguration database;

}