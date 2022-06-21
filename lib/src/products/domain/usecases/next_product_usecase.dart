import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class INextProductUsecase {
  Stream<List<ProductEntity>> call();
}

class NextProductUsecaseImp implements INextProductUsecase {
  final IProductRepository _repository;
  NextProductUsecaseImp(this._repository);

  @override
  Stream<List<ProductEntity>> call()  {
    return _repository.nextListProducts();
  }
}
