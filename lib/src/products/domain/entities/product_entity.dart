class ProductEntity {
  final String id;
  final String filename;
  final String title;
  final String description;
  final int height;
  final int width;
  final EProductType type;
  final int rating;
  final double price;

  ProductEntity(
      {required this.filename,
      required this.description,
      required this.height,
      required this.width,
      required this.id,
      required this.title,
      required this.type,
      required this.rating,
      required this.price});
}

enum EProductType {
  dairy,
  fruit,
  vegetable,
  bakery,
  vegan,
  meat,
}
