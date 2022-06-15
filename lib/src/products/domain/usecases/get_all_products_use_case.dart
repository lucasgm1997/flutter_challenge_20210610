import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

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
