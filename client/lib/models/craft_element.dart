class CraftElement {
  static List<CraftElement> get basicElements {
    return [
      CraftElement(id: "fire", name: "Fire", icon: "🔥"),
      CraftElement(id: "water", name: "Water", icon: "💧"),
      CraftElement(id: 'earth', name: 'Earth', icon: '🌎'),
      CraftElement(id: 'wind', name: 'Wind', icon: '🌬️'),
      CraftElement(id: 'life', name: 'Life', icon: '🧬'),
    ];
  }

  final String id;
  final String name;
  final String icon;

  CraftElement({required this.id, required this.name, required this.icon});

  factory CraftElement.fromJson(Map<String, dynamic> json) {
    return CraftElement(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
    );
  }
}
