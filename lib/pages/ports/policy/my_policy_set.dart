import 'package:diagr_edit/pages/ports/policy/custom_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_canvas_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_component_design_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_component_policy.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagr_edit/pages/ports/policy/my_init_policy.dart';

class MyPolicySet extends PolicySet
    with
        MyInitPolicy,
        MyCanvasPolicy,
        MyComponentPolicy,
        MyComponentDesignPolicy,
        CustomPolicy,
        CanvasControlPolicy,
        LinkControlPolicy,
        LinkJointControlPolicy {}
