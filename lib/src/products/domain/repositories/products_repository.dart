import 'package:flutter_challenge_20210610/src/products/domain/entities/product_entity.dart';

abstract class IProductRepository {
  Stream<List<ProductEntity>> getAllProducts();
}