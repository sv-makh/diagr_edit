import 'dart:math' as math;
import 'package:diagr_edit/pages/ports/widget/menu_widget.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';
import 'package:diagr_edit/pages/ports/policy/my_policy_set.dart';

class DiagramEditorPorts extends StatefulWidget {
  const DiagramEditorPorts({super.key});

  @override
  State<DiagramEditorPorts> createState() => _DiagramEditorPortsState();
}

class _DiagramEditorPortsState extends State<DiagramEditorPorts> {
  MyPolicySet myPolicySet = MyPolicySet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: Text('ports'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DiagramEditor(
              diagramEditorContext: DiagramEditorContext(
                policySet: myPolicySet,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: MenuWidget(policySet: myPolicySet),
          ),
        ],
      ),
    );
  }
}
