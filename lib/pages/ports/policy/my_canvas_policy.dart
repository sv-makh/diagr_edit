import 'package:diagr_edit/pages/ports/policy/custom_state_policy.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin MyCanvasPolicy implements CanvasPolicy, CustomStatePolicy {
  @override
  onCanvasTapUp(TapUpDetails details) {
    canvasWriter.model.hideAllLinkJoints();

    if (selectedComponentId != null) {
      hideComponentHighlight(selectedComponentId);
    } else {
      if (selectedPortId == null) {
        addComponentDataWithPorts(
            canvasReader.state.fromCanvasCoordinates(details.localPosition));
      }
    }

    deselectAllPorts();
  }
}
