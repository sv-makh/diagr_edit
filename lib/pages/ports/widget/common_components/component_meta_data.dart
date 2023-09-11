import 'package:diagr_edit/pages/ports/widget/port_component.dart';
import 'package:flutter/material.dart';

class ComponentMetaData {
  Color color;
  Color borderColor;
  double borderWidth;
  String metaName;

  List<PortData> portData = [];

  String text;
  Alignment textAlignment;
  double textSize;

  bool isHighlightVisible = false;

  ComponentMetaData({
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 0.0,
    this.text = '',
    this.textAlignment = Alignment.center,
    this.textSize = 20,
    this.metaName = '',
  });

  ComponentMetaData.copy(ComponentMetaData customData)
      : this(
    color: customData.color,
    borderColor: customData.borderColor,
    borderWidth: customData.borderWidth,
    text: customData.text,
    textAlignment: customData.textAlignment,
    textSize: customData.textSize,
    metaName: customData.metaName,
  );

  switchHighlight() {
    isHighlightVisible = !isHighlightVisible;
  }

  showHighlight() {
    isHighlightVisible = true;
  }

  hideHighlight() {
    isHighlightVisible = false;
  }
}