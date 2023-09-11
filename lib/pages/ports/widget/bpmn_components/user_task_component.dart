import 'package:diagram_editor/diagram_editor.dart';
//import 'package:diagram_editor_apps/core/diagram_editor_core/extensions/string_null_or_empty_extension.dart';
import 'package:flutter/material.dart';
/*import '../../../../../../../../core/diagram_editor_core/ui/app_colors.dart';
import '../../../../../data/models/component_data/component_meta_data.dart';
import '../../common_elements/base_component_body.dart';
import '../../../widgets_with_options/element_with_options_widget.dart';*/
import '../base_component_body.dart';
import '../element_with_options_widget.dart';

class UserTaskComponent extends StatelessWidget {
  static const String name = 'userTask';
  final ComponentData componentData;

  const UserTaskComponent({
    Key? key,
    required this.componentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElementWithOptionsWidget(
      componentData: componentData,
      child: Stack(
        children: [
          BaseComponentBody(
            componentData: componentData,
            //hidedText: false,
            componentPainter: UserTaskPainter(
              color: componentData.data.color,
              borderColor: componentData.data.borderColor,
              borderWidth: componentData.data.borderWidth,
              componentData: componentData,
            ),
          ),
          const Positioned(
            top: 4.0,
            left: 4.0,
            child: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}

class UserTaskPainter extends CustomPainter {
  Color _color;
  final Color _borderColor;
  final double _borderWidth;
  final ComponentData _componentData;
  late Size _componentSize;

  UserTaskPainter({
    required ComponentData componentData,
    Color? color,
    Color? borderColor,
    double? borderWidth,
  })  : _color = color ?? Colors.white,
        _borderColor = borderColor ?? Colors.black,
        _borderWidth = 2.0,
        _componentData = componentData;

  @override
  void paint(Canvas canvas, Size size) {
    //_checkComponentColorsConditions(_componentData);
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

/*  void _checkComponentColorsConditions(ComponentData componentData) {
    if (!(componentData.data as ComponentMetaData)
        .metaName
        .isNotNullOrEmpty()) {
      _color = ApplicationColors.darkGrey;
    }
  }*/
}
