import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/craft_element.dart';
class UnlockedElementService {
  static const _storageKey = 'unlocked_elements';

  static List<CraftElement> _unlocked = [];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      _unlocked = [...CraftElement.basicElements];
      await _save();
    } else {
      final List<dynamic> decoded = jsonDecode(jsonString);
      _unlocked = decoded
          .map((e) => CraftElement(
                id: e['id'],
                name: e['name'],
                icon: e['icon'],
              ))
          .toList();
    }
  }

  static Future<void> unlockElement(CraftElement element) async {
    if (_unlocked.any((e) => e.id == element.id)) return;

    _unlocked.add(element);
    await _save();
  }

  static List<CraftElement> getUnlockedElements() {
    return _unlocked;
  }

  static Future<void> resetElements() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    _unlocked = [...CraftElement.basicElements];
    await _save();
  }

  static Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _unlocked
        .map((e) => {'id': e.id, 'name': e.name, 'icon': e.icon})
        .toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }
}
