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
                'title': 'any_title',
                'photo': 'any_photo',
                'rating': 0.0,
                'type': 'type1',
                'price': 0.0,
              }
            ]));
    
    final repository = ProductRepositoryImp(datasource);

    expect(repository.getAllProducts(), emits(isA<List<ProductEntity>>()));
  });
}
