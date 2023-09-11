import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';
/*import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../common_components/base_component_body.dart';
import '../common_components/element_with_options_widget.dart';

class CollapsedSubprocessComponent extends StatelessWidget {
  static const String name = 'collapsedSubprocess';
  final ComponentData componentData;

  const CollapsedSubprocessComponent({
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
          BaseComponentBody(
            componentData: componentData,
            hidedText: false,
            componentPainter: CollapsedSubprocessPainter(
              color: componentData.data.color,
              borderColor: componentData.data.borderColor,
              borderWidth: componentData.data.borderWidth,
            ),
          ),
          const Positioned(
            bottom: 4.0,
            child: Icon(Icons.add_box_outlined),
          )
        ],
      ),
    );
  }
}

class CollapsedSubprocessPainter extends CustomPainter {
  final Color _color;
  final Color _borderColor;
  final double _borderWidth;
  late Size _componentSize;

  CollapsedSubprocessPainter({
    Color? color,
    Color? borderColor,
    double? borderWidth,
  })  : _color = color ?? Colors.white,
        _borderColor = borderColor ?? Colors.black,
        _borderWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;
    _componentSize = size;

    Path path = componentPath();

    canvas.drawPath(path, paint);

    if (_borderWidth > 0) {
      paint
        ..style = PaintingStyle.stroke
        ..color = _borderColor
        ..strokeWidth = _borderWidth;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    Path path = componentPath();
    return path.contains(position);
  }

  Path componentPath() {
    Path path = Path();

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          0,
          _componentSize.width,
          _componentSize.height,
        ),
        const Radius.circular(8),
      ),
    );

    return path;
  }
}
