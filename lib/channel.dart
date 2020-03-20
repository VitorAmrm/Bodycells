import 'human_cells.dart';
import 'controller/configurator.dart';
import 'controller/cell_controller.dart';
/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class HumanCellsChannel extends ApplicationChannel {
  ManagedContext context;
  @override
  Future prepare() async {
    
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
     
     final config = ConfiguratorCell(File(options.configurationFilePath));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username, 
      config.database.password, 
      config.database.host, 
      config.database.port, 
      config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);
  
  
  }

  @override
  Controller get entryPoint {
    final router = Router();
    //
    router
      .route("/Cells/[:id]")
      .link(() => Cell_controller(context));
    //
    router
      .route("/comoUsar")
      .linkFunction((request) async {
      final client = await File('client.html').readAsString();
      return Response.ok(client)..contentType = ContentType.html;
    });
    //
    return router;
  }
}