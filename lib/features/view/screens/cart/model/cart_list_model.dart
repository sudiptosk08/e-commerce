class CartItem {
  final String id;
  final dynamic quantity;
  final String name;
  final String categoryName;
  final String subCategoryName;
  final String size;
  final String color;
  final dynamic price;
  final String brand;
  final String thumbnail;

  CartItem({
    required this.id,
    required this.quantity,
    required this.name,
    required this.categoryName,
    required this.subCategoryName,
    required this.size,
    required this.color,
    required this.price,
    required this.brand,
    required this.thumbnail,
  });
}
