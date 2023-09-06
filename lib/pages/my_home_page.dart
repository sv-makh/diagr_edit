import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children:[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/diagram_editor');
            },
            child: const Text('diagram_editor'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/shape_editor');
            },
            child: const Text('shape_editor'),
          ),
        ]
        ),
      ),
    );
  }
}
