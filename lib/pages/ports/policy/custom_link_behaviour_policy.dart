/*
import 'dart:ui';

import 'package:diagram_editor/diagram_editor.dart';

import 'custom_state_policy.dart';

mixin CustomLinkBehaviourPolicy implements PolicySet, CustomStatePolicy {
  void breakLine(String linkId) {
    final linkData = canvasReader.model.getLink(linkId);
    final sourceComponentPosition =
        canvasReader.model.getComponent(linkData.sourceComponentId).position;
    final sourceComponentSize =
        canvasReader.model.getComponent(linkData.sourceComponentId).size;
    final targetComponentPosition =
        canvasReader.model.getComponent(linkData.targetComponentId).position;
    final targetComponentSize =
        canvasReader.model.getComponent(linkData.targetComponentId).size;
    if (targetComponentPosition.dx + targetComponentSize.width >=
            sourceComponentPosition.dx - sourceComponentSize.width &&
        sourceComponentPosition.dx + sourceComponentSize.width * 2 >=
            targetComponentPosition.dx) {
      _buildBottomTopLink(linkData, sourceComponentPosition,
          sourceComponentSize, targetComponentPosition, targetComponentSize);
    } else if (sourceComponentPosition.dx > targetComponentPosition.dx &&
        (sourceComponentPosition.dy < targetComponentPosition.dy ||
            sourceComponentPosition.dy > targetComponentPosition.dy)) {
      _buildBottomTopLeftLink(linkData, sourceComponentPosition,
          sourceComponentSize, targetComponentPosition, targetComponentSize);
    } else if (sourceComponentPosition.dx < targetComponentPosition.dx &&
        (sourceComponentPosition.dy < targetComponentPosition.dy ||
            sourceComponentPosition.dy > targetComponentPosition.dy)) {
      _buildBottomTopRightLink(linkData, sourceComponentPosition,
          sourceComponentSize, targetComponentPosition, targetComponentSize);
    }
  }

  void _buildBottomTopLeftLink(
    LinkData linkData,
    Offset sourceComponentPosition,
    Size sourceComponentSize,
    Offset targetComponentPosition,
    Size targetComponentSize,
  ) {
    linkData.setStart(Offset(sourceComponentPosition.dx,
        sourceComponentPosition.dy + sourceComponentSize.height / 2));
    linkData.insertMiddlePoint(
        Offset((sourceComponentPosition.dx + targetComponentPosition.dx) / 2,
            sourceComponentPosition.dy + sourceComponentSize.height / 2),
        1);
    linkData.insertMiddlePoint(
        Offset((sourceComponentPosition.dx + targetComponentPosition.dx) / 2,
            targetComponentPosition.dy + targetComponentSize.height / 2),
        2);
    linkData.setEnd(Offset(
        targetComponentPosition.dx + targetComponentSize.width,
        targetComponentPosition.dy + targetComponentSize.height / 2));
  }

  void _buildBottomTopRightLink(
      LinkData linkData,
      Offset sourceComponentPosition,
      Size sourceComponentSize,
      Offset targetComponentPosition,
      Size targetComponentSize) {
    linkData.setStart(Offset(
        sourceComponentPosition.dx + sourceComponentSize.width,
        sourceComponentPosition.dy + sourceComponentSize.height / 2));
    linkData.insertMiddlePoint(
        Offset((targetComponentPosition.dx + sourceComponentPosition.dx) / 2,
            sourceComponentPosition.dy + sourceComponentSize.height / 2),
        1);
    linkData.insertMiddlePoint(
        Offset((targetComponentPosition.dx + sourceComponentPosition.dx) / 2,
            targetComponentPosition.dy + targetComponentSize.height / 2),
        2);
    linkData.setEnd(Offset(targetComponentPosition.dx,
        targetComponentPosition.dy + targetComponentSize.height / 2));
  }

  void _buildBottomTopLink(
      LinkData linkData,
      Offset sourceComponentPosition,
      Size sourceComponentSize,
      Offset targetComponentPosition,
      Size targetComponentSize) {
    linkData.setStart(
      Offset(
          sourceComponentPosition.dx + sourceComponentSize.width / 2,
          sourceComponentPosition.dy +
              (sourceComponentPosition.dy > targetComponentPosition.dy
                  ? 0
                  : sourceComponentSize.height)),
    );
    linkData.insertMiddlePoint(
        Offset(sourceComponentPosition.dx + sourceComponentSize.width / 2,
            (sourceComponentPosition.dy + targetComponentPosition.dy) / 2),
        1);
    linkData.insertMiddlePoint(
        Offset(targetComponentPosition.dx + targetComponentSize.width / 2,
            (sourceComponentPosition.dy + targetComponentPosition.dy) / 2),
        2);
    linkData.setEnd(
      Offset(
        targetComponentPosition.dx + targetComponentSize.width / 2,
        (sourceComponentPosition.dy < targetComponentPosition.dy
            ? targetComponentPosition.dy
            : targetComponentPosition.dy + sourceComponentSize.height),
      ),
    );
  }
}
*/
