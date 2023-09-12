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

  @override
  onLinkScaleStart(String linkId, ScaleStartDetails details) {
    canvasWriter.model.hideAllLinkJoints();
    canvasWriter.model.showLinkJoints(linkId);
    _segmentIndex = canvasReader.model
        .determineLinkSegmentIndex(linkId, details.localFocalPoint);
    if (_segmentIndex != null) {
      canvasWriter.model.insertLinkMiddlePoint(
          linkId, details.localFocalPoint, _segmentIndex);
      canvasWriter.model.updateLink(linkId);
    }
    print('onLinkScaleStart');
  }

  @override
  onLinkScaleUpdate(String linkId, ScaleUpdateDetails details) {
    if (_segmentIndex != null) {
      canvasWriter.model.setLinkMiddlePointPosition(
          linkId, details.localFocalPoint, _segmentIndex);
      canvasWriter.model.updateLink(linkId);

      rightAngleZoneStumble(_segmentIndex, linkId, details.localFocalPoint);
    }
    print('onLinkScaleUpdate');
  }

  @override
  onLinkScaleEnd(String linkId, ScaleEndDetails details) {
    if (_segmentIndex != null) {
      rightAngleZoneUpdate(_segmentIndex, linkId);
    }
  }
}
