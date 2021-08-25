import 'package:app_recordatorio/pages/form.dart';
import 'package:app_recordatorio/providers/tareas_firebase.dart';
import 'package:app_recordatorio/providers/tareas_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/routes.dart';

class Detallepage extends StatelessWidget {
  const Detallepage({Key? key}) : super(key: key);

  static final nombrepag = 'detalle';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? tarea =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
        backgroundColor: Colors.orange[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: Text(
                  '${tarea!['nombre']}',
                  style: TextStyle(fontSize: 25.0),
                )),
            Text('Descripcion'),
            Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: Text('${tarea['descripcion']}')),
            Text('Fecha'),
            Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: Text('${tarea['fecha']}')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.orange[800],
                  onPressed: () {
                    TareasFirebase().eliminarTarea(tarea);
                    Navigator.pop(context);
                  },
                  child: Text('Eliminar'),
                ),
                RaisedButton(
                  color: Colors.orange[700],
                  onPressed: () => Navigator.pushNamed(
                      context, FormPage.nombrePag,
                      arguments: tarea),
                  child: Text('editar'),
                ),
                RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      TareasFirebase().terminarTarea(tarea);
                      Navigator.pop(context);
                    },
                    child: Text('Terminar')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
