import 'package:diagr_edit/pages/ports/widget/port_component.dart';
import 'package:flutter/material.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagr_edit/pages/ports/widget/common_components/my_component_data.dart';

class RectComponent extends StatelessWidget {
  final ComponentData componentData;

  const RectComponent({super.key, required this.componentData});

  @override
  Widget build(BuildContext context) {
    final MyComponentData myCustomData = componentData.data;

    return Container(
      decoration: BoxDecoration(
        color: myCustomData.color,
        border: Border.all(
          width: 1,
          color: (componentData.data as MyComponentData).isHighlightVisible
              ? Colors.pinkAccent
              : Colors.grey,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}

/*class MyComponentData {
  final Color color;
  List<PortData> portData = [];
  bool isHighlightVisible = false;

  showHighlight() {
    isHighlightVisible = true;
  }

  hideHighlight() {
    isHighlightVisible = false;
  }

  MyComponentData({
    this.color = Colors.white,
  });
}*/
