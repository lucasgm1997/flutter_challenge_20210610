class ProductEntity {
  final String id;
  final String photo;
  final String title;
  final EProductType type;
  final double rating;
  final double price;

  ProductEntity(
      {required this.id,
      required this.photo,
      required this.title,
      required this.type,
      required this.rating,
      required this.price});
}

enum EProductType {
  type1,
  type2,
  type3,
}

