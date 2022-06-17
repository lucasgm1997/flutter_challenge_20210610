import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

abstract class IProductDataSource {
  Stream<List<Map<String, dynamic>>> getAllProducts();

  Future<void> removeProduct(ProductEntity product);
}
