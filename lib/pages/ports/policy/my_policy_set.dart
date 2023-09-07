import 'package:diagr_edit/pages/ports/policy/my_canvas_policy.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'my_init_policy.dart';

class MyPolicySet extends PolicySet
    with MyInitPolicy, MyCanvasPolicy, CanvasControlPolicy, LinkControlPolicy, LinkJointControlPolicy {}