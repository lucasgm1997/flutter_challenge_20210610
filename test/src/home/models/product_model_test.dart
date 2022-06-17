import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchallange/src/home/models/product_model.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

void main() {
  test(
      'Should return a new product model with copying only a attribut at a time',
      () {
    var productModel = ProductModel(
      id: 'any_id',
      title: 'any_title',
      filename: 'any_photo',
      description: 'any_description',
      price: 0.0,
      rating: 0,
      type: EProductType.bakery,
      height: 400,
      width: 200,
    );

    productModel = productModel.copyWith(id: 'new id');
    productModel = productModel.copyWith(title: 'new title');
    productModel = productModel.copyWith(filename: 'new filename');
    productModel = productModel.copyWith(description: 'new description');
    productModel = productModel.copyWith(price: 0.0);
    productModel = productModel.copyWith(rating: 0);
    productModel = productModel.copyWith(type: EProductType.bakery);
    productModel = productModel.copyWith(height: 400);
    productModel = productModel.copyWith(width: 200);

    expect(productModel.id, 'new id');
    expect(productModel.title, 'new title');
    expect(productModel.filename, 'new filename');
    expect(productModel.description, 'new description');
    expect(productModel.price, 0.0);
    expect(productModel.rating, 0);
    expect(productModel.type, EProductType.bakery);
    expect(productModel.height, 400);
    expect(productModel.width, 200);
  });
}
