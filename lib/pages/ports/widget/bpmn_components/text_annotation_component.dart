import 'package:diagram_editor/diagram_editor.dart';
//import 'package:diagram_editor_apps/features/diagram_editor_feature/diagram_editor/data/models/component_data/component_meta_data.dart';
import 'package:flutter/material.dart';
/*import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../common_components/base_component_body.dart';
import '../common_components/element_with_options_widget.dart';

class TextAnnotationComponent extends StatelessWidget {
  static const String name = 'textAnnotation';
  final ComponentData componentData;

  const TextAnnotationComponent({
    Key? key,
    required this.componentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElementWithOptionsWidget(
      componentData: componentData,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text('text annotation'),
                //(componentData.data as ComponentMetaData).commentValue ?? ''),
          ),
          BaseComponentBody(
            componentData: componentData,
            hidedText: false,
            componentPainter: TextAnnotationPainter(
              color: componentData.data.color,
              borderColor: componentData.data.borderColor,
              borderWidth: componentData.data.borderWidth,
            ),
          ),
        ],
      ),
    );
  }
}

class TextAnnotationPainter extends CustomPainter {
  final Color _color;
  final Color _borderColor;
  final double _borderWidth;
  late Size _componentSize;

  TextAnnotationPainter({
    Color? color,
    Color? borderColor,
    double? borderWidth,
  })  : _color = color ?? Colors.white,
        _borderColor = borderColor ?? Colors.black,
        _borderWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final comment = Path();
    comment.lineTo(20, 0);
    comment.lineTo(0, 0);
    comment.lineTo(0, size.height);
    comment.lineTo(20, size.height);
    comment.lineTo(0, size.height);
    comment.close();
    canvas.drawPath(
        comment,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _borderWidth);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
