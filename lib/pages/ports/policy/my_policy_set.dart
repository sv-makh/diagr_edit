import 'package:diagr_edit/pages/ports/policy/custom_state_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_canvas_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_component_design_policy.dart';
import 'package:diagr_edit/pages/ports/policy/my_component_policy.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagr_edit/pages/ports/policy/my_init_policy.dart';

import 'custom_link_behaviour_policy.dart';
import 'my_link_control_policy.dart';
import 'my_link_joint_control_policy.dart';

class MyPolicySet extends PolicySet
    with
        MyInitPolicy,
        MyCanvasPolicy,
        MyComponentPolicy,
        MyComponentDesignPolicy,
        CustomStatePolicy,
        CanvasControlPolicy,
        LinkControlPolicy,
        LinkJointControlPolicy,
        //CustomLinkBehaviourPolicy
        MyLinkJointControlPolicy,
        MyLinkControlPolicy
{}
