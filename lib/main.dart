
import 'package:diagr_edit/pages/diagram_editor_page.dart';
import 'package:diagr_edit/pages/ports/diagram_editor_ports.dart';
import 'package:diagr_edit/pages/my_home_page.dart';
import 'package:diagr_edit/pages/shape_editor_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/diagram_editor': (context) => const DiagramEditorPage(),
        '/shape_editor': (context) => const ShapeEditorPage(),
        '/diagram_editor_ports': (context) => const DiagramEditorPorts(),
      },
    );
  }
}

