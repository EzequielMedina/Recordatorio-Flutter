import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';
class TareasFirebase{

  static final TareasFirebase _instancia = TareasFirebase._privado();
  static String  uri = "https://recordatorios-841a0-default-rtdb.firebaseio.com/recordatorios.json";

  TareasFirebase._privado();

  factory TareasFirebase(){
    return _instancia;
  }

  Future<List<Map<String, dynamic>>> get tareas async {
    List<Map<String, dynamic>> tareas = [];
    
    final respuesta = await http.get(Uri.parse(uri));
   
    Map<String,dynamic> datos = jsonDecode(respuesta.body);
    
    print("Map: $datos");

    datos.forEach((indice, contenido) {
      contenido['id']=indice;
      tareas.add(contenido);
    });

    
    
    return tareas;
  }

  Future<bool> agregarTarea(Map<String, dynamic> nuevaTarea) async {
    // ignore: unused_local_variable
    final respuesta = await http.post(Uri.parse(uri), body: json.encode(nuevaTarea));
    return true;
  }
  Future<bool> editarTarea(Map<String, dynamic> actualizarTarea) async{
    // ignore: unused_local_variable
    final respuesta = await http.put(Uri.parse("https://recordatorios-841a0-default-rtdb.firebaseio.com/recordatorios/${actualizarTarea['id']}.json"), body: jsonEncode(actualizarTarea));
    return true;

  }
  Future<bool> eliminarTarea(Map<String, dynamic> borrarTarea) async{
    // ignore: unused_local_variable
    final respuesta = await http.delete(Uri.parse("https://recordatorios-841a0-default-rtdb.firebaseio.com/recordatorios/${borrarTarea['id']}.json"), body: jsonEncode(borrarTarea));
    return true;

  }
  Future<bool> terminarTarea(Map<String, dynamic> tarea) async{
    // ignore: unused_local_variable
    final respuesta = await http.put(Uri.parse("https://recordatorios-841a0-default-rtdb.firebaseio.com/recordatorios/${tarea['id']}/estado.json"), body: jsonEncode(true));
    return true;

  }

}
