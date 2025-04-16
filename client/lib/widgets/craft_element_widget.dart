import 'package:flutter/material.dart';

import '../models/craft_element.dart';

class CraftElementWidget extends StatelessWidget {
  final CraftElement? element;
  const CraftElementWidget(this.element, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(element?.icon ?? '❓', style: const TextStyle(fontSize: 32)),
          if (element?.name != null)
            Text(element?.name ?? "", style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
