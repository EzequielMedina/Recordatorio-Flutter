
import 'package:app_recordatorio/pages/calendar.dart';
import 'package:app_recordatorio/pages/form.dart';
import 'package:app_recordatorio/pages/list.dart';
import 'package:app_recordatorio/providers/tareas_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static final nombrePag = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    //TareasFirebase().getRecordatorios();
 
  }
  

  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recordatorio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
        bottom: TabBar(
          tabs: [
            Tab(
                icon: Icon(
              Icons.view_list,
            )),
            Tab(
              icon: Icon(Icons.calendar_view_week),
            )
          ],
          controller: controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, FormPage.nombrePag),
        backgroundColor: Colors.orange,
        child: (Icon(Icons.add)),
      ),
      body: TabBarView(
        
        children: [
          List_page(),
          Calendar_page(),
        ],
        controller: controller,
      ),
    );
  }
}
