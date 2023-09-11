import 'package:diagr_edit/pages/ports/widget/bpmn_components/service_task_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/signal_intermediate_throw_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/start_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/terminate_end_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/text_annotation_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/timer_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/user_task_component.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

import '../widget/port_component.dart';
import '../widget/rect_component.dart';

mixin MyComponentDesignPolicy implements ComponentDesignPolicy {
  @override
  Widget showComponentBody(ComponentData componentData) {
    switch (componentData.type) {
      case 'timerComponent':
        return TimerComponent(componentData: componentData);
      case 'userTaskComponent':
        return UserTaskComponent(componentData: componentData);
      case 'rectComponent':
        return RectComponent(componentData: componentData);
      case 'terminateEndEventComponent':
        return TerminateEndEventComponent(componentData: componentData);
      case 'startEventComponent':
        return StartEventComponent(componentData: componentData);
      case 'signalIntermediateThrowEventComponent':
        return SignalIntermediateThrowEventComponent(componentData: componentData);
      case 'textAnnotationComponent':
        return TextAnnotationComponent(componentData: componentData);
      case 'serviceTaskComponent':
        return ServiceTaskComponent(componentData: componentData);
      case 'port':
        return PortComponent(componentData: componentData);
      default:
        return const SizedBox.shrink();
    }
  }
}