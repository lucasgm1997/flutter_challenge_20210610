import 'package:flutterchallange/src/products/data/adapters/json_to_product.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return a object of type product.', () {
    final Map<String, dynamic> productMap = {
      'id': 'any_id',
      'title': 'any_title',
      'photo': 'any_photo',
      'rating': 0.0,
      'type': 'type1',
      'price': 0.0,
    };

    final ProductEntity productEntity = JsonToProduct.fromJson(productMap);

    expect(productEntity, isA<ProductEntity>());
    expect(productEntity.id, 'any_id');
    expect(productEntity.title, 'any_title');
    expect(productEntity.photo, 'any_photo');
    expect(productEntity.rating, 0.0);
    expect(productEntity.type, EProductType.type1);
    expect(productEntity.price, 0.0);
  });

  test('Should convert a object of type product to map', () {
    final productEntity = ProductEntity(
      id: 'any_id',
      title: 'any_title',
      photo: 'any_photo',
      price: 0.0,
      rating: 0.0,
      type: EProductType.type2,
    );

    final Map<String, dynamic> productMap = JsonToProduct.toJson(productEntity);

    expect(productMap['id'], 'any_id');
    expect(productMap['title'], 'any_title');
    expect(productMap['photo'], 'any_photo');
    expect(productMap['rating'], 0.0);
    expect(productMap['type'], EProductType.type2);
    expect(productMap['price'], 0.0);
  });
}
