import 'dart:math' as math;

import 'package:diagr_edit/pages/diagram_editor_page.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('ports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DiagramEditor(
          diagramEditorContext: DiagramEditorContext(
            policySet: myPolicySet,
          ),
        ),
      ),
    );
  }
}

