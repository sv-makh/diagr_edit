import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

import '../widget/port_component.dart';
import '../widget/rect_component.dart';

mixin MyComponentDesignPolicy implements ComponentDesignPolicy {
  @override
  Widget showComponentBody(ComponentData componentData) {
    switch (componentData.type) {
      case 'component':
        return RectComponent(componentData: componentData);
      case 'port':
        return PortComponent(componentData: componentData);
      default:
        return const SizedBox.shrink();
    }
  }
}