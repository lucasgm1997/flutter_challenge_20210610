import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

abstract class IProductRepository {
  Stream<List<ProductEntity>> getFirstListProduct();

  Future<void> removeProduct(ProductEntity product);

  Future<void> updateProduct(ProductEntity product);

  Stream<List<ProductEntity>> nextListProducts();
}