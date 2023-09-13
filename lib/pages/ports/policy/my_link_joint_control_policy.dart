import 'package:diagram_editor/diagram_editor.dart';

//import 'package:diagram_editor/src/abstraction_layer/policy/base/link_joints_policy.dart';
import 'package:flutter/material.dart';

import 'custom_state_policy.dart';

mixin MyLinkJointControlPolicy implements LinkJointPolicy, CustomStatePolicy {
  bool inRightAngleZone = false;
  double angleZoneDelta = 10;

  @override
  onLinkJointLongPress(int jointIndex, String linkId) {
    canvasWriter.model.removeLinkMiddlePoint(linkId, jointIndex);
    canvasWriter.model.updateLink(linkId);

    hideLinkOption();
  }

  @override
  onLinkJointScaleUpdate(
      int jointIndex, String linkId, ScaleUpdateDetails details) {
    canvasWriter.model.setLinkMiddlePointPosition(
        linkId, details.localFocalPoint, jointIndex);
    canvasWriter.model.updateLink(linkId);
    rightAngleZoneStumble(jointIndex, linkId, details.localFocalPoint);

    hideLinkOption();
  }

  void rightAngleZoneStumble(int jointIndex, String linkId, Offset currentPoint) {
    currentPoint = canvasReader.state.fromCanvasCoordinates(currentPoint);

    LinkData linkData = canvasReader.model.getLink(linkId);
    List<Offset> linkPoints = linkData.linkPoints;
    Offset prevPoint = linkPoints[jointIndex - 1];
    Offset nextPoint = linkPoints[jointIndex + 1];
    //Offset currPoint = details.localFocalPoint;
    if ((((currentPoint.dx - prevPoint.dx).abs() < angleZoneDelta) &&
        ((currentPoint.dy - nextPoint.dy).abs() < angleZoneDelta)) ||
        (((currentPoint.dx - nextPoint.dx).abs() < angleZoneDelta) &&
            ((currentPoint.dy - prevPoint.dy).abs() < angleZoneDelta))) {
      inRightAngleZone = true;
      linkData.linkStyle.color = Colors.blue;
      linkData.updateLink();
    } else {
      inRightAngleZone = false;
      linkData.linkStyle.color = Colors.black;
      linkData.updateLink();
    }
  }

  void rightAngleZoneUpdate(int jointIndex, String linkId) {
    LinkData linkData = canvasReader.model.getLink(linkId);
    if (inRightAngleZone) {
      List<Offset> linkPoints = linkData.linkPoints;
      Offset prevPoint = linkPoints[jointIndex - 1];
      Offset nextPoint = linkPoints[jointIndex + 1];
      Offset newPoint = linkPoints[jointIndex];
      if (((newPoint.dx - prevPoint.dx).abs() < angleZoneDelta) &&
          ((newPoint.dy - nextPoint.dy).abs() < angleZoneDelta)) {
        newPoint = Offset(prevPoint.dx, nextPoint.dy);
      } else {
        newPoint = Offset(nextPoint.dx, prevPoint.dy);
      }

      newPoint = canvasReader.state.toCanvasCoordinates(newPoint);

      canvasWriter.model.setLinkMiddlePointPosition(linkId, newPoint, jointIndex);
    }
    linkData.linkStyle.color = Colors.black;
    linkData.updateLink();
  }

  @override
  onLinkJointScaleEnd(int jointIndex, String linkId, ScaleEndDetails details) {
    LinkData linkData = canvasReader.model.getLink(linkId);

    rightAngleZoneUpdate(jointIndex, linkId);
  }
}
