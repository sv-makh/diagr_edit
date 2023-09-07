import 'package:flutter/material.dart';
import 'package:diagr_edit/pages/ports/policy/my_policy_set.dart';


class PortSwitch extends StatefulWidget {
  final MyPolicySet policySet;

  const PortSwitch({super.key, required this.policySet});

  @override
  State<PortSwitch> createState() => _PortSwitchState();
}

class _PortSwitchState extends State<PortSwitch> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 100,
      child: GestureDetector(
        onTap: () {
          widget.policySet.switchPortsVisibility();
          setState(() {});
        },
        child: Container(
          width: 96,
          height: 32,
          color: Colors.amber,
          child: Center(
              child: Text(widget.policySet.arePortsVisible
                  ? 'hide ports'
                  : 'show ports')),
        ),
      ),
    );
  }
}
