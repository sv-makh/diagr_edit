import 'dart:math' as math;

import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

import '../widget/port_component.dart';
import '../widget/rect_component.dart';
import 'package:diagr_edit/pages/ports/widget/my_component_data.dart';

mixin CustomPolicy implements PolicySet {
  List<String> bodies = [
    //'rectComponent',
    'userTaskComponent',
    'timerComponent',
    'terminateEndEventComponent',
    'startEventComponent',
    'signalIntermediateThrowEventComponent',
    'textAnnotationComponent',
    'serviceTaskComponent',
  ];

  String? selectedComponentId;

  highlightComponent(String componentId) {
    canvasReader.model.getComponent(componentId).data.showHighlight();
    canvasReader.model.getComponent(componentId).updateComponent();
    selectedComponentId = componentId;
  }

  hideComponentHighlight(String? componentId) {
    if (componentId != null) {
      canvasReader.model.getComponent(componentId).data.hideHighlight();
      canvasReader.model.getComponent(componentId).updateComponent();
      selectedComponentId = null;
    }
  }

  deleteAllComponents() {
    canvasWriter.model.removeAllComponents();
  }

  String? selectedPortId;
  bool arePortsVisible = true;

  bool canConnectThesePorts(String? portId1, String? portId2) {
    if (portId1 == null || portId2 == null) {
      return false;
    }
    if (portId1 == portId2) {
      return false;
    }

    var port1 = canvasReader.model.getComponent(portId1);
    var port2 = canvasReader.model.getComponent(portId2);

    if (port1.type != 'port' || port2.type != 'port') {
      return false;
    }

/*    if (port1.data.type != port2.data.type) {
      return false;
    }*/

    if (port1.connections
        .any((connection) => (connection.otherComponentId == portId2))) {
      return false;
    }

    if (port1.parentId == port2.parentId) {
      return false;
    }

    return true;
  }

  selectPort(String portId) {
    var port = canvasReader.model.getComponent(portId);
    port.data.setPortState(PortState.selected);
    port.updateComponent();
    selectedPortId = portId;

    canvasReader.model.getAllComponents().values.forEach((port) {
      if (canConnectThesePorts(portId, port.id)) {
        (port.data as PortData).setPortState(PortState.highlighted);
        port.updateComponent();
      }
    });
  }

  deselectAllPorts() {
    selectedPortId = null;

    canvasReader.model.getAllComponents().values.forEach((component) {
      if (component.type == 'port') {
        (component.data as PortData)
            .setPortState(arePortsVisible ? PortState.shown : PortState.hidden);
        component.updateComponent();
      }
    });
  }

  switchPortsVisibility() {
    selectedPortId = null;
    if (arePortsVisible) {
      arePortsVisible = false;
      canvasReader.model.getAllComponents().values.forEach((component) {
        if (component.type == 'port') {
          (component.data as PortData).setPortState(PortState.hidden);
          component.updateComponent();
        }
      });
    } else {
      arePortsVisible = true;
      canvasReader.model.getAllComponents().values.forEach((component) {
        if (component.type == 'port') {
          (component.data as PortData).setPortState(PortState.shown);
          component.updateComponent();
        }
      });
    }
  }

  addComponentDataWithPorts(Offset position) {
    String type = bodies[math.Random().nextInt(bodies.length)];
    print(type);
    var componentData = _getComponentData(position, type);
    canvasWriter.model.addComponent(componentData);
    int zOrder = canvasWriter.model.moveComponentToTheFront(componentData.id);
    componentData.data.portData.forEach((PortData port) {
      var newPort = ComponentData(
        size: port.size,
        type: 'port',
        data: port,
        position: componentData.position +
            componentData.getPointOnComponent(port.alignmentOnComponent) -
            port.size.center(Offset.zero),
      );
      canvasWriter.model.addComponent(newPort);
      canvasWriter.model.setComponentParent(newPort.id, componentData.id);
      newPort.zOrder = zOrder + 1;
    });
  }

  ComponentData _getComponentData(Offset position, String type) {
    Size size = const Size(0, 0);
    switch (type) {
      case 'timerComponent':
      case 'terminateEndEventComponent':
      case 'startEventComponent':
      case 'signalIntermediateThrowEventComponent':
        size = const Size(50, 50);
      case 'userTaskComponent':
      case 'textAnnotationComponent':
      case 'serviceTaskComponent':
        size = const Size(90, 60);
      case 'rectComponent':
        size = const Size(120, 90);
      default:
        size = const Size(0, 0);
    }

    var portComponent = ComponentData(
      size: size, //const Size(120, 90),
      position: position,
      type: type,
      data: MyComponentData(
        color: Colors.white,
      ),
    );

    switch (type) {
      case 'timerComponent':
      case 'terminateEndEventComponent':
      case 'startEventComponent':
      case 'signalIntermediateThrowEventComponent':
        portComponent.data.portData.add(_getPortData(Alignment.topCenter));
        portComponent.data.portData.add(_getPortData(Alignment.bottomCenter));
        portComponent.data.portData.add(_getPortData(Alignment.centerRight));
        portComponent.data.portData.add(_getPortData(Alignment.centerLeft));

      case 'userTaskComponent':
      case 'textAnnotationComponent':
      case 'serviceTaskComponent':
      //case 'rectComponent':
      default:
        portComponent.data.portData.add(_getPortData(Alignment.topLeft));
        portComponent.data.portData.add(_getPortData(Alignment.topRight));
        portComponent.data.portData.add(_getPortData(Alignment.topCenter));
        portComponent.data.portData.add(_getPortData(Alignment.bottomCenter));
        portComponent.data.portData.add(_getPortData(Alignment.bottomRight));
        portComponent.data.portData.add(_getPortData(Alignment.bottomLeft));
        portComponent.data.portData.add(_getPortData(Alignment.centerRight));
        portComponent.data.portData.add(_getPortData(Alignment.centerLeft));
    }

    return portComponent;
  }

  PortData _getPortData(Alignment alignment) {
    Color portColor = Colors.white;
    var portData = PortData(
      color: portColor,
      size: const Size(15, 15),
      alignmentOnComponent: alignment,
    );
    portData.setPortState(arePortsVisible ? PortState.shown : PortState.hidden);
    return portData;
  }
}
