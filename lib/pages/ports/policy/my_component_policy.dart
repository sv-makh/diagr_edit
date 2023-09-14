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

    inParallelToAxisZone = false;
    for (var connection in _allComponentConnections(component)) {
      String linkId = connection.connectionId;
      LinkData linkData = canvasReader.model.getLink(linkId);

      Offset firstPoint = Offset(0, 0);
      Offset secondPoint = Offset(0, 0);
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
        print('inParallelToAxisZone = true');
        //parallelToAxisLinks.add(linkId);
        linkData.linkStyle.color = Colors.blue;
        linkData.updateLink();
      } else {
        //inParallelToAxisZone = false;
        //print('inParallelToAxisZone = false');
        //parallelToAxisLinks.remove(linkId);
        linkData.linkStyle.color = Colors.black;
        linkData.updateLink();
      }
    }
    //print('connections ${connections.map((e) => e.connectionId)}');

/*    int jointIndex = 1;
    for (var connection in connectionsToRebuild) {
      String linkId = connection.connectionId;

*/ /*      String scId = canvasReader.model.getLink(linkId).sourceComponentId;
      Offset sc = canvasReader.model.getComponent(scId).position;
      String tcId = canvasReader.model.getLink(linkId).targetComponentId;
      Offset tc = canvasReader.model.getComponent(tcId).position;

      Offset newJointPosition = Offset(sc.dx + portSize/2, tc.dy + portSize/2);*/ /*

      List<Offset> linkPoints = canvasReader.model.getLink(linkId).linkPoints;
      Offset prevPoint = linkPoints[jointIndex - 1];
      Offset nextPoint = linkPoints[jointIndex + 1];
      //Offset newPoint = linkPoints[jointIndex];
      Offset newJointPosition = Offset(prevPoint.dx, nextPoint.dy);

      canvasWriter.model.setLinkMiddlePointPosition(linkId, newJointPosition, jointIndex);
      canvasWriter.model.updateLink(linkId);
    }*/

    lastFocalPoint = details.localFocalPoint;
  }

  @override
  onComponentScaleEnd(String componentId, ScaleEndDetails details) {
    var component = canvasReader.model.getComponent(componentId);
    if (inParallelToAxisZone) {
      double? dxToCompare;
      double? dyToCompare;
      double? dxToAlign;
      double? dyToAlign;
      String linkToYAlign = '';
      String linkToXAlign = '';
      List<Connection> linksToYAlign = [];
      List<Connection> linksToXAlign = [];

      for (var connection in _allComponentConnections(component)) {
        String linkId = connection.connectionId;
        LinkData linkData = canvasReader.model.getLink(linkId);

        Offset firstPoint = Offset(0, 0);
        Offset secondPoint = Offset(0, 0);
        if (connection is ConnectionOut) {
          firstPoint = linkData.linkPoints[0];
          secondPoint = linkData.linkPoints[1];
        } else {
          firstPoint = linkData.linkPoints.last;
          secondPoint = linkData.linkPoints[linkData.linkPoints.length - 2];
        }

        print('check connection');
        if ((firstPoint.dy - secondPoint.dy).abs() < parallelToAxisDelta) {
          print('DY firstPoint = $firstPoint secondPoint = $secondPoint');
          if ((dyToCompare == null) ||
              ((dyToCompare != null) && (firstPoint.dy > dyToCompare))) {
            dyToCompare = firstPoint.dy;
            dyToAlign = secondPoint.dy;
            linkToYAlign = linkId;
          }
          //linksToYAlign.add(linkId);
        } else if ((firstPoint.dx - secondPoint.dx).abs() <
            parallelToAxisDelta) {
          print('DX firstPoint = $firstPoint secondPoint = $secondPoint');
          if ((dxToCompare == null) ||
              ((dxToCompare != null) && (firstPoint.dx > dxToCompare))) {
            dxToCompare = firstPoint.dx;
            dxToAlign = secondPoint.dx;
            linkToXAlign = linkId;
          }
          //linksToXAlign.add(linkId);
        }

        linkData.linkStyle.color = Colors.black;
        linkData.updateLink();
      }

      //Offset positionDelta = const Offset(0, 0);
      double dy = 0;
      double dx = 0;
      if (dyToCompare != null) {
        print('dyToCompare = $dyToCompare dyToAlign = $dyToAlign');
        dy = dyToAlign! - dyToCompare;
        //positionDelta = Offset(0, dyToAlign! - dyToCompare);//lastFocalPoint! + Offset(0, dyToAlign! - dyToCompare);
      }
      if (dxToCompare != null) {
        print('dxToCompare = $dxToCompare dxToAlign = $dxToAlign');
        dx = dxToAlign! - dxToCompare;
        //positionDelta = Offset(dxToAlign! - dxToCompare, 0);//lastFocalPoint! + Offset(dxToAlign! - dxToCompare, 0);
      }
      Offset positionDelta = Offset(dx, dy);
      print(
          'positionDelta = $positionDelta / ${canvasReader.state.fromCanvasCoordinates(positionDelta)}');
/*      if (component.type != 'port') {
        canvasWriter.model.moveComponentWithChildren(componentId, positionDelta);
      } else if (component.type == 'port') {
        canvasWriter.model
            .moveComponentWithChildren(component.parentId!, positionDelta);
      }*/
      Offset componentPosition = component.position;
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
  }

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
      if (((sc.dx - tc.dx).abs() > 10) && ((sc.dy - tc.dy).abs() > 10)) {
        Offset middle = Offset(sc.dx + portSize / 2, tc.dy + portSize / 2);
        //print('insert start middle point');
        Offset newMiddle = canvasReader.state.toCanvasCoordinates(middle);
        canvasWriter.model.insertLinkMiddlePoint(linkId, newMiddle, jointIndex);
      }

      return true;
    }
  }

  bool shiftConnection(String? sourceComponentId, String? targetComponentId) {
    if (!canShift(sourceComponentId, targetComponentId)) {
      print('shiftConnection false');
      return false;
    } else {
      print('shiftConnection true');
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
