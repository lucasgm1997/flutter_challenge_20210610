import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class IGetFirstListProductUseCase {
  Stream<List<ProductEntity>> call();
}

class GetAllProductsUseCaseImp implements IGetFirstListProductUseCase {
  final IProductRepository _repository;
  GetAllProductsUseCaseImp(this._repository);

  @override
  Stream<List<ProductEntity>> call() {
    return _repository.getFirstListProduct();
  }
}
