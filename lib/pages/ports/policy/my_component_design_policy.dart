import 'package:diagr_edit/pages/ports/widget/bpmn_components/message_intermediate_catch_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/service_task_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/signal_intermediate_throw_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/start_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/terminate_end_event_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/text_annotation_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/timer_component.dart';
import 'package:diagr_edit/pages/ports/widget/bpmn_components/user_task_component.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

import '../widget/bpmn_components/business_rule_task_component.dart';
import '../widget/bpmn_components/collapsed_subprocess_component.dart';
import '../widget/bpmn_components/end_event_component.dart';
import '../widget/bpmn_components/error_boundary_event_component.dart';
import '../widget/bpmn_components/error_end_event_component.dart';
import '../widget/bpmn_components/exclusive_gateway_component.dart';
import '../widget/bpmn_components/link_intermediate_throw_event_component.dart';
import '../widget/bpmn_components/message_intermediate_throw_event_component.dart';
import '../widget/bpmn_components/parralel_gateway_component.dart';
import '../widget/bpmn_components/signal_intermediate_catch_event_component.dart';
import '../widget/port_component.dart';
import '../widget/rect_component.dart';

mixin MyComponentDesignPolicy implements ComponentDesignPolicy {
  @override
  Widget showComponentBody(ComponentData componentData) {
    switch (componentData.type) {
      case 'rectComponent':
        return RectComponent(componentData: componentData);
      case 'timerComponent':
        return TimerComponent(componentData: componentData);
      case 'userTaskComponent':
        return UserTaskComponent(componentData: componentData);
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
      case 'signalIntermediateCatchEventComponent':
        return SignalIntermediateCatchEventComponent(componentData: componentData);
      case 'parallelGatewayComponent':
        return ParallelGatewayComponent(componentData: componentData);
      case 'messageIntermediateThrowComponent':
        return MessageIntermediateThrowComponent(componentData: componentData);
      case 'messageIntermediateCatchEventComponent':
        return MessageIntermediateCatchEventComponent(componentData: componentData);
      case 'linkIntermediateThrowEventComponent':
        return LinkIntermediateThrowEventComponent(componentData: componentData);
      case 'exclusiveGatewayComponent':
        return ExclusiveGatewayComponent(componentData: componentData);
      case 'errorEndEventComponent':
        return ErrorEndEventComponent(componentData: componentData);
      case 'errorBoundaryEventComponent':
        return ErrorBoundaryEventComponent(componentData: componentData);
      case 'endEventComponent':
        return EndEventComponent(componentData: componentData);
      case 'collapsedSubprocessComponent':
        return CollapsedSubprocessComponent(componentData: componentData);
      case 'businessRuleTaskComponent':
        return BusinessRuleTaskComponent(componentData: componentData);
      case 'port':
        return PortComponent(componentData: componentData);
      default:
        return const SizedBox.shrink();
    }
  }
}