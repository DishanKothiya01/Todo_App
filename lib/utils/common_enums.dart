
///* APP BUTTON VARIANTS
enum ButtonType {
  elevated(id: 0, label: "Elevated", slug: "elevated"),
  gradient(id: 1, label: "Gradient", slug: "gradient"),
  outline(id: 2, label: "Outline", slug: "outline");

  final int id;
  final String label;
  final String slug;

  const ButtonType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static ButtonType fromSlug(String slug) {
    return ButtonType.values.firstWhere((e) => e.slug == slug);
  }
}



