import 'package:craft_everything/providers/craft_provider.dart';
import 'package:craft_everything/services/unlock_elements_service.dart';
import 'package:craft_everything/widgets/craft_element_widget.dart';
import 'package:flutter/material.dart';

import '../models/craft_element.dart';

class CraftScreen extends StatefulWidget {
  const CraftScreen({super.key});

  @override
  State<CraftScreen> createState() => _CraftScreenState();
}

class _CraftScreenState extends State<CraftScreen> {
  CraftElement? leftElement;
  CraftElement? rightElement;
  CraftElement? result;

  List<CraftElement> _elements = UnlockedElementService.getUnlockedElements();

  void addElement(CraftElement element) async {
    setState(() {
      if (leftElement == null) {
        leftElement = element;
        result = null;
      } else {
        rightElement ??= element;
      }
    });

    if (rightElement == null) return;

    result = await CraftProvider.craft(
      leftElement?.id ?? "",
      rightElement?.id ?? "",
    );

    if (result != null) {
      await UnlockedElementService.unlockElement(result!);
      _elements = UnlockedElementService.getUnlockedElements();
    }

    setState(() {
      rightElement = null;
      leftElement = null;
    });
  }

  void _resetElement() async {
    await UnlockedElementService.resetElements();
    result = null;
    leftElement = null;
    rightElement = null;

    setState(() {
      _elements = UnlockedElementService.getUnlockedElements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Craft Everything'),
        actions: [IconButton(onPressed: _resetElement, icon: Icon(Icons.delete))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CraftElementWidget(leftElement),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('+', style: TextStyle(fontSize: 28)),
                ),
                CraftElementWidget(rightElement),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('=', style: TextStyle(fontSize: 28)),
                ),
                CraftElementWidget(result),
              ],
            ),
            const SizedBox(height: 32),

            Expanded(
              child: GridView.builder(
                itemCount: _elements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final element = _elements[index];
                  return GestureDetector(
                    onTap: () => addElement(element),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${element.icon}\n${element.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
