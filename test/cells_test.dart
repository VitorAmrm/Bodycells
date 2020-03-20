import 'harness/app.dart';
import 'package:human_cells/models/cell.dart';

void main(){

    final harness = Harness() .. install();

    setUp(() async {
      final query = Query<Cell>(harness.application.channel.context)
        ..values.name = "nameTeste"
        ..values.role = "any function in your body"
        ..values.faction = "Good"
        ..values.imageurl = "sigalinha/siga/linha";
      await query.insert();
    });


  test("GET /cells retorna um OK",() async{
    final response = await harness.agent.get("/Cells");
    
    expectResponse(response,200);

  } );

  test("POST /Cells retorna um OK", () async{
    final response = await harness.agent.post("/Cells",body: {"name":"Erythrocit","role":"Deliver Oxygen","faction":"Good","imageurl":"globulo/vermelho.png"});

    expectResponse(response, 200,body: {"id":2,"name":"Erythrocit","role":"Deliver Oxygen","faction":"Good","imageurl":"globulo/vermelho.png"});
  });

  test("PUT /Cells/:id retorna um OK", () async{
    final response = await harness.agent.put("/Cells/1",body: {
                                                "name":"Erythrocit",
                                                "role":"Deliver Calcium(updated)",
                                                "faction":"Good",
                                                "imageurl":"globulo/vermelho.png"});

    expectResponse(response, 200,body: {"id":1,
                                        "name":"Erythrocit",
                                        "role":"Deliver Calcium(updated)",
                                        "faction":"Good",
                                        "imageurl":"globulo/vermelho.png"});
  });

  test("DELETE /Cells retorna um OK", () async{
    final response = await harness.agent.delete("/Cells/1");
    

    expectResponse(response, 200);
  });

}