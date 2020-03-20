

import 'package:human_cells/human_cells.dart';
import 'package:human_cells/models/cell.dart';

class Cell_controller extends ResourceController {

  Cell_controller(this.context);
  ManagedContext context;
  
 // List cell = [
  //  {'name': 'Erythrocytes','role':'delivers oxygen, carbon dioxide and sometimes nutrients all over the body','team':'Cells','faction':'Good','url':'human_cells\\lib\\images\\Erythrocytes.png'},
   // {'name': 'Neutrophils','role':'highly mobile white blood cells that are the first to react when pathogenic cells','team':'Cells','faction':'Good','url':'human_cells\\lib\\images\\Neutrophils.png'},
   // {'name': 'Thrombocytes','role':'closes wounds, fixes blood clogs','team':'Cells','faction':'Good','url':'human_cells\\lib\\images\\thrombocytes.png'}
  //];
  
  


  @Operation.get()
  Future<Response> getAllCells () async{
    final query = Query<Cell>(context);
    return Response.ok(await query.fetch());
    }
  
  @Operation.get('id')
  Future<Response> getCellById (@Bind.path('id') int id)  async{
    
    final query = Query<Cell>(context)
      ..where((Cell) => Cell.id).equalTo(id);
    final cell = await query.fetchOne();

    if(cell == null){
      return Response.notFound(body: "Cell não encontrado");
    }
    return  Response.ok(cell);
  }
  
  
  @Operation.post()
  Future<Response> addCell(@Bind.body() Cell body)async{
    final query = Query<Cell>(context)
      ..values = body;
    final cell = await query.insert();
    return Response.ok(cell);
  }
  
  @Operation.put('id')
  Future<Response> updateCell (@Bind.path('id') int id,@Bind.body() Cell body)  async{
    final query = Query<Cell>(context)
      ..values = body
      ..where((Cell body) => body.id).equalTo(id);
    
    final cell = await query.updateOne();

    if(cell == null){
      return Response.notFound(body:"Celula não pode ser Atualizada");
    }
    return Response.ok(cell);
  }
  
  @Operation.delete('id')
  Future<Response> deleteCell (@Bind.path('id') int id) async {
    final query = Query<Cell>(context)
      ..where((Cell) => Cell.id).equalTo(id);

    final deleteId = await query.delete();

    if(deleteId == null){
      return Response.notFound(body:"Celula não pode ser deletada");
    }
    return  Response.ok("Deleted successfully");
  }
  
}