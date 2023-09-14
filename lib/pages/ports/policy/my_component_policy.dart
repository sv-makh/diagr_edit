import 'package:diagr_edit/pages/ports/policy/custom_state_policy.dart';
import 'package:diagr_edit/pages/ports/widget/common_components/my_component_data.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin MyComponentPolicy implements ComponentPolicy, CustomStatePolicy {
  Offset? lastFocalPoint;
  double parallelToAxisDelta = 10;
  bool inParallelToAxisZone = false;
  List<String> parallelToAxisLinks = [];

  @override
  onComponentTap(String componentId) {
    canvasWriter.model.hideAllLinkJoints();

    var component = canvasReader.model.getComponent(componentId);

    if (component.type == 'port') {
      bool connected = connectComponents(selectedPortId, componentId);
      bool shiftedConnection = false;
      if (!connected) {
        shiftedConnection = shiftConnection(selectedPortId, componentId);
      }
      deselectAllPorts();
      if (!connected && !shiftedConnection) {
        selectPort(componentId);
      }
    } else {
      bool connected = connectComponents(selectedComponentId, componentId);
      hideComponentHighlight(selectedComponentId);
      if (!connected) {
        highlightComponent(componentId);
      }
    }
  }

  @override
  onComponentLongPress(String componentId) {
    var component = canvasReader.model.getComponent(componentId);
    if (component.type == 'component') {
      canvasWriter.model.hideAllLinkJoints();
      canvasWriter.model.removeComponentWithChildren(componentId);
    }
  }

  @override
  onComponentScaleStart(componentId, details) {
    lastFocalPoint = details.localFocalPoint;
  }

  @override
  onComponentScaleUpdate(componentId, details) {
    Offset positionDelta = details.localFocalPoint - lastFocalPoint!;

    var component = canvasReader.model.getComponent(componentId);

    if (component.type != 'port') {
      canvasWriter.model.moveComponentWithChildren(componentId, positionDelta);
    } else if (component.type == 'port') {
      canvasWriter.model
          .moveComponentWithChildren(component.parentId!, positionDelta);
    }

    checkForParallelToAxis(component);

    lastFocalPoint = details.localFocalPoint;
  }

  void checkForParallelToAxis(ComponentData component) {
    inParallelToAxisZone = false;

    for (var connection in _allComponentConnections(component)) {
      String linkId = connection.connectionId;
      LinkData linkData = canvasReader.model.getLink(linkId);

      Offset firstPoint = const Offset(0, 0);
      Offset secondPoint = const Offset(0, 0);
      if (connection is ConnectionOut) {
        firstPoint = linkData.linkPoints[0];
        secondPoint = linkData.linkPoints[1];
      } else {
        firstPoint = linkData.linkPoints.last;
        secondPoint = linkData.linkPoints[linkData.linkPoints.length - 2];
      }

      if (((firstPoint.dy - secondPoint.dy).abs() < parallelToAxisDelta) ||
          (((firstPoint.dx - secondPoint.dx).abs()) < parallelToAxisDelta)) {
        inParallelToAxisZone = true;
        linkData.linkStyle.color = Colors.blue;
        linkData.updateLink();
      } else {
        linkData.linkStyle.color = Colors.black;
        linkData.updateLink();
      }
    }
  }

  @override
  onComponentScaleEnd(String componentId, ScaleEndDetails details) {
    if (inParallelToAxisZone) {
      moveComponentToAxisAlign(componentId);
    }
  }

  void moveComponentToAxisAlign(String componentId) {
    double? dxToCompare;
    double? dyToCompare;
    double? dxToAlign;
    double? dyToAlign;
    var component = canvasReader.model.getComponent(componentId);

    for (var connection in _allComponentConnections(component)) {
      String linkId = connection.connectionId;
      LinkData linkData = canvasReader.model.getLink(linkId);

      //первая точка - соединение линии с компонентом
      //вторая точка - конец отрезка линии, который примыкает к компоненту
      Offset firstPoint = const Offset(0, 0);
      Offset secondPoint = const Offset(0, 0);
      if (connection is ConnectionOut) {
        firstPoint = linkData.linkPoints[0];
        secondPoint = linkData.linkPoints[1];
      } else {
        firstPoint = linkData.linkPoints.last;
        secondPoint = linkData.linkPoints[linkData.linkPoints.length - 2];
      }

      //if - проверка, близка ли данная линия к горизонтали
      //else if - проверка, близка ли данная линия к вертикали
      if ((firstPoint.dy - secondPoint.dy).abs() < parallelToAxisDelta) {
        if ((dyToCompare == null) ||
            ((dyToCompare != null) && (firstPoint.dy > dyToCompare))) {
          dyToCompare = firstPoint.dy;
          dyToAlign = secondPoint.dy;
        }
      } else if ((firstPoint.dx - secondPoint.dx).abs() <
          parallelToAxisDelta) {
        if ((dxToCompare == null) ||
            ((dxToCompare != null) && (firstPoint.dx > dxToCompare))) {
          dxToCompare = firstPoint.dx;
          dxToAlign = secondPoint.dx;
        }
      }

      linkData.linkStyle.color = Colors.black;
      linkData.updateLink();
    }

    //dx, dy - расстояние, на которое надо сдвинуть компонент
    // для выравнивания линий
    double dy = 0;
    double dx = 0;
    if (dyToCompare != null) {
      dy = dyToAlign! - dyToCompare;
    }
    if (dxToCompare != null) {
      dx = dxToAlign! - dxToCompare;
    }
    //вектор сдвига
    Offset positionDelta = Offset(dx, dy);
    Offset componentPosition = component.position;
    //помещаем компонент и все его порты в новое место
    if (component.type != 'port') {
      for (var portId in component.childrenIds) {
        var portPosition = canvasReader.model.getComponent(portId).position;
        canvasWriter.model
            .setComponentPosition(portId, portPosition + positionDelta);
      }
      canvasWriter.model.setComponentPosition(
          componentId, componentPosition + positionDelta);
    } else if (component.type == 'port') {
      var parent = canvasReader.model.getComponent(component.parentId!);
      for (var portId in parent.childrenIds) {
        var portPosition = canvasReader.model.getComponent(portId).position;
        canvasWriter.model
            .setComponentPosition(portId, portPosition + positionDelta);
      }
      canvasWriter.model.setComponentPosition(
          component.parentId!, parent.position + positionDelta);
    }
  }

  //все соединения для компонента с портами (соединения выходят только из портов)
  List<Connection> _allComponentConnections(ComponentData component) {
    List<Connection> connections = [];
    if (component.type != 'port') {
      for (var portId in component.childrenIds) {
        connections.addAll(canvasReader.model.getComponent(portId).connections);
      }
    } else if (component.type == 'port') {
      var parent = canvasReader.model.getComponent(component.parentId!);
      for (var portId in parent.childrenIds) {
        connections.addAll(canvasReader.model.getComponent(portId).connections);
      }
    }
    return connections;
  }

  bool connectComponents(String? sourceComponentId, String? targetComponentId) {
    if (!canConnectThesePorts(sourceComponentId, targetComponentId)) {
      return false;
    } else {
      String linkId = canvasWriter.model.connectTwoComponents(
        sourceComponentId: sourceComponentId!,
        targetComponentId: targetComponentId!,
        linkStyle: LinkStyle(
          arrowType: ArrowType.pointedArrow,
          lineWidth: 1.5,
        ),
      );

      //создаём излом с прямым углом на свежесозданной линии
      int jointIndex = 1;
      Offset sc = canvasReader.model.getComponent(sourceComponentId).position;
      Offset tc = canvasReader.model.getComponent(targetComponentId).position;
      //излом создаётся только если разница в координатах достаточно большая
      if (((sc.dx - tc.dx).abs() > 10) && ((sc.dy - tc.dy).abs() > 10)) {
        Offset middle = Offset(sc.dx + portSize / 2, tc.dy + portSize / 2);
        Offset newMiddle = canvasReader.state.toCanvasCoordinates(middle);
        canvasWriter.model.insertLinkMiddlePoint(linkId, newMiddle, jointIndex);
      }

      return true;
    }
  }

  bool shiftConnection(String? sourceComponentId, String? targetComponentId) {
    if (!canShift(sourceComponentId, targetComponentId)) {
      return false;
    } else {
      Connection connection =
          canvasReader.model.getComponent(sourceComponentId!).connections.first;
      String linkId = connection.connectionId;
      LinkData linkData = canvasReader.model.getLink(linkId);
      List<Offset> points = linkData.linkPoints;

      canvasWriter.model.removeLink(linkId);

      String newSource = '';
      String newTarget = '';
      if (connection is ConnectionOut) {
        newSource = targetComponentId!;
        newTarget = linkData.targetComponentId;
      } else {
        newSource = linkData.sourceComponentId;
        newTarget = targetComponentId!;
      }

      String newLinkId = canvasWriter.model.connectTwoComponents(
        sourceComponentId: newSource,
        targetComponentId: newTarget,
        linkStyle: LinkStyle(
          arrowType: ArrowType.pointedArrow,
          lineWidth: 1.5,
        ),
      );
      for (int i = 1; i < points.length - 1; i++) {
        canvasWriter.model.insertLinkMiddlePoint(
            newLinkId, canvasReader.state.toCanvasCoordinates(points[i]), i);
        canvasWriter.model.updateLink(newLinkId);
      }

      return true;
    }
  }
}
