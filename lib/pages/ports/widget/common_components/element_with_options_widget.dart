import 'package:flutter/material.dart';
import 'package:diagram_editor/diagram_editor.dart';

class ElementWithOptionsWidget extends StatelessWidget {
  final ComponentData componentData;
  final Widget child;

  const ElementWithOptionsWidget({super.key, required this.componentData, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
