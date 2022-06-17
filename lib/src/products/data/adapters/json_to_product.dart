import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

class JsonToProduct {
  static ProductEntity fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      filename: json['filename'],
      price: json['price'],
      rating: json['rating'],
      title: json['title'],
      description: json['description'],
      height: json['height'],
      width: json['width'],
      type: EProductType.values
          .firstWhere((element) => element.name == json['type']),
    );
  }

  static Map<String, dynamic> toJson(ProductEntity entity) {
    return {
      'id': entity.id,
      'filename': entity.filename,
      'price': entity.price,
      'rating': entity.rating,
      'title': entity.title,
      'type': entity.type.name,
      'description': entity.description,
      'height': entity.height,
      'width': entity.width,
    };
  }
}
