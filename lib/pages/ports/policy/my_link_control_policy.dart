import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

import 'my_link_joint_control_policy.dart';

mixin MyLinkControlPolicy
    implements LinkControlPolicy, MyLinkJointControlPolicy {
  @override
  onLinkTapUp(String linkId, TapUpDetails details) {
    canvasWriter.model.hideAllLinkJoints();
    canvasWriter.model.showLinkJoints(linkId);

    //int? segmentIndex = canvasReader.model.determineLinkSegmentIndex(linkId, details.localPosition);
    //print('segment $segmentIndex');
  }

  var _segmentIndex;
  bool _segmentVerticalMove = false;
  bool _segmentHorisontalMove = false;

  @override
  onLinkScaleStart(String linkId, ScaleStartDetails details) {
    canvasWriter.model.hideAllLinkJoints();
    canvasWriter.model.showLinkJoints(linkId);
    _segmentIndex = canvasReader.model
        .determineLinkSegmentIndex(linkId, details.localFocalPoint);
    if (_segmentIndex != null) {
      LinkData linkData = canvasReader.model.getLink(linkId);
      List<Offset> linkPoints = canvasReader.model.getLink(linkId).linkPoints;

      if ((_segmentIndex >= 2) && (linkPoints.length - _segmentIndex >= 2)) {
        if (linkPoints[_segmentIndex - 1].dy == linkPoints[_segmentIndex].dy) {
          if ((linkPoints[_segmentIndex - 2].dx == linkPoints[_segmentIndex - 1].dx) &&
              (linkPoints[_segmentIndex].dx == linkPoints[_segmentIndex + 1].dx)) {
            _segmentVerticalMove = true;
            print('DY RECT');
          }
        } else if (linkPoints[_segmentIndex - 1].dx == linkPoints[_segmentIndex].dx) {
          if ((linkPoints[_segmentIndex - 2].dy == linkPoints[_segmentIndex - 1].dy) &&
              (linkPoints[_segmentIndex].dy == linkPoints[_segmentIndex + 1].dy)) {
            _segmentHorisontalMove = true;
            print('DX RECT');
          }
        }
        print('RECT');
      }

      if (!_segmentVerticalMove && !_segmentHorisontalMove) {
      canvasWriter.model.insertLinkMiddlePoint(
          linkId, details.localFocalPoint, _segmentIndex);
      canvasWriter.model.updateLink(linkId);}
    }
    print('onLinkScaleStart');
  }

  @override
  onLinkScaleUpdate(String linkId, ScaleUpdateDetails details) {
    if (_segmentIndex != null) {

      if (!_segmentVerticalMove && !_segmentHorisontalMove) {
      canvasWriter.model.setLinkMiddlePointPosition(
          linkId, details.localFocalPoint, _segmentIndex);
      canvasWriter.model.updateLink(linkId);

      rightAngleZoneStumble(_segmentIndex, linkId, details.localFocalPoint);
      } else {
        Offset focalPoint = canvasReader.state.fromCanvasCoordinates(details.localFocalPoint);
        List<Offset> linkPoints = canvasReader.model.getLink(linkId).linkPoints;
        Offset segmentStart = Offset(0, 0);
        Offset segmentEnd = Offset(0, 0);
        if (_segmentVerticalMove) {
          segmentStart = Offset(linkPoints[_segmentIndex - 1].dx, focalPoint.dy);
          segmentEnd = Offset(linkPoints[_segmentIndex].dx, focalPoint.dy);
        } else if (_segmentHorisontalMove) {
          segmentStart = Offset(focalPoint.dx, linkPoints[_segmentIndex - 1].dy);
          segmentEnd = Offset(focalPoint.dx, linkPoints[_segmentIndex].dy);
        }
        segmentStart = canvasReader.state.toCanvasCoordinates(segmentStart);
        segmentEnd = canvasReader.state.toCanvasCoordinates(segmentEnd);

        canvasWriter.model.setLinkMiddlePointPosition(
            linkId, segmentStart, _segmentIndex - 1);
        canvasWriter.model.setLinkMiddlePointPosition(
            linkId, segmentEnd, _segmentIndex);
        canvasWriter.model.updateLink(linkId);
      }
    }
    //print('onLinkScaleUpdate');
  }

  @override
  onLinkScaleEnd(String linkId, ScaleEndDetails details) {
    if (_segmentIndex != null) {
      rightAngleZoneUpdate(_segmentIndex, linkId);
    }
    _segmentHorisontalMove = false;
    _segmentVerticalMove = false;
  }
}
