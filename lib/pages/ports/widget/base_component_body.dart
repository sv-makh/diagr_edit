import 'package:flutter/material.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagr_edit/pages/ports/widget/my_component_data.dart';

class BaseComponentBody extends StatelessWidget {
  final ComponentData componentData;
  final CustomPainter componentPainter;

  const BaseComponentBody({
    Key? key,
    required this.componentData,
    required this.componentPainter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyComponentData customData = componentData.data;

    return GestureDetector(
      child: CustomPaint(
        painter: componentPainter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Align(
            alignment: customData.textAlignment,
            child: Text(
              customData.text,
              style: TextStyle(fontSize: customData.textSize),
            ),
          ),
        ),
      ),
    );
  }
}