import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class IRemoveProductUsecase {
  Future<void> call(ProductEntity product);
}

class RemoveProductUsecaseImp implements IRemoveProductUsecase {
  IProductRepository productRepository;
  RemoveProductUsecaseImp(this.productRepository);

  @override
  Future<void> call(ProductEntity product) async {
    productRepository.removeProduct(product);
  }
}
