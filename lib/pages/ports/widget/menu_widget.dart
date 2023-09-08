import 'package:flutter/material.dart';
import 'package:diagr_edit/pages/ports/policy/my_policy_set.dart';

class MenuWidget extends StatelessWidget {
  MyPolicySet policySet;

  MenuWidget({super.key, required this.policySet});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: const Text(
            "delete all",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          onTap: () {
            policySet.deleteAllComponents();
          },
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            policySet.arePortsVisible ? 'hide ports' : 'show ports',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          onTap: () {
            policySet.switchPortsVisibility();
          },
        ),
      ],
      icon: const Icon(Icons.menu),
    );
  }
}
