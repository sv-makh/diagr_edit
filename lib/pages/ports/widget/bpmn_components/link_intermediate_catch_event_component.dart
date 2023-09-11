import 'package:diagr_edit/pages/ports/widget/common_components/string_null_or_empty_extension.dart';
import 'package:diagram_editor/diagram_editor.dart';
//import 'package:diagram_editor_apps/core/diagram_editor_core/extensions/string_null_or_empty_extension.dart';

import 'package:flutter/material.dart';

/*import '../../../../../../../../core/diagram_editor_core/ui/app_colors.dart';
import '../../../../../data/models/component_data/component_meta_data.dart';
import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../../theme/application_colors.dart';
import '../common_components/base_component_body.dart';
import '../common_components/component_meta_data.dart';
import '../common_components/element_with_options_widget.dart';

class LinkIntermediateCatchEventComponent extends StatelessWidget {
  static const String name = 'linkIntermediateCatchEvent';
  final ComponentData componentData;

  const LinkIntermediateCatchEventComponent({
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
        componentPainter: LinkIntermediateCatchEventPainter(
          color: componentData.data.color,
          borderColor: componentData.data.borderColor,
          borderWidth: componentData.data.borderWidth,
          componentData: componentData,
        ),
      ),
    );
  }
}

class LinkIntermediateCatchEventPainter extends CustomPainter {
  Color _color;
  final Color _borderColor;
  final double _borderWidth;
  final ComponentData _componentData;
  late Size _componentSize;

  LinkIntermediateCatchEventPainter({
    required ComponentData componentData,
    Color? color,
    Color? borderColor,
    double? borderWidth,
  })  : _color = color ?? Colors.white,
        _borderColor = borderColor ?? Colors.black,
        _componentData = componentData,
        _borderWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    _checkComponentColorsConditions(_componentData);
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

    final arrow = Path();
    arrow.moveTo(size.width * 0.28, size.height * 0.4);
    arrow.lineTo(size.width * 0.58, size.height * 0.4);
    arrow.lineTo(size.width * 0.58, size.height * 0.27);
    arrow.lineTo(size.width * 0.78, size.height * 0.5);
    arrow.lineTo(size.width * 0.58, size.height * 0.73);
    arrow.lineTo(size.width * 0.58, size.height * 0.60);
    arrow.lineTo(size.width * 0.28, size.height * 0.60);
    arrow.close();
    canvas.drawPath(arrow, Paint()..style = PaintingStyle.stroke);
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

  void _checkComponentColorsConditions(ComponentData componentData) {
    if (!(componentData.data as ComponentMetaData)
        .metaName
        .isNotNullOrEmpty()) {
      _color = ApplicationColors.darkGrey;
    }
  }
}
