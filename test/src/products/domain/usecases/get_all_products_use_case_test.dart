import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';
import 'package:flutterchallange/src/products/domain/usecases/get_first_list_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/mocks.dart';

void main() {
  test('Should return a list of products', () {
    final IProductRepository productRepositoryMock;
    productRepositoryMock = ProductRepositoryMock();

    final productEntity = ProductEntityMock();

    when(() => productRepositoryMock.getFirstListProduct())
        .thenAnswer((invocation) => Stream.value([productEntity]));

    final uecsase = GetAllProductsUseCaseImp(productRepositoryMock);

    expect(uecsase.call(), emits(isA<List<ProductEntity>>()));
  });
}
