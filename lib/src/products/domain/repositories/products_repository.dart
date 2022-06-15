import 'package:flutterchallange/src/products/domain/entities/product_entity.dart';

abstract class IProductRepository {
  Stream<List<ProductEntity>> getAllProducts();
}