

import 'package:app_recordatorio/pages/home.dart';
import 'package:app_recordatorio/pages/list.dart';
import 'package:app_recordatorio/providers/tareas_firebase.dart';
import 'package:app_recordatorio/providers/tareas_providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);
  static final nombrePag = '/form';

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Map<String, dynamic>? tarea;
  DateTime fecha = DateTime.now();
  String dateStr = "hoy";
  DateTime dateInput = DateTime.now();
  void _datePresent() {
    showDatePicker(
      
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022))
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          
          dateInput = value;
          fecha = value;
          dateStr = "${fecha.day.toString()}-${fecha.month.toString()}-${fecha.year.toString()}";
          
          
        });
      }
    });
  }

  final idForm = GlobalKey<FormState>();


  Map<String, dynamic> nuevaTarea = {};



  @override
  Widget build(BuildContext context) {
     tarea = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulario'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Form(
              key: idForm,
                child: Column(
              children: [
                _crearInputNombre(),
                Divider(
                  height: 10.0,
                ),
                _crearInputDescripcion(),
                Divider(
                  height: 10.0,
                ),
                _crearInputFecha(),
                Divider(
                  height: 15.0,
                ),
                _crearButtom(context),
              ],
            )),
          ),
        ));
  }

  _crearInputNombre(){
    return TextFormField(
      initialValue:(tarea != null)? tarea!['nombre']: '',
      onSaved: (value){
        nuevaTarea['nombre']= value;
      },
      decoration: InputDecoration(
        labelText: "Nombre del Recordatorio",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    );
  }
  _crearInputDescripcion(){
    return TextFormField(
      initialValue: (tarea != null)? tarea!['descripcion']: '',
      onSaved: (value){
        nuevaTarea['descripcion']=value;
      },
      maxLines: null,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          labelText: "Descripcion del Recordatorio"),
    );
  }

  _crearInputFecha(){
    return Container(
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(5)),
          Text(
            dateInput == null
                ? 'Escoger fecha'
                : DateFormat.yMEd().format(dateInput),
            style: TextStyle(fontSize: 18),

          ),
          SizedBox(
            width: 100,
          ),
          FlatButton(
            
            child: Text(
              'Escoger Fecha',
              style: TextStyle(fontSize: 15),
            ),
            
            onPressed: _datePresent,
            
            color: Colors.orange[600],
          ),
        ],
      ),
    );
  }
  _crearButtom(BuildContext context){
    return RaisedButton(
      color: Colors.orange[600],
      onPressed: () {
        idForm.currentState!.save();
        nuevaTarea['fecha'] = dateStr;
        nuevaTarea['estado']= false;
        if(tarea != null){
          nuevaTarea['id'] = tarea!['id'];
          TareasFirebase().editarTarea(nuevaTarea);
          Navigator.pushNamed(context, Home.nombrePag);
        }else{
          TareasFirebase().agregarTarea(nuevaTarea);
          Navigator.pop(context);
          
        }
        
      },
      child: (tarea == null)?Text('Crear Recordatorio') : Text('Editar Tarea'),
    );
  }
}
