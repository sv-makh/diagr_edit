import 'package:diagram_editor/src/abstraction_layer/policy/base/link_joints_policy.dart';
import 'package:flutter/material.dart';

import 'custom_state_policy.dart';

mixin MyLinkJointControlPolicy implements LinkJointPolicy, CustomStatePolicy {
  @override
  onLinkJointLongPress(int jointIndex, String linkId) {
    canvasWriter.model.removeLinkMiddlePoint(linkId, jointIndex);
    canvasWriter.model.updateLink(linkId);
    print('onLinkJointLongPress');

    hideLinkOption();
  }

  @override
  onLinkJointScaleUpdate(
      int jointIndex, String linkId, ScaleUpdateDetails details) {
    canvasWriter.model.setLinkMiddlePointPosition(
        linkId, details.localFocalPoint, jointIndex);
    canvasWriter.model.updateLink(linkId);
    print('onLinkJointScaleUpdate');
    hideLinkOption();
  }
}