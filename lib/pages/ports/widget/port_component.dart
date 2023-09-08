import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

class PortComponent extends StatelessWidget {
  final ComponentData componentData;

  const PortComponent({super.key, required this.componentData});

  @override
  Widget build(BuildContext context) {
    final PortData portData = componentData.data;

    switch (portData.portState) {
      case PortState.hidden:
        return const SizedBox.shrink();
      case PortState.shown:
        return Port(
          color: portData.color,
          borderColor: Colors.black,
        );
      case PortState.selected:
        return Port(
          color: portData.color,
          borderColor: Colors.cyan,
        );
      case PortState.highlighted:
        return Port(
          color: portData.color,
          borderColor: Colors.amber,
        );
    }

    return const SizedBox.shrink();
  }
}

enum PortState { hidden, shown, selected, highlighted }

class Port extends StatelessWidget {
  final Color color;
  final Color borderColor;

  const Port({
    super.key,
    this.color = Colors.white,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: borderColor),
      ),
    );
  }
}

class PortData {
  final String type;
  final Color color;
  final Size size;
  final Alignment alignmentOnComponent;

  PortState portState = PortState.shown;

  PortData({
    required this.type,
    required this.color,
    required this.size,
    required this.alignmentOnComponent,
  });

  setPortState(PortState portState) {
    this.portState = portState;
  }
}