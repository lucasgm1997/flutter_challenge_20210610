import 'package:flutter_challenge_20210610/src/products/domain/entities/product_entity.dart';
import 'package:flutter_challenge_20210610/src/products/domain/repositories/products_repository.dart';

abstract class IGetAllProductsUseCase {
  Stream<List<ProductEntity>> call();
}

class GetAllProductsUseCaseImp implements IGetAllProductsUseCase {
  final IProductRepository _repository;
  GetAllProductsUseCaseImp(this._repository);

  @override
  Stream<List<ProductEntity>> call() {
    return _repository.getAllProducts();
  }
}
