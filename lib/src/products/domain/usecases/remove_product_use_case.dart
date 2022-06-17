import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class IRemoveProductUsecase {
  Future<void> removeProduct(ProductEntity product);
  
}

class RemoveProductUsecaseImp implements IRemoveProductUsecase {

  IProductRepository productRepository;
  RemoveProductUsecaseImp(this.productRepository);

  @override
  Future<void> removeProduct(ProductEntity product) async {
    productRepository.removeProduct(product);
  }

}