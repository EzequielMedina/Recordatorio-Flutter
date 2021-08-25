import 'package:app_recordatorio/pages/detalle.dart';
import 'package:app_recordatorio/pages/form.dart';
import 'package:app_recordatorio/pages/home.dart';
import 'package:app_recordatorio/pages/list.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        List_page.nombrePag: ((BuildContext context) => const List_page()),
        FormPage.nombrePag: ((BuildContext context) => FormPage()),
        Detallepage.nombrepag: ((BuildContext context) => const Detallepage()),
        Home.nombrePag: ((BuildContext context) => Home())
      },
      home: Home(),
    ));
  });
}
