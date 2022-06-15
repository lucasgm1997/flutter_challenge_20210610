import 'package:flutter_challenge_20210610/src/products/domain/entities/product_entity.dart';
import 'package:flutter_challenge_20210610/src/products/domain/repositories/products_repository.dart';
import 'package:flutter_challenge_20210610/src/products/domain/usecases/get_all_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/mocks.dart';

void main() {
  test('Should return a list of products', () {
    final IProductRepository productRepositoryMock;
    productRepositoryMock = ProductRepositoryMock();

    final productEntity = ProductEntityMock();

    when(() => productRepositoryMock.getAllProducts())
        .thenAnswer((invocation) => Stream.value([productEntity]));

    final uecsase = GetAllProductsUseCaseImp(productRepositoryMock);

    expect(uecsase.call(), emits(isA<List<ProductEntity>>()));
  });
}
