import 'package:app_recordatorio/pages/detalle.dart';
import 'package:app_recordatorio/providers/tareas_firebase.dart';
import 'package:app_recordatorio/providers/tareas_providers.dart';
import 'package:flutter/material.dart';

class List_page extends StatefulWidget {
  const List_page({Key? key}) : super(key: key);
  static final nombrePag = 'listado';
  

  @override
  State<List_page> createState() => _List_pageState();
}

class _List_pageState extends State<List_page> {
  List<Map<String, dynamic>> tareas = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: (FutureBuilder(
      future: TareasFirebase().tareas,
      builder: (BuildContext context, AsyncSnapshot respuesta) {
        if (respuesta.hasData) {
          tareas = respuesta.data;
          return respuesta.data.isNotEmpty
              ? ListView(
                  children: _crearItem(context),
                )
              : Center(
                  child: AlertDialog(
                  content: Text(
                    'Sin Tareas',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.orangeAccent[100],
                ));
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }

  List<Widget> _crearItem(BuildContext context) {
    List<Widget> temporal = [];
    for (Map<String, dynamic> tarea in tareas) {
      Widget item = ListTile(
        title: Text('${tarea['nombre']}'),
        onTap: () => Navigator.pushNamed(context, Detallepage.nombrepag,
            arguments: tarea),
        trailing: (tarea['estado'])
            ? Icon(Icons.star_border, color: Colors.yellow)
            : Icon(Icons.star),
      );
      temporal.add(item);
    }
    return temporal;
  }
}
