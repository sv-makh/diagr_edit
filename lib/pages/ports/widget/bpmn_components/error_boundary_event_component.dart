import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';
/*import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../common_components/base_component_body.dart';
import '../common_components/element_with_options_widget.dart';

class ErrorBoundaryEventComponent extends StatelessWidget {
  static const String name = 'errorBoundaryEvent';
  final ComponentData componentData;

  const ErrorBoundaryEventComponent({
    Key? key,
    required this.componentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElementWithOptionsWidget(
      componentData: componentData,
      child: BaseComponentBody(
        componentData: componentData,
        hidedText: true,
        componentPainter: ErrorBoundaryEventPainter(
          color: componentData.data.color,
          borderColor: componentData.data.borderColor,
          borderWidth: componentData.data.borderWidth,
        ),
      ),
    );
  }
}

class ErrorBoundaryEventPainter extends CustomPainter {
  final Color _color;
  final Color _borderColor;
  final double _borderWidth;
  late Size _componentSize;

  ErrorBoundaryEventPainter({
    Color? color,
    Color? borderColor,
    double? borderWidth,
  })  : _color = color ?? Colors.white,
        _borderColor = borderColor ?? Colors.black,
        _borderWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), (size.width / 2) * 0.8, paint);

    final lighting = Path();
    lighting.moveTo(size.width * 0.3, size.height * 0.7);
    lighting.lineTo(size.width * 0.4, size.height * 0.3);
    lighting.lineTo(size.width * 0.58, size.height * 0.53);
    lighting.lineTo(size.width * 0.7, size.height * 0.25);
    lighting.lineTo(size.width * 0.62, size.height * 0.7);
    lighting.lineTo(size.width * 0.43, size.height * 0.47);
    lighting.close();
    canvas.drawPath(lighting, Paint()..style = PaintingStyle.stroke);
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
    path.addOval(
      Rect.fromLTWH(
        0,
        0,
        _componentSize.width,
        _componentSize.height,
      ),
    );
    return path;
  }
}
