import 'dart:math' as math;

import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin CustomPolicy implements PolicySet {
  List<String> componentTypes = [
    'center',
    'zero-one',
    'one_zero',
    'one-one',
    'one-two',
    'two-one',
    'two-two',
    'corners',
  ];

  deleteAllComponents() {
    canvasWriter.model.removeAllComponents();
  }


}