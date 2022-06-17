import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';
import 'package:flutterchallange/src/products/domain/repositories/products_repository.dart';

abstract class IUpdateProductUsecase {
  Future<void> call(ProductEntity product);
}

class UpdateProductUsecaseImp extends IUpdateProductUsecase {
  IProductRepository productRepository;
  UpdateProductUsecaseImp(this.productRepository);

  @override
  Future<void> call(ProductEntity product) async {
    productRepository.updateProduct(product);
  }
}
