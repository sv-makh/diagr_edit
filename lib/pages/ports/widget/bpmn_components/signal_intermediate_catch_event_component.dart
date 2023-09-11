import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';
/*import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../common_components/base_component_body.dart';
import '../common_components/element_with_options_widget.dart';

class SignalIntermediateCatchEventComponent extends StatelessWidget {
  static const String name = 'signalIntermediateCatchEvent';
  final ComponentData componentData;

  const SignalIntermediateCatchEventComponent({
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
        componentPainter: SignalIntermediateCatchEventPainter(
          color: componentData.data.color,
          borderColor: componentData.data.borderColor,
          borderWidth: componentData.data.borderWidth,
        ),
      ),
    );
  }
}

class SignalIntermediateCatchEventPainter extends CustomPainter {
  final Color _color;
  final Color _borderColor;
  final double _borderWidth;
  late Size _componentSize;

  SignalIntermediateCatchEventPainter({
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

    final triangle = Path();
    triangle.moveTo(size.width / 2, size.height * 0.25);
    triangle.lineTo(size.width * 0.27, size.height * 0.67);
    triangle.lineTo(size.width * 0.73, size.height * 0.67);
    triangle.close();
    canvas.drawPath(
        triangle,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);
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
