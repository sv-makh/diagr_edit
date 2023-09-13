import 'package:diagr_edit/pages/ports/policy/custom_state_policy.dart';
import 'package:diagr_edit/pages/ports/widget/common_components/my_component_data.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin MyComponentPolicy implements ComponentPolicy, CustomStatePolicy {
  Offset? lastFocalPoint;

  @override
  onComponentTap(String componentId) {
    canvasWriter.model.hideAllLinkJoints();

    var component = canvasReader.model.getComponent(componentId);

    if (component.type == 'port') {
      bool connected = connectComponents(selectedPortId, componentId);
      deselectAllPorts();
      if (!connected) {
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

    //List<Connection> connectionsToRebuild = [];
    if (component.type != 'port') {
      canvasWriter.model.moveComponentWithChildren(componentId, positionDelta);
/*      for (var portId in component.childrenIds) {
        connectionsToRebuild.addAll(canvasReader.model.getComponent(portId).connections);
      }*/
    } else if (component.type == 'port') {
      canvasWriter.model
          .moveComponentWithChildren(component.parentId!, positionDelta);
      //connectionsToRebuild.addAll(canvasReader.model.getComponent(component.parentId!).connections);
    }
/*    int jointIndex = 1;
    for (var connection in connectionsToRebuild) {
      String linkId = connection.connectionId;

*//*      String scId = canvasReader.model.getLink(linkId).sourceComponentId;
      Offset sc = canvasReader.model.getComponent(scId).position;
      String tcId = canvasReader.model.getLink(linkId).targetComponentId;
      Offset tc = canvasReader.model.getComponent(tcId).position;

      Offset newJointPosition = Offset(sc.dx + portSize/2, tc.dy + portSize/2);*//*

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
      List<Offset> linkPoints = canvasReader.model.getLink(linkId).linkPoints;
      print('connectComponents linkPonts (${linkPoints.length}): ${linkPoints[0]}, ${linkPoints[1]}');

      int jointIndex = 1;
      Offset sc = canvasReader.model.getComponent(sourceComponentId).position;
      Offset tc = canvasReader.model.getComponent(targetComponentId).position;
      Offset middle = Offset(sc.dx + portSize/2, tc.dy + portSize/2);//Offset((tc.dx+sc.dx)/2 , (tc.dy+sc.dy)/2);

      Offset newMiddle = canvasReader.state.toCanvasCoordinates(middle);

      Offset prevPoint = linkPoints[0];
      Offset nextPoint = linkPoints[1];
      //Offset middle = Offset((prevPoint.dx + nextPoint.dx)/2, (prevPoint.dy + nextPoint.dy)/2);
      //Offset middle =Offset(prevPoint.dx, nextPoint.dy);
      canvasWriter.model.insertLinkMiddlePoint(linkId, newMiddle, jointIndex);

      //Offset newJointPosition = Offset(sc.dx + portSize/2, tc.dy + portSize/2);
/*      Offset newJointPosition = Offset(prevPoint.dx, nextPoint.dy);
      canvasWriter.model.setLinkMiddlePointPosition(linkId, newJointPosition, jointIndex);*/
      //canvasWriter.model.updateLink(linkId);
      print('linkPonts after (${linkPoints.length}): ${linkPoints[0]}, ${linkPoints[1]}, ${linkPoints[2]}');

      return true;
    }
  }
}
