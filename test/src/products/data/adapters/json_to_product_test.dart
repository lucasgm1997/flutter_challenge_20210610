import 'package:flutterchallange/src/products/data/adapters/json_to_product.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return a object of type product.', () {
    final Map<String, dynamic> productMap = {
      'id': 'any_id',
      'title': 'any_title',
      'filename': 'any_photo',
      'rating': 0,
      'type': 'dairy',
      'price': 0.0,
      'description': 'any_description',
      'height': 400,
      'width': 200,
    };

    final ProductEntity productEntity = JsonToProduct.fromJson(productMap);

    expect(productEntity, isA<ProductEntity>());
    expect(productEntity.id, 'any_id');
    expect(productEntity.title, 'any_title');
    expect(productEntity.filename, 'any_photo');
    expect(productEntity.rating, 0);
    expect(productEntity.type, EProductType.dairy);
    expect(productEntity.price, 0.0);
     expect(productEntity.height, 400);
    expect(productEntity.width, 200);
    expect(productEntity.description, 'any_description');

  });

  test('Should convert a object of type product to map', () {
    EProductType actualType = EProductType.bakery;

    final productEntity = ProductEntity(
      dateTime: DateTime.now(),
      id: 'any_id',
      title: 'any_title',
      filename: 'any_photo',
      price: 0.0,
      rating: 0,
      type: actualType,
      description: 'any_description',
      height: 400,
      width: 200,
    );

    final Map<String, dynamic> productMap = JsonToProduct.toJson(productEntity);
    expect(productMap['id'], 'any_id');
    expect(productMap['title'], 'any_title');
    expect(productMap['filename'], 'any_photo');
    expect(productMap['rating'], 0);
    expect(productMap['type'], 'bakery');
    expect(productMap['price'], 0.0);
    expect(productMap['height'], 400);
    expect(productMap['width'], 200);
    expect(productMap['description'], 'any_description');
  });
}
