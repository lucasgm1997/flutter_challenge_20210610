import 'package:flutter_challenge_20210610/src/products/domain/entities/product_entity.dart';

class JsonToProduct {
  static ProductEntity fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      photo: json['photo'],
      price: json['price'],
      rating: json['rating'],
      title: json['title'],
      type: EProductType.values.firstWhere((element) => element.name == json['type']),
    );
  }

  static Map<String, dynamic> toJson(ProductEntity entity) {
    return {
      'id': entity.id,
      'photo': entity.photo,
      'price': entity.price,
      'rating': entity.rating,
      'title': entity.title,
      'type': entity.type
    };
  }
}
