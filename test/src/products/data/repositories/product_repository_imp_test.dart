import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterchallange/src/home/models/product_model.dart';
import 'package:flutterchallange/src/products/data/repositories/product_repository_imp.dart';
import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/mocks.dart';

void main() {
  test('Should receive a stream of map and convert to stream of ProductEntity',
      () {
    final datasource = ProductDataSourceMock();

    when(() => datasource.getAllProducts())
        .thenAnswer((invocation) => Stream.value([
              {
                'id': 'any_id',
                'dateTime': Timestamp.fromDate(DateTime.now()),
                'title': 'any_title',
                'filename': 'any_photo',
                'rating': 0,
                'type': 'dairy',
                'price': 0.0,
                'description': 'any_description',
                'height': 400,
                'width': 200,
              }
            ]));

    final repository = ProductRepositoryImp(datasource);

    expect(repository.getAllProducts(), emits(isA<List<ProductEntity>>()));
  });

  test('Should remove a product', () {
    final datasource = ProductDataSourceMock();

    final product = ProductModel.empty();

    when(() => datasource.removeProduct(any()))
        .thenAnswer((invocation) => Future.value());

    final repository = ProductRepositoryImp(datasource);

    expect(repository.removeProduct(product), completes);
  });

  test('Should update a product', () {
    final datasource = ProductDataSourceMock();

    final product = ProductModel.empty();

    when(() => datasource.updateProduct(any()))
        .thenAnswer((invocation) => Future.value());

    final repository = ProductRepositoryImp(datasource);

    expect(repository.updateProduct(product), completes);
  });
}
