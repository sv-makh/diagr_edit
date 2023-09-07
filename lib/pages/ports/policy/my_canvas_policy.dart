import 'package:diagr_edit/pages/diagram_editor_page.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin MyCanvasPolicy implements CanvasPolicy {
  @override
  onCanvasTapUp(TapUpDetails details) {
    canvasWriter.model.hideAllLinkJoints();
    
    
  }

}